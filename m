Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6C8ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 20:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0283810E2B2;
	Thu, 15 Sep 2022 20:37:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E7110E293
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 20:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5HxGF2KvfdZQnq0fKRhVXUhjb09Mdo2ESH9OFpYM/uFS9Akv6SPzFk/5Bg1wkILZYGa830cKwHh1ODA2vcvOsHzmSp/Tc/qnHN76Hn3F4ZewSRiGHFoqgQdtkFaGS5MFQIxW1Qy22fJZBUNtXP98L/XEBZxaX6BDs/KnOGMmgpIed7+EmQl8jm7yJFCN1XDTYvIYUA3t1hBO2JwiDJfipPF3x9o37JZTZVgR8LiUDKKUE4zNwf3Un1An0QxLwpUoPlNmcmFIhcRmu4el5XQ60vJ6bZZI7aQ95T7WJo+fH9m7N+qpZ440Kp8yvE5IybXPMRSx3qMz7NYYUWPFM6p9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhizysDvoMy9fH7B0t4OF0U3bswkVU2QeczB5wrO4QI=;
 b=mk4QSJpApU5BI+mFXiUCNLof4rW6Dh9HDHdYlcx8CrzHC/Ye/JaZQDbfsnIvotg+wQ4qUXjKr+GEM4mABYBQHBbJr8pyDaETYsiZwj0XY48fGUa3aEUYc7G5oDy73l4CFAVcIssNUWL0SPXs+0+zd5HaaI/V+7MFPofGjsDO1+6iW2rKP37PjjuVI6M4CPvCpAwvAZBKjzBCseuFZgYBOxHyb+7xSEgSP0SH2mKvFuZQkVfsE1fFQ4kKiE7Mb7y+yaXijaEfHaASsXWZdTl6aiiny8BaHrNl9NuPRhtmEQpp2yJ8TKCu4lbh97CnrEIMXZ1t5T9xSD0huIUn1KgVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhizysDvoMy9fH7B0t4OF0U3bswkVU2QeczB5wrO4QI=;
 b=cKmU0oFvrdVqu5ETsdDUBuVzjQ9X0EQlxf23tPr9xjeuD8qiCJB2Rvy8qg4bhvBY1ihDJa/EzCjNI5brkUX6S3xEHz1ilv3hVfZmq2oSiill1lbjbzuJvHvmZlg8vLJAJRVsIFIKOy21tNIr+/ZIFvVEGgfQHJ6oqkXiToKARz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Thu, 15 Sep
 2022 20:37:52 +0000
