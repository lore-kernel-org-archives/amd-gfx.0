Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD56EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 14:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A436310E509;
	Thu, 15 Jun 2023 14:52:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BBC10E509
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 14:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwTHPdO/1T59suixMq2KAttVyf0X7Lz3LUUgXJ7Olx5PXZguis0Thg2S140G1+zdujnlwRyROeA1X/bcxHHAqZuj9jH0KkGxQZ/1D4C+z3aTRExe+uBQkPGATj3cGanX+ewpiVJ/FihIH6brzQpJfgcj64z1+iHtzj13hjX/V0rzr8Wgro0ooKeUdAg07bGe9nkS1XT5zFlrNNP9X7LY2HSq2gLkgyoAd91zHPvfhfWzmGsKsc1GBCj0XKwsKQXnyizO+XCV2oWM3gqeIiy86KG4iYx8aui6pFmU97qUeYO504F9Q50UweU09r15hTr1x1ToCLPj+yx+0Y7Dat6IBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TAtzcr4Hntv2k3AkVbYOCQurFUYPKlZu08fpFXkEu4=;
 b=XsdootnwUMFhWvO+wCrzZlFX2NqArIho4Z/6g+K468vnJfaiU6TvymnM/Ve9VhLUTJoVswGN+5ooO1Xbnv++K+4qdrNFB4vLWna15FugjA3TJfjgygcGNOR0xSf0zU5gBoM5CNcaGfXYk052yQcspERD5BdaDUITNNWVldpYRlYee+2DPTUVycw0DqQ/WuwkcNRSMn/QHW53sZm2NA2lMffNmL4eiW8JQVC+1zQSExtRf9GWcXCq6t6BiZJ3suWc1VGL7Xm6dblimUhDkJuCBXatcDGM+CEvwr3+qnjNk9haOPwie1dlNHASn5PTOKsb4l6OAxu+T1A/dPtWvjDEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TAtzcr4Hntv2k3AkVbYOCQurFUYPKlZu08fpFXkEu4=;
 b=4CKSMRS/WhMNsbIuZ2wE5SpndAJT3B5FJ8bRak+zSyBCikCtlxTzyjwq+u9mShakM1uiHUvHXWsblK9ImITmbsRpX0aQBoD7XW83zBqDHMlnk2jEFn/nxaoEGVGNsfSziLrWky9FzUt6QAfA42iOWwKKHGMP9uCkI6ZrGW/IFMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 14:52:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 14:52:43 +0000
