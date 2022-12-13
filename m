Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1FEC4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Dec 2022 09:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3206510E2F1;
	Tue, 13 Dec 2022 09:52:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A5E110E2F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Dec 2022 09:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpIBqpqht3PVVIgyBVcaKCr0ProxgI8YZlCDCje1mZy38oGCLvmQ9UWR3p7zg+fgfyt34h/KxJ69LhZa3HOb87Vw4IB8ziChsxDIFpv8BkjQVVeGxfS8K3H+5BOAEv2ShFPYwty+GLolaHLguVkRLRh2Tu7AAuPHBd197t5NeET/6Va2RvuLV8ZqPmywW2O+Dp6x3wec50XDAoHGF2SqFmhFv5sFvhoOcjjkh2KMOEe+9cSxqF+h+k5UXP3hh8IDexkHZ1bENPmcytUW5mWigCWLmKx3xdjr+5cFjp9nhzxAtZilh6OUf2NK5P9UcZVV1yCnhELTEJmvRQknJ2gy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcrNAiuQbYcZIdITL/GUVKxeIjlTc1593ywLCinp6x4=;
 b=BhClEOplTiEPAjlPdirHPHjucaPczB8sce6aY+e0OM3whgspMaGOgRMEgB+J9rxUGJSbQ3s4NsIvgjiSllxlPg5jcbTaLE4G5qzieVJCDTD9x4Di7+zs4NLwSq2jtbw44yDwC41tkoiUSve3deyc9vDV71/TRqbRkzhnPk9NVS4vYKVRnwHv3CPHi0UuhHeYwUibUgc+b0uYsdXL7pB6MKexZZTXiDudryMhmhTQFi6gzMMjCGUG0Y6IjjI3pz5d3sOMZ/yI5Mqj9HhjEbGm5tJUsw/OLZRiosCQn4DOmFFilWVFT6OTBA06NDAAuBTbp2CDQCx1QcpEndcQKHZy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcrNAiuQbYcZIdITL/GUVKxeIjlTc1593ywLCinp6x4=;
 b=3oqoo6zjUAYDqqGSLNoFIQj9NYh7tN/mClOiMXBnC6ln3od9qFUHH/5gbpJfC4RU5DOvbzElXEcW4ktX9CWPOv9xGo3CAl3zMP2nkA35plupuONCjk+HSLXfFmF5ven5MnTPyNvbw6PO2ST6LTkqXVKbHXniU8ocnHQVefdha04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 09:52:17 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 09:52:17 +0000
Message-ID: <430c6807-0bd1-4a3e-a508-837afa2ebb0d@amd.com>
Date: Tue, 13 Dec 2022 04:52:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221210092419.16548-1-luben.tuikov@amd.com>
 <20221212174834.36544-1-luben.tuikov@amd.com>
 <802b6283-d015-eb67-18fd-cba6fb03c96a@amd.com>
 <fe09407d-9057-879b-be61-3bfbe74846db@amd.com>
 <9e14bcd5-a911-c430-a474-4f43daf44283@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix size validation for non-exclusive
 domains
