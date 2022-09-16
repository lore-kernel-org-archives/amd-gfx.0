Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26605C54EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 13:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B31710ED42;
	Fri, 16 Sep 2022 13:50:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD7010E460
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 13:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHiV66fn1/z7+FQg7MG4gFlONygq/xnpHvXuY9osFhydBK85dHMhKXvEmsiY1MrDP3/fTujGwp50FikI3A6A2jc7pBLztwpuMvJbC4Rr2IuILhDv1ZS0ZKKBDZD5AW+xCFkL3/+e2dRVO4VBYNxpHRwzvDLiwIWRWqCgmCOgZ+cKgFxyknCt0UltQ3kdlxJGKH91RI5JWp+sQykI+5XgKRWWCynjUIKMHk60Z7DVMWigW38oecyovBgswvZSgXiFDTawnPtj6pTJ2sf19ZQyKNv9obL4EVWmqGXpHlYnfDdmJg4P77AkMOk51Qy+itfwnOi398d92Anm0HvThazSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uALZi/68ElGnVIOIpEDrmhC0AcQvSxV4dxMwKsZpYg=;
 b=g5TicxAKZimsGHn2A+6D5p/uGWPf77iTe0OqtPIhj5uhgxD6T4ndNF4VgdPyCG48qAZxfQvS8gDwfGkTRlbyAMMF6g5m9jMHZ89c75m2tZ6oR3Lap7Ne3KEGFTbHBCgkv5NwOGbiDdrGndqRBVTaK0tyCbFSxZKRADc+YJRiwG3LDiNdQb2cgyzE/wa1cQb2NssWc27sKpsrXT+7evU+9TtsI15ecit2TVzYaN2MYpeQNmsd2onuRvsAVpIqZ/E6NijJoHimkEvxOaihoXMrIN/R3j1c8L8V0lV4WLFEQh8D53IkxmZj+YsYXR/eTBDzq379ugnDQjrGqK46fqZrIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uALZi/68ElGnVIOIpEDrmhC0AcQvSxV4dxMwKsZpYg=;
 b=hHi7NJOP8UHlzIWPBv0j4w10YhE1ZrvlNbOIZmYrGZTlfBArqjza4fIBmRXWNhnVqsn3xRYIbXZIhpP1x3YkheE2aJKMEQxV7G2uBLVB41q843hTwDRGfEjGH/FknOc9pfPuWIPjZd8JAE//loIqLDqhYHiGO5HtuXQjR1r2ghU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 13:50:12 +0000