Received: from CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::a527:1309:e629:789e]) by CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::a527:1309:e629:789e%6]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 20:37:52 +0000
Message-ID: <378f971b-9ee6-5fb3-4143-f20b873d0b4b@amd.com>
Date: Thu, 15 Sep 2022 16:37:49 -0400
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
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <fc7f7d5f-3d63-234f-1864-ab365d6e338d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To CY4PR12MB1943.namprd12.prod.outlook.com
 (2603:10b6:903:11b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1943:EE_|BL1PR12MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 950f9688-c81e-4605-b0ae-08da975a291c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPjYqWnpKeYQ+C4i79qvTDGr0GC52X7S/shagcKjdb34Iz3oPWQPBQlNS6frzxu5DfdmN+NDTxHWABfAIhucZ0Uqlr2AQVVRLqk1app6+GVcOtIGnHzetYvlT1uIoWoP3tRqTeQOFUZv2rHiSf2aGSOoF/Uly2++mJc1thLd3Zkc47+fzVJe5MBRYj5wQTFpzMg0rhrvXl9bwOnKSR09AEsB2kwEVUxDLxXiTkhSqv8wB44Dh/IdayFy13Ye7k2bYxv+Pn+cdM7AuZC6tZkccdgceU1LDtB3B073N8RtghkHo7BoceWG4xu8m7oqXK64AMwuP6L/TYWOQqnLynXyAMQBgpP4v4Yl86VrM9zPl0udmwgeD+2q6htur3VAzGSYPqbZRXg1le8rfC4wt06d/cOgDuMihQ6GMdDjuTk06q7LR5NQ6GsW+qiorMSSXyFqAURoNVN4nS5FTiq88l1ZR42zxwRH/B2bGq4t6bbZ0N8QkXdZcpm/ZDQfU+e+gJNgwE+57g8n++9WFMqIPB8gsXeENF+YCYXQ03hpxO3P0bIln2QYo1HpSSaSDPjsAPXykKgZJR+b/Tcfn/3cBJ1zUbuA7gV0EOUhsUur/0RViEIjKgcct3iYDP+lEuNziKOftQyE7prYQ0p6UpksazhWBy3ILuIhvQ8TzajoLbE2Sk0A4khgLu6djqEPE8uY3c+xFbeZ3PmUMb71Gl1GeztXyR4N+iVXFxPjYNukWOoyFRdPUQhT4NnrYBgjmyRS8VTpTcpjsSZnVbFKXqIxIQI/bB6xijFFF/eX52FlAksSLxhSAbwUNZkVc37S8GRrl9d2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1943.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199015)(5660300002)(44832011)(86362001)(31696002)(2906002)(8676002)(36756003)(31686004)(8936002)(4326008)(66476007)(66556008)(66946007)(6486002)(6506007)(53546011)(6512007)(316002)(2616005)(186003)(66574015)(83380400001)(38100700002)(41300700001)(478600001)(110136005)(6666004)(509564003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkFCb1dkcGdNakhkS2k4NFNlbFp3elVFTWJUQlpzL09aTmxHcHdSSEVUTTUv?=
 =?utf-8?B?eG9zZ3l3WnVsanJXMUlxbVFTZkVDbFJScVBaOHl1ZGh6N1k5ZDk4Vml0Z0s5?=
 =?utf-8?B?Rld2YlBQSFR1QkMrMzJWeGZyc1NYRGExYnNzbHBheUsyaVRaZitiUnF2WGFG?=
 =?utf-8?B?N09RVkVKTHFGVnI4TlNHNFRYeEJYK3M3T2xoY3hNaE42dGF4ZmxQTHFvV3FK?=
 =?utf-8?B?UzFQa3hFdy9ObWNiOURHbHk1MmxMTVB3YU9XSHhBdXdLblNyREg5T2h5ZHht?=
 =?utf-8?B?RzNOS1V2TWREMU9QN01zOFlkSlhJdXozd2Rkc0haSHdSWUpiMThZZU1iWFBE?=
 =?utf-8?B?NUxsby9BVWNkOEJnMlRVYWJBTDV0RnZDSlhSSGJTQTBlRXdlWFZ6TTdodVNs?=
 =?utf-8?B?aFNSbWZROWhiWkJtamdMMDdqQ2l3Z3ZRTDEvc1BBVGdsWnFBMTJxNUl3MGJn?=
 =?utf-8?B?blRHRXpEc0tHNTJaenNyR0lmd1hRZ01MT2diR09nVS9YQ0R3Wnh3Z2lCNE9V?=
 =?utf-8?B?Qk9UZ2FaNmluLytKeUQwU3pPcFFaR21NZ1M0VDdCVXVxamx4MkNXV0Vxb3Jt?=
 =?utf-8?B?Nk11NkdoNmVkVDg0TWJPM29TN3o3TkV3TE0yVW1Ga0RUTEtuQjRVMWlnZnpV?=
 =?utf-8?B?dlM2TXBzclZPcW9FMm9vc0RlY0loTjRoY0lyUTVPV0tvQk43WC9SZVIxVitz?=
 =?utf-8?B?NTBsNTBwbUJNMjdFc2sxbTBpRHlPeWtBRG1qaVhKQU5ma0ZUcVFBN2J4QnN3?=
 =?utf-8?B?eHBsSXFudzlML3IwZmJkM1g3ZmhSUXRoaVJwSFM5QVA3anJ4M2hXVDB6emRO?=
 =?utf-8?B?RlM4WHdzRjkveXZrbHBTRFpkTnoyaDN0ZUtFQjBtamp3dkh6YkYrbVNSMll6?=
 =?utf-8?B?akNwd1ZYQ2txM0IvMytpNnBjbS9NcVBtc3RaWGtzVk1xaHR2RjRCVHkwaGVp?=
 =?utf-8?B?UldsbVZ4RG9lbFprUm9YcGswbmw1YkhabUFkVGQ3MjNJOHB0TDc3UnN3SUNr?=
 =?utf-8?B?c2NlRlZqTCtrS24rY202YURKcExBbHVOVDA4ZUIrOFVob0thZkRuN1hYdm95?=
 =?utf-8?B?V1Fmd050N1UxV3FxbFNBYjBnK0JhQmR1MmkzWWxvcU1DYW9lbzVzVnhPWVBl?=
 =?utf-8?B?WUxQS3lWQkp4TWM1czVVU2xOaVBBZWs5ajhyb3FrQ0hKRUU1VHQ0U2QwT1Zq?=
 =?utf-8?B?S3BqenpxcklIUmhDSnJtVW9oNkI2Ym9INEdkdjBtZUJLdEN5YVIwV2hiZWhj?=
 =?utf-8?B?L01RclZ3UHA2cG5ocEdSeUJPR0wxZkNoTEVrazN1NEd0SzcySDBSK3lPVUtS?=
 =?utf-8?B?K0RHeVkwQmIyem0vU0JpY0RnMGNJaTBmTjdNQlFNRUc3Z293bjNiZDNOVjZa?=
 =?utf-8?B?MFJxRnRwb1UxNXF0aFJ2eDVJcks3QTh1RytNdnFIaERFQXRYNGlLY2gxUWFC?=
 =?utf-8?B?UVgxSVJCQUgxUURTNmoyWjM5a3ZsS2hYK3dMaWlxODhyRDBucVZJUTdiSS9P?=
 =?utf-8?B?SHdDakZZNHdJc3FKcW8rUk1yeTlrOFIwWVNaQ3NaTlhzcXRLMDQ3Sit1Rlhh?=
 =?utf-8?B?SjVzbldwK0JRbkJ5bmo5ZVhQMFVLcXd4WmJwQjRVSFVEdkRZb2hRSlJrZXFD?=
 =?utf-8?B?NlZGdklzUHZQc2ZZNG44Z0xIZHFnV3l6UnBRa2ttdU5BMkw4Z0hwQ2t1bVQx?=
 =?utf-8?B?RTBIZHpIN2lCRVpkVjlUNzZ4cWhpNUZNZ3FrYkdwb1VuVE1hNVlzNWtzS1Zn?=
 =?utf-8?B?OFR3V1BESXdwKzQ4dFZna0c2VXN6cDZxSExnbjhaMUNWOEt4T2pYSXZ3QmYz?=
 =?utf-8?B?T1ZFam5tbjJ4Rnh6OGl0U2p5QXhOUmhoQnVZVC9iYzNjbnI3ZmYrbTN4Q21K?=
 =?utf-8?B?akRVTHB5dUpuM29DQVMwQ2hZeW4ydy9nclFzYVArYjIxbTJ2R05xVm9nV3ZE?=
 =?utf-8?B?Q3BqNDJqdEVCVmFSVDdjNTQ5TjRzRlFSK1dsd3hXYjNPdTJpWkJHRnVxYkZ4?=
 =?utf-8?B?M1A1b3QrZDBtamRlODl3c3U5bWxyU0xnK0lrMEJvM09MclZ6MlZUZy9ZQlg1?=
 =?utf-8?B?MEVlWWRXb1BUblBYWUxHK1RuVkFZR3NJbndLQjBBdGoxN0JqN3lBVTllajVw?=
 =?utf-8?B?Z0E0T1djVGpLKzFWa3lXNHBsSzlBMlNpOHpnOUFZamlScUtaYURNZHlDMHB4?=
 =?utf-8?Q?z+HJNyLaHEyuRcgAy5i9rIGAEvw9psE+A9RuNl9Cs1eu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950f9688-c81e-4605-b0ae-08da975a291c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 20:37:52.1755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcuHI93ke1+JxB8/mHoJ3NfdxEBnkkZLtSojneycKt7cVcLfFVpX84qzCb4/oWTQ7NoXe1Mea36GYA0ptZRQ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
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


On 2022-09-15 15:26, Christian König wrote:
> Am 15.09.22 um 20:29 schrieb Andrey Grodzovsky:
>>
>> On 2022-09-15 06:09, Zhao, Victor wrote:
>>> [AMD Official Use Only - General]
>>>
>>> Hi Christian,
>>>
>>> The test sequence is executing a compute engine hang while running a 
>>> lot of containers submitting gfx jobs. We have advanced tdr mode and 
>>> mode2 reset enabled on driver.
>>> When a compute hang job timeout happens, the 2 jobs on the gfx 
>>> pending list maybe signaled after drm_sched_stop. So they will not 
>>> be removed from pending list but have the 
>>> DMA_FENCE_FLAG_SIGNALED_BIT set.
>>> At the amdgpu_device_recheck_guilty_jobs step, the first job will be 
>>> rerun and removed from pending list.
>>> At the resubmit setp, the second job (with signaled bit) will be 
>>> resubmitted. Since it still has signaled bit, drm_sched_job_done 
>>> will be called directly. This decrease the hw_rq_count which allows 
>>> more jobs emitted but did not clean fence_drv rcu ptr.
>>> This results in an overflow in the fence_drv. Since we will use 
>>> num_fences_mask in amdgpu_fence_process, when overflow happens, the 
>>> signal of some job will be skipped which result in an infinite wait 
>>> for the fence_drv rcu ptr.
>>>
>>> So close irq before sched_stop could avoid signal jobs after 
>>> drm_sched_stop. And signal job one by one in fence_process instead 
>>> of using a mask will handle the overflow situation.
>>>
>>> Another fix could be skip submitting jobs which already signaled 
>>> during resubmit stage, which may look cleaner.
>>>
>>> Please help give some advice.
>>
>>
>> How about the code bellow  instead ? The real problem is that we 
>> reuse a dma fence twice which is not according to fma fence design, 
>> so maybe this can help ?
>>
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 8adeb7469f1e..033f0ae16784 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -164,6 +164,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, 
>> struct dma_fence **f, struct amd
>>         if (job && job->job_run_counter) {
>>                 /* reinit seq for resubmitted jobs */
>>                 fence->seqno = seq;
>> +
>> +               /* For resubmitted job clear the singled bit */
>> +               celar_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
>> +
>
> Upstream will pretty much kill you for that.
>
> Re-setting a fence from a signaled to an unsignaled state is a massive 
> no-go.
>
> Christian.


Is it worse then doing fence->seqno = seq; ? This is already a huge hack 
, no ?

Andrey


>
>>
>>                 /* TO be inline with external fence creation and 
>> other drivers */
>>                 dma_fence_get(fence);
>>         } else {
>>
>>
>> Andrey
>>
>>
>>>
>>>
>>> Thanks,
>>> Victor
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Thursday, September 15, 2022 2:32 PM
>>> To: Zhao, Victor <Victor.Zhao@amd.com>; 
>>> amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey 
>>> <Andrey.Grodzovsky@amd.com>
>>> Cc: Deng, Emily <Emily.Deng@amd.com>
>>> Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>>
>>>
>>>
>>> Am 15.09.22 um 06:02 schrieb Zhao, Victor:
>>>> [AMD Official Use Only - General]
>>>>
>>>> Ping.
>>>>
>>>> Hi @Koenig, Christian and @Grodzovsky, Andrey,
>>>>
>>>> We found some reset related issues during stress test on the 
>>>> sequence. Please help give some comments.
>>>>
>>>>
>>>> Thanks,
>>>> Victor
>>>>
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: Victor Zhao <Victor.Zhao@amd.com>
>>>> Sent: Wednesday, September 14, 2022 6:10 PM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Grodzovsky, Andrey
>>>> <Andrey.Grodzovsky@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
>>>> Subject: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>>>
>>>> [background]
>>>> For a gpu recovery caused by a hang on one ring (e.g. compute), 
>>>> jobs from another ring (e.g. gfx) may continue signaling during 
>>>> drm_sched_stop stage. The signal bit will not be cleared.
>>>>
>>>> At the resubmit stage after recovery, the job with hw fence 
>>>> signaled bit set will call job done directly instead go through 
>>>> fence process.
>>>> This makes the hw_rq_count decrease but rcu fence pointer not 
>>>> cleared yet.
>>>>
>>>> Then overflow happens in the fence driver slots and some jobs may 
>>>> be skipped and leave the rcu pointer not cleared which makes an 
>>>> infinite wait for the slot on the next fence emitted.
>>>>
>>>> This infinite wait cause a job timeout on the emitting job. And 
>>>> driver will stuck at the its sched stop step because kthread_park 
>>>> cannot be done.
>>>>
>>>> [how]
>>>> 1. move amdgpu_fence_driver_isr_toggle earlier to close interrupt
>>>> before drm sched stop 2. handle all fences in fence process to aviod
>>>> skip when overflow happens
>>>>
>>>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 
>>>> +++++++++++++---  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  6 
>>>> +-----
>>>>    2 files changed, 14 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 943c9e750575..c0cfae52f12b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -4610,8 +4610,6 @@ int amdgpu_device_pre_asic_reset(struct 
>>>> amdgpu_device *adev,
>>>>            amdgpu_virt_fini_data_exchange(adev);
>>>>        }
>>>>    -    amdgpu_fence_driver_isr_toggle(adev, true);
>>>> -
>>>>        /* block all schedulers and reset given job's ring */
>>>>        for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>            struct amdgpu_ring *ring = adev->rings[i]; @@ -5214,6 
>>>> +5212,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>>                  amdgpu_device_ip_need_full_reset(tmp_adev))
>>>>                amdgpu_ras_suspend(tmp_adev);
>>>>    +        amdgpu_fence_driver_isr_toggle(tmp_adev, true);
>>>> +
>>>>            for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>                struct amdgpu_ring *ring = tmp_adev->rings[i];
>>>>    @@ -5228,8 +5228,12 @@ int amdgpu_device_gpu_recover(struct 
>>>> amdgpu_device *adev,
>>>>            atomic_inc(&tmp_adev->gpu_reset_counter);
>>>>        }
>>>>    -    if (need_emergency_restart)
>>>> +    if (need_emergency_restart) {
>>>> +        list_for_each_entry (tmp_adev, device_list_handle, 
>>>> reset_list) {
>>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>>> +        }
>>>>            goto skip_sched_resume;
>>>> +    }
>>>>           /*
>>>>         * Must check guilty signal here since after this point all 
>>>> old @@ -5240,6 +5244,9 @@ int amdgpu_device_gpu_recover(struct 
>>>> amdgpu_device *adev,
>>>>        if (job && dma_fence_is_signaled(&job->hw_fence)) {
>>>>            job_signaled = true;
>>>>            dev_info(adev->dev, "Guilty job already signaled, 
>>>> skipping HW
>>>> reset");
>>>> +        list_for_each_entry (tmp_adev, device_list_handle, 
>>>> reset_list) {
>>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>>> +        }
>>>>            goto skip_hw_reset;
>>>>        }
>>>>    @@ -5276,6 +5283,7 @@ int amdgpu_device_gpu_recover(struct 
>>>> amdgpu_device *adev,
>>>>            if (r && r == -EAGAIN) {
>>>>                set_bit(AMDGPU_SKIP_MODE2_RESET, 
>>>> &reset_context->flags);
>>>>                adev->asic_reset_res = 0;
>>>> +            amdgpu_fence_driver_isr_toggle(adev, true);
>>>>                goto retry;
>>>>            }
>>>>        }
>>>> @@ -5711,6 +5719,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct 
>>>> pci_dev *pdev)
>>>>        set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>>>>        set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
>>>>    +    amdgpu_fence_driver_isr_toggle(adev, true);
>>>> +
>>>>        adev->no_hw_access = true;
>>>>        r = amdgpu_device_pre_asic_reset(adev, &reset_context);
>>>>        adev->no_hw_access = false;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> index 8adeb7469f1e..65a877e1a7fc 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> @@ -287,15 +287,11 @@ bool amdgpu_fence_process(struct amdgpu_ring 
>>>> *ring)
>>>>        if (unlikely(seq == last_seq))
>>>>            return false;
>>>>    -    last_seq &= drv->num_fences_mask;
>>>> -    seq &= drv->num_fences_mask;
>>>> -
>>>>        do {
>>>>            struct dma_fence *fence, **ptr;
>>>>               ++last_seq;
>>>> -        last_seq &= drv->num_fences_mask;
>>>> -        ptr = &drv->fences[last_seq];
>>>> +        ptr = &drv->fences[last_seq & drv->num_fences_mask];
>>>>               /* There is always exactly one thread signaling this 
>>>> fence slot */
>>>>            fence = rcu_dereference_protected(*ptr, 1);
>>> Those changes here doesn't seem to make sense. Please explain 
>>> further why that is necessary.
>>>
>>> Christian.
>>>
>>>> -- 
>>>> 2.25.1
>