In-Reply-To: <9e14bcd5-a911-c430-a474-4f43daf44283@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 498ee981-446d-4e73-3b54-08dadcefb7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3UsSKoQ/ewDMi5RTrh+d13cI48EQENo30lbzDlezo6lgDxdE+y6+7wxNGRW/Z/s7Vznjz/wYgUBgyBmU78VgXTA3Ax14qhqSO+VSyxQnWrPq6fCay3P7oPWudJzevqSeMzuC/ZqPbaayTy9KlZ3t/lztADRnvsn4qNGi73a2Ge6dCsVjiT1DNtLgCksb/Zo04qKFE6UbypXghju5A7K201TD8ZSTx6uULHZhAB2mEdO2CUkBPiY+9CThPnS5J1jBGhfyn1B2GE5k/crwUNJgF91FUSpzyDNieyz7iG6dLg26ElnI+K2ALEDPxJOU5RJ6jDYpn/aFIQuF+Zk24YGbRqC2oprXNt0nUUTA8rWmO92D5dBYcSIYuVBDbs8lbzBggad2TSfSLgkFJWKOYFOE3Ka5+IfsRwazaw8ouHVfshFv3LpVxGtOHQOPMVV88WepoRVIPyw+vWWi9jGE2cqCBAYhBrNCBV4LAQg81sZrHLGePzLolSJW94nb0TQQjmEarN9a0t3H13lUkT7yTfjIFuIMLJqcy9hSJgbh8msigUs1MYCGWdGl0owxRjwHDXcE8BxveTFNEcKAV7fViVh/0BivJ4/fpVYLnmS2O1KEbzAwYBXQZuMG/ZpuunYz5Lya9IFArizQAlC1q5umMaXIu9jwsC3S00IDshfBzAB2NQC2E7klIbgLh28LMi2PTiv89XxCiA9gAo78MkjcwWHm1F5+fAdSvGWOJukQJ2lr3us=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199015)(478600001)(6486002)(31686004)(316002)(66476007)(26005)(8676002)(4326008)(6512007)(41300700001)(66556008)(5660300002)(8936002)(53546011)(36756003)(44832011)(6506007)(66574015)(110136005)(86362001)(2906002)(38100700002)(31696002)(83380400001)(186003)(2616005)(4001150100001)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkluSE1zR2Y5eCs0QWFSRFNJQy95YXN5bkhmU3gxcmxPR3B6RDV5SkVSOG5R?=
 =?utf-8?B?VS9rR1hCbXlDdDZhbGIyZkFLWkljR2dXazFYTDZWVDllODJGVzFNVTZaZDVS?=
 =?utf-8?B?Z0dGUVFhL0xlMnhtOTBSVzlDeVpmS1lac0IrUUc5T2dHZlg2dnJ0NGw5SW81?=
 =?utf-8?B?bUE1Y2RKeTV3ZFJTdXM4YWNWMGR4bVRXaHRUaVJQN1pCckY2clp3R2pTVmV3?=
 =?utf-8?B?c1Q5QTN0RFFoY093ZVo3ZEtxbmNYL0RJQnkyd1ZOK1BkZE40dTl0d2tna2pX?=
 =?utf-8?B?OERIbjZnRGw2dk5NQUk0SStHT292bjNpMkRGY0YvRk9rT3hXM3JiNis4QjRK?=
 =?utf-8?B?TUpMeUVJbHJPL1ZnUWdhMzJDY0h6a1RhckVyNkRnaHNpYklRWkk3cEwxVGZ1?=
 =?utf-8?B?aFZMZVR6MWk0Z2ovQUtWNVVBeGN2MEh4NlJWbjVoWEE2NGxGNHVITG5LVFlq?=
 =?utf-8?B?Qk55bHJuMDF1NHdESEZrSkloN2ZHYVBPL1Erd2I0Rit6UUZKNDJ1cDNHRVVy?=
 =?utf-8?B?VzRQNXdvUm9OL0FCVTNBNWtOMktrbmFDWTZoUHQ2V3ZTVm9GMUx5VmtFK2sx?=
 =?utf-8?B?Y0NXVXRDbW9pWG8wY00vTzZJSTFxb3RHaTBXVmoyaUZ0OUtzUW96eGVOSXls?=
 =?utf-8?B?QWdrR05JVjBBSGtZMHhCb2FyelRTOWxaK3RsM0QxRHZaanBoR1ZqKzgvZXl5?=
 =?utf-8?B?UDlLSEhoRTY3cmhPT3RjcThQWElZdmJRbE1oSS9weWphSGlBQ3NCalJKVGJw?=
 =?utf-8?B?cnR1Wjg1RkJGQmE5RU9Ea1BRNjZLVGRYOWJXK1JvWWhzdG8zbWxodHVKaGxF?=
 =?utf-8?B?L2lLd3VWUVBoZ2NzVjVHdVJGZW84bHhLaUJpOGcxZURtcVRMQ1h0WGNLQ1g5?=
 =?utf-8?B?ZTZjSklwQ0JxS1VkY1NZU2o5Q1hTTVIrWGk1ZVQvWGpNeFM0TlJOYWVQSjhO?=
 =?utf-8?B?TnEyUVgwd2VTWmViQ2VOdHd1QVZNSXdSejl6Y1FTTENxSWxZQjNwRzJBSzlm?=
 =?utf-8?B?dm9FZDYzQU80VFVVR2ZER0daRGxVUjNJL0kyb0NBeTNzeGoyQ1laMG1GbTZo?=
 =?utf-8?B?SDl0SXZGaGJqZTl5bmJrdUJmbWVtaXpJa3pVdUpXYzlrWHc5d2NPckJncHNR?=
 =?utf-8?B?Wmg1OGt4VUpDMEhVcHd1UE05VCtqVWRrZTlFVHJrYUFwZGh4QkYrVThmMWFC?=
 =?utf-8?B?MXRic2JHdjl1VEttRUdlQml4MmJod2YzdFp5STJlMCtwWDFGWkZONnh2WG9T?=
 =?utf-8?B?U213MzVPNGw3VzdzVDkxazFZblA2L2ZHSFZyWmUwd202L2YvTmFFUm1Kdm9a?=
 =?utf-8?B?V3RDUUZoTU5qMUhGMGphZFdmNHVCNzFBYk5VRmRQWE5NK0ZiNjBLSVg2a1NT?=
 =?utf-8?B?RUtlRmNycDkzcFJRdXhadmo4WDdKWDIxQzIvQUk2UjZ1a1dZTStheW5WbDhi?=
 =?utf-8?B?d1FFWGdIVUF2YTgrNTJWRXc3ZUpBS2RvUjJPbU1XYlhXS0JyQkhKOUR0ckgz?=
 =?utf-8?B?OGZMbDVQN3pjWGRhci9lR0NsRGVUeW5YWlFEek8rWHpMRjJFejVzcGdMQnhz?=
 =?utf-8?B?TnpKUjZ4TkJnRWNFRjVXWVREMGRVVjgxYUJxbmxkTTNkRnZNbitvMU9lVWZO?=
 =?utf-8?B?UTNJalZwM1pPUzM1ZE1VWnk4bS94cXVPYlhiMTFPNzhnVnRWZTRrSm9XUGxY?=
 =?utf-8?B?WTdwb3RoSUFOdHVUKzBzbUg3c0dMTFVhZ2V6aUFXczJVYVBDbG5JRjNYTnVt?=
 =?utf-8?B?MUZZeG1TeEQ0dDFzeWphTjdhZW02OGhCUXpEWjNQY2Ztdmkvd25TTHlPTzlF?=
 =?utf-8?B?NVQzK2ttazB3dGhXTFV4OFdqZEtVQUFDZ0p2WXh6d3lBbXp1NHBoVWJCQThy?=
 =?utf-8?B?bWFGQ1VkZVJpeWttcWZiaGVjLzZMbjlkaGQzQ3Y3NDJDaFg4dnlUWGREemNK?=
 =?utf-8?B?YlRSQmxldUQ5VW1xZHpJZExmcU5NSmhpME9nQmluL1J5bkJ5Wm1JY1ZUOCs4?=
 =?utf-8?B?R25aY3lqRXFXRmpCL2ozV1JLcUh4R002K25CWW9UQnZRR1YyaE51T1F0QzE0?=
 =?utf-8?B?R0FBTEpQeFdqalFhZFFTZ2NIdnBhSndlc2RCSEV4NzFnZ3VZWjFOc3NpRTNs?=
 =?utf-8?Q?nwFFuDSJMzmasHEkAb5nEY0mM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498ee981-446d-4e73-3b54-08dadcefb7f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 09:52:16.9611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiH7UoXtnvH3GeZe+qnOhdyxY7F4Qsn4O4/4yIigndBgxXDyebi0UaeVosLRyKgt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-12-13 02:00, Christian König wrote:
> Am 13.12.22 um 00:44 schrieb Luben Tuikov:
>> On 2022-12-12 14:19, Christian König wrote:
>>> Am 12.12.22 um 18:48 schrieb Luben Tuikov:
>>>> Fix amdgpu_bo_validate_size() to check whether the TTM domain manager for the
>>>> requested memory exists, and to allow for non-exclusive domain allocations, as
>>>> there would be if the domain is a mask, e.g. AMDGPU_GEM_DOMAIN_VRAM |
>>>> AMDGPU_GEM_DOMAIN_GTT.
>>>>
>>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 +++++++------------
>>>>    1 file changed, 7 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> index fd3ab4b5e5bb1f..e0f103f0ec2178 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> @@ -448,31 +448,26 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>>>    
>>>>    	/*
>>>>    	 * If GTT is part of requested domains the check must succeed to
>>>> -	 * allow fall back to GTT
>>>> +	 * allow fall back to GTT.
>>>> +	 *
>>>> +	 * Note that allocations can request from either domain. For
>>>> +	 * this reason, check either in non-exclusive way, and if
>>>> +	 * neither satisfies, fail the validation.
>>> That's not correct, the original logic was completely intentional.
>>>
>>> If both VRAM and GTT are specified it's valid if the size fits only into
>>> GTT.
>> Given that this patch fixes a kernel oops, should this patch then fail the validation,
>> i.e. return false?
> 
> It should be sufficient if a BO fits into the GTT domain for size 
> validation. If we haven't initialized the GTT domain and end up here we 
> should probably just ignore it.

By "should probably just ignore it" do you mean "return true;" or "return false;"?

> 
>>
>> This would then fail, in amdgpu_ttm_reserve_tmr():
>>
>> 	ret = amdgpu_bo_create_kernel_at(adev,
>> 				adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
>> 				adev->mman.discovery_tmr_size,
>> 				AMDGPU_GEM_DOMAIN_VRAM |
>> 				AMDGPU_GEM_DOMAIN_GTT,
> 
> As I said before using amdgpu_bo_create_kernel_at() with VRAM|GTT 
> doesn't make any sense at all. We should probably drop the domain 
> parameter altogether.

I agree. We can do this in another patch.

Regards,
Luben

> 
> Regards,
> Christian.
> 
>> 				&adev->mman.discovery_memory,
>> 				NULL);
>>
>> Regards,
>> Luben
>>
> 