Message-ID: <181a6a0b-b872-a693-229a-0d1fceef13e1@amd.com>
Date: Thu, 15 Jun 2023 10:52:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] drm/amdgpu: Implement new dummy vram manager
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230509220144.474723-1-alexander.deucher@amd.com>
 <20230509220144.474723-2-alexander.deucher@amd.com>
 <851ebfd9-bad6-8a11-5f73-44b183d2cb36@gmail.com>
 <a17ccb9e-7798-fc33-ff0e-53e96511a92a@amd.com>
 <cca4179c-bf58-b4f5-60b1-698da27fe508@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <cca4179c-bf58-b4f5-60b1-698da27fe508@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::41) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: d1198e69-f4f0-43cf-09f2-08db6db02c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBGnaYZLzrdMB/+XOFYjHYjgOTDfa35JH9w0kr4+qa1A//lv1XbKJSaF1guIaaKPjI2CzMMq5xFieQNXsUnj/C1czxjtWAddZa/8kYtAQXt8O2JejKGWwUq7SfGmXDopPHiKV6WYwJ5uVNUD24s9Q1mynWMV2fLSrZQ/8om6kS8EFsKfhqipRoBPVte+4HEMtK1qer8hXndNKctLMEDcqsL7eC9T7jQY/3fgWWTZUvI3bjg0kzNPQ5cNV+zVm0EXy2l5bNvUTEoF5mogvr9IoIpY1EYLr0VNvz5gejpR5AQE7rAxixGNLKRzj+y0zava5XWgTPZbzQ1x7ifn1sm1fYG4KwT1jPT8W3Q/hmbF4c35RRmKCwShIOaOLEuhPfsh460vneouBIqMnjmR+s727kedSi0JTLG6HyfSj+LRkOH9pF19TNYB0n7UniXkkW32oCttrqL5w9XtX/q57t5zMRxpQwyrwMVU4vziQlP0uBP6NJtAh3B5pN/W0uYkYcSX3c1/0eRmwiagNNxyC/eJxx1ts3beadT2Iz4O+l24DtGhjg04cNIQ0eXcjvssDN5Lq+iXIFnMYOgFWy7NifYpvkiMZjrwBYR6Pq/2Aqlk8rBaJe26/QC4WFbjI1Mllh6csIchD6t1agnkmUoq7OoI3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(8676002)(31686004)(5660300002)(86362001)(31696002)(38100700002)(83380400001)(8936002)(316002)(44832011)(41300700001)(66556008)(4326008)(66946007)(66476007)(66574015)(110136005)(2616005)(186003)(6512007)(6506007)(478600001)(36756003)(26005)(2906002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3daMTlKQjBBRHQ2bU5jL2k5QTQ5aDhPZmFHaDhNRGtPOSt2S3p4c1p1bHRQ?=
 =?utf-8?B?N0RRd1kwNlBhWTNkVHFkUTE3ZDZZRklCTG1xRUxNUytTZVhIVkI5dlRqMXA2?=
 =?utf-8?B?QWJmb1pYVnJiWWZoNlpJUmpxT0tiTk0rMlkxcUJQMXdza3RqcjRRaWh5dlRV?=
 =?utf-8?B?T3BGby85WHVwWjVPc3NVS3ZjcTEyM2d4cXdMeXhURyt3Tnc2SjNNdzJFWE00?=
 =?utf-8?B?Wkp5MWJETTlJL1pva0duTWN4V2lqSWlRaFVTUWxteUd0NkRyRlRRSjBQUXJx?=
 =?utf-8?B?c3JWUjJkOTFOY3MvTU9PMkNxK1dEMkUycnVjYzNjZEhESnZud3ZURGJIak5j?=
 =?utf-8?B?Qzk1c2syQzFlRTdncXA3NUZOb2NZTjRNN0VvV2x4Ymx2WXpBTjRMakZWUktv?=
 =?utf-8?B?dmpxRmhyVTZoQXdQS0pnVmh6dGtQMjlXWjgvRlQ4UkMxM2xGbU4vOHpjR0ky?=
 =?utf-8?B?TVhNK1cwcFZCaHNmSXByOW9iZ2ZpeEhxbVB3U0xxcWozZVJaRm5DdDhpUEtD?=
 =?utf-8?B?dlRVRUN2TnFJMGQ2cVIzTmU5aWM1NzNXalVOd1I0emdmM3o4SGJ1UjU0R1B3?=
 =?utf-8?B?L2VXYlZNZ1l3V0xuaTdqZ016R3V1L29MNk1IWU93eTBjMzkwZHlsSGdpSjZM?=
 =?utf-8?B?VVJQdzBrSTRyTEtPb1N0L3cvVWpkZVBWK2hiOGhmSEszUy83cEtDQ0h3ZUZZ?=
 =?utf-8?B?ZkczU2lmNmxpTVRjRmh1YlhhVjlBekFILzkyaTc3OWxYVU5CZXpXOWY3RFpB?=
 =?utf-8?B?RjlaUWIwYmhpWnk2dng4ZWI4b0lkV0oxMi9ud3BzRnc1eWlDa1BNV01rdERk?=
 =?utf-8?B?L2lyd3NuNjRDdS9vN01sUzNUS0o5WGR1OVBhUU1QM3FOWjZoV3VaWkFZdFY1?=
 =?utf-8?B?TnVEV0FSVnhhdElYMjNHQW4xR3FWWTFZMGFtOFRGY1NNT3p6OWhoc0I0TE9Q?=
 =?utf-8?B?ZW5PUElha2FONEVVYWplTTR3S0lJVVAvZVg1VnBvZVA0RVhZUk91dkRjUld4?=
 =?utf-8?B?VFJOQTRZam5yT3IyRzFrdnlXNnkxYklrZW9TSGxLd0xvRkt0QmwwUTFnYVA0?=
 =?utf-8?B?NXpXam4xWFlLWGxiODVxVG5NUE5HdjdHZDRGUXVnbjY3OXdCb2FkUDZraG9V?=
 =?utf-8?B?am9QaHVJM0g3WmtoYWJYclIyNjdkei96emlERmNvSzlZU1Q2US9EdXZ0Mnph?=
 =?utf-8?B?dHZIblZoSDZraHN1b3M2cTFwMWQzYUdYU2ZSbVZHM3BxbU12aDJJZnl1RFJz?=
 =?utf-8?B?Rk5jdUt4Ry9OYlFLK212MlJHL1o3RVhHWHpncnlJNXVoaEFEMFFTNnRLcmRK?=
 =?utf-8?B?TjdMc2N1RGFxTGE5cm9oU09JS2RiZy9TeE9Nem1CQmFYdVkzYkJabHg0UUUz?=
 =?utf-8?B?MHMzZXhSY2lTdk5FT3lKVGxJcWtyYk02Qm45bHI1QisySndBQTg0SWtHUEQw?=
 =?utf-8?B?enV2K1ZzNDlSZnIxanVOeGtBOTRadFNvbFZHeERzWm1hSGVuMWw1ejdDN1Zm?=
 =?utf-8?B?YUYxamp5OS9YS0tQOEZ3TFp3RnlPZE1RQXU5RVJ3bUg0Z1JtVzMrdTdPR0xi?=
 =?utf-8?B?cmgrcWtMU0QrLzVCMEk4WXBRRDdYY3YrRHU3YTc2ZGJ5SzVlblZFN3dLcFda?=
 =?utf-8?B?dW5aMGlJY2FMTmcwSnBCODljMGh3WmRhU3Z4WHgzbi9FS0dDS1dPL3FZR1hp?=
 =?utf-8?B?ZlpsUzdWVzFnVHdSRmI5bWNObU1LREVYQkVkaTNiTXIydGkzRHhhMzBndG5u?=
 =?utf-8?B?UjRNZUpBbW45Q3VhWk5GVEQvMmFiOEtvcXBDS3FCL2tjNWIrbFVwdk8vaDhi?=
 =?utf-8?B?RXFHb1NSbmpHRm1RQ1VFdEpNUUsySnlNMVRkTllZOENqanNJRWRmWEl4Q2pO?=
 =?utf-8?B?WHZxdGtQRlBOLzZGRHJZZ1Z1TkcwQ1BQWWExQXoyeFFLQ1IzeFJIQnZGZCtF?=
 =?utf-8?B?OEhjMHMvTUNEWTl1b2JibFJ5S3h5aVBjTFhvTXVDQkNPK1VqSU9GN2RUeHdx?=
 =?utf-8?B?cTVEV0NqL0orcnYxNWZDYzkxdFJhZVRzM3gwOGFLeHpMWUlwdTFndXVUNXp1?=
 =?utf-8?B?Qm1HTnRLeTZMdXpMcVk2Mm4vNkpKRnhvckRsUGR6TW1wVVlQajhhV1pLUUlS?=
 =?utf-8?Q?8VwRnJTQo4EUF6VQ8PZ31JAOU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1198e69-f4f0-43cf-09f2-08db6db02c86
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 14:52:43.3556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BC3Eq2617Esaod0I9xJt1mFTk7WwdOggtWbgOwnmvot754kFCmDV57R8v+3R9IMPQ6qPECX03fnJLRplj0aCpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860
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