Received: from CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::a527:1309:e629:789e]) by CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::a527:1309:e629:789e%6]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 13:50:12 +0000
Message-ID: <d4fff5a6-833a-161f-d86e-b17cb9d9382c@amd.com>
Date: Fri, 16 Sep 2022 09:50:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
 <DM6PR12MB4340D28D9D23472D571727D7FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <1ea8528f-fb55-e8b1-73c8-bf8935f9870c@amd.com>
 <DM6PR12MB434047014434C43396BB2D31FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <e7eadc0d-c9a6-8a12-bbd7-5dd3277a7754@amd.com>
 <fc7f7d5f-3d63-234f-1864-ab365d6e338d@amd.com>
 <378f971b-9ee6-5fb3-4143-f20b873d0b4b@amd.com>
 <3ee47f74-fca4-f78c-9235-972d4543d880@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <3ee47f74-fca4-f78c-9235-972d4543d880@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::17) To CY4PR12MB1943.namprd12.prod.outlook.com
 (2603:10b6:903:11b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1943:EE_|SA0PR12MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: a2903e24-3066-4e6a-a252-08da97ea6087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GbFFzngBQYd0xzzo3Ibuj2BpX9kDOoRssD9SNWtVXU9wMx9wSgREOYd7bw3YnKYRHbWmKVa7UTL3ZhntkhOR36MyfADD95C97wkeMnPk7uFIGqRHMODJV3EIlosBBx1cPMB2G3O5dHdNT3V2ZB0yBPlfFtZ6CoyPGi9jH6fssgbOH37fpCbbhvaQrmEQBS7oMZaYMzGELA9I4pxztiYvkwBf7Ic/w6BAjvILdVJkjjaLGIma+Ngfb7wZj9sryf3mvs50mWkXP5U4YzN0kkdn8f0N29v+3D84aFSpJobuXPuXYgTaf3whIpQY3zXaLgQrNNFd8xv5QS0MIDydjn3rHmu1TnEmueRyxMDdNYibj8o3z/7pDigytWJO0MqdiNauqsceH+XqEkfQ0/ONRUi8OhCHCMgVPc5RJ4FMWzoPQxWAwMjm7RqDX5DK5XDjYjJVl/oa5shncPWZ8gWBzaz+dp2gIo7S2JwZoPFrGhzuTaeN9sVxUvFk1AbmSa2FE8ZmrDoQoDqmocUiDxW8jMPw50BWdg/VgaowKUAt7wvmOc2W6DCgbKZYS0X7njNbjfpwLqjYsvfNBBJm1dFz2PhGif/a0k/61UWgXua6CvNoKy+FYB71K52dTg7VQ4HUTNwUusm4bEcfPOKx67l+UWHCmDXQWEte+KlgMySJmuVakV11+6BTaCdyrTOubVyN1pZ+0J+Lh4SgLHyIuWknFtxta65ZilqkIqx2iaYv25LbUeADY80hm206kAwiWfPJjJykwmO3Q9XKo360XMZs8qj3pslvW+PsU9E+UtcIpq4qtt/AOY/Be/BtIxhKeiuFhYmPuLjfbYLNdFS3+j47QbpGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1943.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(44832011)(5660300002)(2906002)(8936002)(4326008)(66556008)(66476007)(31686004)(66946007)(316002)(110136005)(8676002)(38100700002)(6506007)(31696002)(86362001)(36756003)(6486002)(2616005)(41300700001)(53546011)(6512007)(478600001)(186003)(6666004)(66574015)(83380400001)(509564003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy9hV3ZJQ1B0N3QxRDUxZ255N0NMcURlNXI3bnNGWnBJeFBlQUhxbW1WS29L?=
 =?utf-8?B?cnRPazJLOHpEdWhGcmcvay9aSUxsQ3dZMTJYS2lkREZxb3h6RUxLK0hqNDJm?=
 =?utf-8?B?SDdlK0pYTkFWQ0RBOEZaZ21iNTc2UWN1ZWdtaE5DY0ZUbEdjRnZGd0NUQm85?=
 =?utf-8?B?aTR5czhUMk5NZFhqbVhnYUNCOWpVV3FtY2U3em5rTERERmNiUmhmRll1cWZ2?=
 =?utf-8?B?dWx5MmRHYVZhTUFFNzBZTko0ZjRDa1ZrZHhxSXBvMWlSYjhtY3Q5bHlUaGp3?=
 =?utf-8?B?Y1kwTFIzVkJodXA0bCtaMzdiMisxck03NmpTU3B3Q1dhK0x4QlVlR01iSTY2?=
 =?utf-8?B?cFZlMThHOUtsWno4WU1FY1pBaHJ3SlRVRTJsMzBrenhvbFJsSWIvMmhhWVZ3?=
 =?utf-8?B?aGo3YitidjMwTkJtRmMyOTBSNTJTV016cGYvbmFlTDR1ZityVEE1N1BuK3Y4?=
 =?utf-8?B?eFA0YlNhcXorU2Q5R1pValNXZDNUSnFBVG5aNTMyTGlTMllBL0JJVS8xKzFx?=
 =?utf-8?B?S0lDNWw0cEcrREYwNU1STElpSlBNaVNRVW4rcnZjTnlnaTZ2WXZobDBuaFJE?=
 =?utf-8?B?SU15cm1qUHF0b3EwZi9YQU9sQ3ZRbXFib251aEYrMnhHMDJmeFQ4RzlYVW5v?=
 =?utf-8?B?UVdZRFk1R2lUb0F4c1RQOFZKLzZtQjNhalhHWWFVQ0FlMWFhRHdXZ3BvdlBW?=
 =?utf-8?B?NlNlTHRneHgzWDVIVk5NeHZmdi85VHllTDdkZG9hRlJIMjRXQit3V1pOTWxI?=
 =?utf-8?B?VVdGL29hRzZuTzZNcWJmV0ZKWk50L2xndHVpYnA4NlNVcHRtMWxqaTlOZ3Yy?=
 =?utf-8?B?endEOWJWVGlXS09YSGh4dnVjbHlMeng0WklYc25XZVJWV0pLUjZOWU5yYTRO?=
 =?utf-8?B?TUZNWFlpSEREN3lEWFdWM1JtR2ZjVXAxcDhmOVZRWmF3cXNMK2ZOanZJcDdY?=
 =?utf-8?B?dGx0WWhKVkFYeFFzdHUzaEFIdGY4ei9qc0FzNlU5d3ZsQVh3YVVqaVVGYzEy?=
 =?utf-8?B?ek13QTNzR3FYbTluSlkxNXZtOFZaUG5Jd3lGOFliNEh0UjFUWjFLY0htbjVa?=
 =?utf-8?B?RXBBbnRYemhSd092dkpveGpDQXJnbVR5dENHdkI4SlRZMjRqMGxmb1hkY0FV?=
 =?utf-8?B?aUVCbkQ4Q003aFFEZmxVZ1dsOXovK0JNcFdnMWNWM21adzZhRzhsa0dsakRi?=
 =?utf-8?B?UUdKYkliL0o1Zk1WOUdPWGJidXBYd2paL056b0xHNFM4Y0FwUDJ0blZndjIv?=
 =?utf-8?B?NHA3RFRUUFUwdlRUZHVXVlR2dWl4aGcxSFhFMDZHcnlSVzhrN2NDMWovMUkw?=
 =?utf-8?B?cVhIQmRTWDY2WnNkcXdsdkNodnNFdE1CRjlQajNhSWRrd3BXWlM5SnNuRlN6?=
 =?utf-8?B?alZ0dkFQMXFYeExZL3l0WHZHNHhCRC9jYWQzbnNUdVRwWU5NaUw4YjRyNkhC?=
 =?utf-8?B?WEFKQk1NZVBZUDFTMS94bjNJT0RNeEtQck5DOGxBZ3lvMHRwM3lCYnQ0cjBK?=
 =?utf-8?B?cTVwdHpSMkVFTDEwVHJCWm5zZUdRQXFvMU13ZXFSL0NjSzR3Zm5RUVpJdGpB?=
 =?utf-8?B?U2hvL0p6aWczNjdIdDAwcksrRUpqMjh5TW5MR09OK1dlTVlWNHhvdyszNG9O?=
 =?utf-8?B?eWNJYVFGYkdlUm5ONjM3bEI5MUZPb2gwN3MrV2Z6STlRYU1TYnBUWXZiVGVE?=
 =?utf-8?B?TXYwU21xZlBWYUx1UnFmelhmVzN1RW5aajJMc3VtNFFZM0l0OU9TMUVOTWtC?=
 =?utf-8?B?b0Z0bUhBb0lFQWRzYzh6SXczR1F6NElmYTRsakxLTEoxcnpndmNkSjNPUkpU?=
 =?utf-8?B?alhHM3J4VGxWVzBGRHRlVnBBSTR5c3dBQXd1c0c0UStlZ3BhVlViK1l3Y1kv?=
 =?utf-8?B?bXBHN2NTRkZZbkhMZWdRdmtqbG9qKzhYN2FxMzhYRFkvUUkzdkY4YW13d214?=
 =?utf-8?B?Unhydk9QTGg5bXBDRVdrblNmNGlCdkdsa2pHZFZTc21tV1ZZei9GY0JFVE80?=
 =?utf-8?B?ZWozWVZsTFJCdC9JcmFjUmlpc3ljWHNrcE9rZmR6M2x1YXgrWTdwUXlibFJn?=
 =?utf-8?B?TExYYWpFWG9JcDJwaFVvU09mbjgvbUl5QW1xb0t6bmRJL2p0YXRId0RGU1Zp?=
 =?utf-8?B?N2ZCWmV3OFd1d1pyNUY3OHRFRmViZ1RPOXJmNElhOE5mV1FEaitGUnZ2Uk9H?=
 =?utf-8?Q?eF6nCykSbUowiJyV8h3POf9YSe4gay+HrJ3eSzVP05e7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2903e24-3066-4e6a-a252-08da97ea6087
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 13:50:12.5708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KH8tJemyIyXehzVilkheIVTFo1JPQzTiy+HdkPBWFOfdj2Njxh2LoO366LImjxbKDyXy/dcFf/Y+uNdtcYhkmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-09-16 01:18, Christian König wrote:
> Am 15.09.22 um 22:37 schrieb Andrey Grodzovsky:
>>
>> On 2022-09-15 15:26, Christian König wrote:
>>> Am 15.09.22 um 20:29 schrieb Andrey Grodzovsky:
>>>>
>>>> On 2022-09-15 06:09, Zhao, Victor wrote:
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>> Hi Christian,
>>>>>
>>>>> The test sequence is executing a compute engine hang while running 
>>>>> a lot of containers submitting gfx jobs. We have advanced tdr mode 
>>>>> and mode2 reset enabled on driver.
>>>>> When a compute hang job timeout happens, the 2 jobs on the gfx 
>>>>> pending list maybe signaled after drm_sched_stop. So they will not 
>>>>> be removed from pending list but have the 
>>>>> DMA_FENCE_FLAG_SIGNALED_BIT set.
>>>>> At the amdgpu_device_recheck_guilty_jobs step, the first job will 
>>>>> be rerun and removed from pending list.
>>>>> At the resubmit setp, the second job (with signaled bit) will be 
>>>>> resubmitted. Since it still has signaled bit, drm_sched_job_done 
>>>>> will be called directly. This decrease the hw_rq_count which 
>>>>> allows more jobs emitted but did not clean fence_drv rcu ptr.
>>>>> This results in an overflow in the fence_drv. Since we will use 
>>>>> num_fences_mask in amdgpu_fence_process, when overflow happens, 
>>>>> the signal of some job will be skipped which result in an infinite 
>>>>> wait for the fence_drv rcu ptr.
>>>>>
>>>>> So close irq before sched_stop could avoid signal jobs after 
>>>>> drm_sched_stop. And signal job one by one in fence_process instead 
>>>>> of using a mask will handle the overflow situation.
>>>>>
>>>>> Another fix could be skip submitting jobs which already signaled 
>>>>> during resubmit stage, which may look cleaner.
>>>>>
>>>>> Please help give some advice.
>>>>
>>>>
>>>> How about the code bellow  instead ? The real problem is that we 
>>>> reuse a dma fence twice which is not according to fma fence design, 
>>>> so maybe this can help ?
>>>>
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> index 8adeb7469f1e..033f0ae16784 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> @@ -164,6 +164,10 @@ int amdgpu_fence_emit(struct amdgpu_ring 
>>>> *ring, struct dma_fence **f, struct amd
>>>>         if (job && job->job_run_counter) {
>>>>                 /* reinit seq for resubmitted jobs */
>>>>                 fence->seqno = seq;
>>>> +
>>>> +               /* For resubmitted job clear the singled bit */
>>>> +               celar_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, 
>>>> &fence->flags);
>>>> +
>>>
>>> Upstream will pretty much kill you for that.
>>>
>>> Re-setting a fence from a signaled to an unsignaled state is a 
>>> massive no-go.
>>>
>>> Christian.
>>
>>
>> Is it worse then doing fence->seqno = seq; ? This is already a huge 
>> hack , no ?
>
> No, it's as equally bad. I don't think we can do either.
>
> Christian.


And all those ugly hack are there because we reuse a dma_fence (hw_fence 
embedded into the job) and correct me if I am wrong
but I don't think dma_fence is ever supposed to be reused.

So maybe like Victor suggested we should move close and flush irq before 
sched_stop - this in my opinion should solve the issue, but Victor - why 
then you still need the change in amdgpu_fence_process ? You will not 
have the overflow situation because by moving irq_disable before stop 
any job that signaled will be removed from the scheduler pending list 
anyway. Also not that this change reverts 'drm/amdgpu: sanitize fence 
numbers' and could reintroduce that bug.

Andrey


>
>>
>> Andrey
>>
>>
>>>
>>>>
>>>>                 /* TO be inline with external fence creation and 
>>>> other drivers */
>>>>                 dma_fence_get(fence);
>>>>         } else {
>>>>
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Victor
>>>>>
>>>>>
>>>>>
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Thursday, September 15, 2022 2:32 PM
>>>>> To: Zhao, Victor <Victor.Zhao@amd.com>; 
>>>>> amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey 
>>>>> <Andrey.Grodzovsky@amd.com>
>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>
>>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>>>>
>>>>>
>>>>>
>>>>> Am 15.09.22 um 06:02 schrieb Zhao, Victor:
>>>>>> [AMD Official Use Only - General]
>>>>>>
>>>>>> Ping.
>>>>>>
>>>>>> Hi @Koenig, Christian and @Grodzovsky, Andrey,
>>>>>>
>>>>>> We found some reset related issues during stress test on the 
>>>>>> sequence. Please help give some comments.
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Victor
>>>>>>
>>>>>>
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Victor Zhao <Victor.Zhao@amd.com>
>>>>>> Sent: Wednesday, September 14, 2022 6:10 PM
>>>>>> To: amd-gfx@lists.freedesktop.org
>>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Grodzovsky, Andrey
>>>>>> <Andrey.Grodzovsky@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
>>>>>> Subject: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>>>>>
>>>>>> [background]
>>>>>> For a gpu recovery caused by a hang on one ring (e.g. compute), 
>>>>>> jobs from another ring (e.g. gfx) may continue signaling during 
>>>>>> drm_sched_stop stage. The signal bit will not be cleared.
>>>>>>
>>>>>> At the resubmit stage after recovery, the job with hw fence 
>>>>>> signaled bit set will call job done directly instead go through 
>>>>>> fence process.
>>>>>> This makes the hw_rq_count decrease but rcu fence pointer not 
>>>>>> cleared yet.
>>>>>>
>>>>>> Then overflow happens in the fence driver slots and some jobs may 
>>>>>> be skipped and leave the rcu pointer not cleared which makes an 
>>>>>> infinite wait for the slot on the next fence emitted.
>>>>>>
>>>>>> This infinite wait cause a job timeout on the emitting job. And 
>>>>>> driver will stuck at the its sched stop step because kthread_park 
>>>>>> cannot be done.
>>>>>>
>>>>>> [how]
>>>>>> 1. move amdgpu_fence_driver_isr_toggle earlier to close interrupt
>>>>>> before drm sched stop 2. handle all fences in fence process to aviod
>>>>>> skip when overflow happens
>>>>>>
>>>>>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 
>>>>>> +++++++++++++--- drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  6 
>>>>>> +-----
>>>>>>    2 files changed, 14 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 943c9e750575..c0cfae52f12b 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -4610,8 +4610,6 @@ int amdgpu_device_pre_asic_reset(struct 
>>>>>> amdgpu_device *adev,
>>>>>>            amdgpu_virt_fini_data_exchange(adev);
>>>>>>        }
>>>>>>    -    amdgpu_fence_driver_isr_toggle(adev, true);
>>>>>> -
>>>>>>        /* block all schedulers and reset given job's ring */
>>>>>>        for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>            struct amdgpu_ring *ring = adev->rings[i]; @@ -5214,6 
>>>>>> +5212,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>>>> amdgpu_device_ip_need_full_reset(tmp_adev))
>>>>>>                amdgpu_ras_suspend(tmp_adev);
>>>>>>    +        amdgpu_fence_driver_isr_toggle(tmp_adev, true);
>>>>>> +
>>>>>>            for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>                struct amdgpu_ring *ring = tmp_adev->rings[i];
>>>>>>    @@ -5228,8 +5228,12 @@ int amdgpu_device_gpu_recover(struct 
>>>>>> amdgpu_device *adev,
>>>>>> atomic_inc(&tmp_adev->gpu_reset_counter);
>>>>>>        }
>>>>>>    -    if (need_emergency_restart)
>>>>>> +    if (need_emergency_restart) {
>>>>>> +        list_for_each_entry (tmp_adev, device_list_handle, 
>>>>>> reset_list) {
>>>>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>>>>> +        }
>>>>>>            goto skip_sched_resume;
>>>>>> +    }
>>>>>>           /*
>>>>>>         * Must check guilty signal here since after this point 
>>>>>> all old @@ -5240,6 +5244,9 @@ int 
>>>>>> amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>>>>        if (job && dma_fence_is_signaled(&job->hw_fence)) {
>>>>>>            job_signaled = true;
>>>>>>            dev_info(adev->dev, "Guilty job already signaled, 
>>>>>> skipping HW
>>>>>> reset");
>>>>>> +        list_for_each_entry (tmp_adev, device_list_handle, 
>>>>>> reset_list) {
>>>>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>>>>> +        }
>>>>>>            goto skip_hw_reset;
>>>>>>        }
>>>>>>    @@ -5276,6 +5283,7 @@ int amdgpu_device_gpu_recover(struct 
>>>>>> amdgpu_device *adev,
>>>>>>            if (r && r == -EAGAIN) {
>>>>>>                set_bit(AMDGPU_SKIP_MODE2_RESET, 
>>>>>> &reset_context->flags);
>>>>>>                adev->asic_reset_res = 0;
>>>>>> +            amdgpu_fence_driver_isr_toggle(adev, true);
>>>>>>                goto retry;
>>>>>>            }
>>>>>>        }
>>>>>> @@ -5711,6 +5719,8 @@ pci_ers_result_t 
>>>>>> amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>>>>>        set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>>>>>>        set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
>>>>>>    +    amdgpu_fence_driver_isr_toggle(adev, true);
>>>>>> +
>>>>>>        adev->no_hw_access = true;
>>>>>>        r = amdgpu_device_pre_asic_reset(adev, &reset_context);
>>>>>>        adev->no_hw_access = false;
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>> index 8adeb7469f1e..65a877e1a7fc 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>> @@ -287,15 +287,11 @@ bool amdgpu_fence_process(struct 
>>>>>> amdgpu_ring *ring)
>>>>>>        if (unlikely(seq == last_seq))
>>>>>>            return false;
>>>>>>    -    last_seq &= drv->num_fences_mask;
>>>>>> -    seq &= drv->num_fences_mask;
>>>>>> -
>>>>>>        do {
>>>>>>            struct dma_fence *fence, **ptr;
>>>>>>               ++last_seq;
>>>>>> -        last_seq &= drv->num_fences_mask;
>>>>>> -        ptr = &drv->fences[last_seq];
>>>>>> +        ptr = &drv->fences[last_seq & drv->num_fences_mask];
>>>>>>               /* There is always exactly one thread signaling 
>>>>>> this fence slot */
>>>>>>            fence = rcu_dereference_protected(*ptr, 1);
>>>>> Those changes here doesn't seem to make sense. Please explain 
>>>>> further why that is necessary.
>>>>>
>>>>> Christian.
>>>>>
>>>>>> -- 
>>>>>> 2.25.1
>>>
>