Am 2023-06-15 um 03:37 schrieb Christian König:
> Am 14.06.23 um 17:42 schrieb Felix Kuehling:
>> Am 2023-06-14 um 06:38 schrieb Christian König:
>>> Am 10.05.23 um 00:01 schrieb Alex Deucher:
>>>> From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>>>
>>>> This adds dummy vram manager to support ASICs that do not have a
>>>> dedicated or carvedout vram domain.
>>>
>>> Well that doesn't seem to make much sense. Why we should have that?
>>
>> TTM always expects a resource manager for VRAM. There are no NULL 
>> pointer checks in TTM for not having a resource manager for VRAM. The 
>> existing amdgpu_vram_mgr gets confused if there is no VRAM. It seemed 
>> cleaner to add a dummy manager than to scatter conditions for a 
>> memory-less GPU corner case through the regular VRAM manager.
>
> Well no that's absolutely *not* cleaner. TTM has a predefined manager 
> if you need to use a dummy.

I think you are referring to ttm_range_manager. ttm_range_man_alloc does 
a bunch of useless stuff when there is no hope of succeeding:

  * kzalloc a node struct
  * ttm_resource_init
      o add the node to an LRU
  * drm_mm_insert_node_in_range (which fails because the drm_mm was
    created with 0 size)
  * ttm_resource_fini
      o remove the node from an LRU
  * kfree the node struct

In that process it also takes 3 spin_locks. All of that for TTM to 
figure out that VRAM is not a feasible placement. All we need to do here 
in the dummy manager is to return -ENOSPC.

I really don't get why this bothers you so much, or why this is even 
controversial.

Regards,
   Felix


>
> Why the heck didn't you ask me before doing stuff like that?
>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Christian.
>>>
>>>>
>>>> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>>>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 67 
>>>> ++++++++++++++++++--
>>>>   1 file changed, 60 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>> index 43d6a9d6a538..89d35d194f2c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>> @@ -370,6 +370,45 @@ int amdgpu_vram_mgr_query_page_status(struct 
>>>> amdgpu_vram_mgr *mgr,
>>>>       return ret;
>>>>   }
>>>>   +static void amdgpu_dummy_vram_mgr_debug(struct 
>>>> ttm_resource_manager *man,
>>>> +                  struct drm_printer *printer)
>>>> +{
>>>> +    DRM_DEBUG_DRIVER("Dummy vram mgr debug\n");
>>>> +}
>>>> +
>>>> +static bool amdgpu_dummy_vram_mgr_compatible(struct 
>>>> ttm_resource_manager *man,
>>>> +                       struct ttm_resource *res,
>>>> +                       const struct ttm_place *place,
>>>> +                       size_t size)
>>>> +{
>>>> +    DRM_DEBUG_DRIVER("Dummy vram mgr compatible\n");
>>>> +    return false;
>>>> +}
>>>> +
>>>> +static bool amdgpu_dummy_vram_mgr_intersects(struct 
>>>> ttm_resource_manager *man,
>>>> +                       struct ttm_resource *res,
>>>> +                       const struct ttm_place *place,
>>>> +                       size_t size)
>>>> +{
>>>> +    DRM_DEBUG_DRIVER("Dummy vram mgr intersects\n");
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static void amdgpu_dummy_vram_mgr_del(struct ttm_resource_manager 
>>>> *man,
>>>> +                struct ttm_resource *res)
>>>> +{
>>>> +    DRM_DEBUG_DRIVER("Dummy vram mgr deleted\n");
>>>> +}
>>>> +
>>>> +static int amdgpu_dummy_vram_mgr_new(struct ttm_resource_manager 
>>>> *man,
>>>> +                   struct ttm_buffer_object *tbo,
>>>> +                   const struct ttm_place *place,
>>>> +                   struct ttm_resource **res)
>>>> +{
>>>> +    DRM_DEBUG_DRIVER("Dummy vram mgr new\n");
>>>> +    return -ENOSPC;
>>>> +}
>>>> +
>>>>   /**
>>>>    * amdgpu_vram_mgr_new - allocate new ranges
>>>>    *
>>>> @@ -817,6 +856,14 @@ static void amdgpu_vram_mgr_debug(struct 
>>>> ttm_resource_manager *man,
>>>>       mutex_unlock(&mgr->lock);
>>>>   }
>>>>   +static const struct ttm_resource_manager_func 
>>>> amdgpu_dummy_vram_mgr_func = {
>>>> +    .alloc    = amdgpu_dummy_vram_mgr_new,
>>>> +    .free    = amdgpu_dummy_vram_mgr_del,
>>>> +    .intersects = amdgpu_dummy_vram_mgr_intersects,
>>>> +    .compatible = amdgpu_dummy_vram_mgr_compatible,
>>>> +    .debug    = amdgpu_dummy_vram_mgr_debug
>>>> +};
>>>> +
>>>>   static const struct ttm_resource_manager_func 
>>>> amdgpu_vram_mgr_func = {
>>>>       .alloc    = amdgpu_vram_mgr_new,
>>>>       .free    = amdgpu_vram_mgr_del,
>>>> @@ -841,17 +888,22 @@ int amdgpu_vram_mgr_init(struct amdgpu_device 
>>>> *adev)
>>>>       ttm_resource_manager_init(man, &adev->mman.bdev,
>>>>                     adev->gmc.real_vram_size);
>>>>   -    man->func = &amdgpu_vram_mgr_func;
>>>> -
>>>> -    err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
>>>> -    if (err)
>>>> -        return err;
>>>> -
>>>>       mutex_init(&mgr->lock);
>>>>       INIT_LIST_HEAD(&mgr->reservations_pending);
>>>>       INIT_LIST_HEAD(&mgr->reserved_pages);
>>>>       mgr->default_page_size = PAGE_SIZE;
>>>>   +    if (!adev->gmc.is_app_apu) {
>>>> +        man->func = &amdgpu_vram_mgr_func;
>>>> +
>>>> +        err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
>>>> +        if (err)
>>>> +            return err;
>>>> +    } else {
>>>> +        man->func = &amdgpu_dummy_vram_mgr_func;
>>>> +        DRM_INFO("Setup dummy vram mgr\n");
>>>> +    }
>>>> +
>>>>       ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, 
>>>> &mgr->manager);
>>>>       ttm_resource_manager_set_used(man, true);
>>>>       return 0;
>>>> @@ -886,7 +938,8 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device 
>>>> *adev)
>>>>           drm_buddy_free_list(&mgr->mm, &rsv->allocated);
>>>>           kfree(rsv);
>>>>       }
>>>> -    drm_buddy_fini(&mgr->mm);
>>>> +    if (!adev->gmc.is_app_apu)
>>>> +        drm_buddy_fini(&mgr->mm);
>>>>       mutex_unlock(&mgr->lock);
>>>>         ttm_resource_manager_cleanup(man);
>>>
>
