Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAF1C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 16:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA57E10E49C;
	Thu, 30 Jun 2022 16:09:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBA010E49C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 16:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D697r9nC022fRmkdmr9edJl2mDp19ss8SOCe9mPPHhe4hw/5DdPgenEfofr0oDceqZtB1bg6ZzQShaFbuEYePqd2uu0GelIRuBVFgvBLxBRikonC85XJ/b/VqpFdekRdxMnvSeyYoPqnq//OrBHM2id/3zP295N8wTASPW3mn7KNwEaEshQrwtmgNF5HNfdLzGn2bY2zXMJ9bAMc+87bqtr+FwYGVqC1LOKJKpO8YLmXU2aCufU0q/x+kpj/9FislwQWKewlQq9fJCqAP4zOPaFwfENnlqP3p7Xqh9VbQ2VTQvAYsMeNdIYhT012dSvAuK9Dl9GWB0ohmQfMlA2tgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geOtrwJmr715nX41Y0S6UcEjYGRGv9qoCfTSzf4AcsU=;
 b=GN6a5X3SPAYOn3UbjWzqlX2yfWQuAVPbDrj4IgPbipc+6oikmKrY+Q8jPnluw+S1jx3kkNu5qP9PYyFBFZtRCSuoSCLHbkS/2Fo4fmuHngonJBJ/7O3eHge8/+3SohGd7EqAKtUik5pf2ELDb5PE8owrRg+xQugQSks7AK5X220/sQ1lz/nFl5ALRdGDH9Ziokti93Ju5RlpkxrY32I5D7wPW0Bi9l5X0q3oMqFEl8EC2Cq4ytqMUfs/u/VBDRpvy0zrmWMmZNd0MXtTzOgPugDkQByCMNRswjLgayST3NvbilhJWTzHf12WoKUmRLUtGEwFWjaFOSMop1rUpvuErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geOtrwJmr715nX41Y0S6UcEjYGRGv9qoCfTSzf4AcsU=;
 b=KfFbacnHyBSBb6LFzYjO+0KR/RL0t95ybReAqxPYwS1hvvFFY6qZ95MGE7FqdR0k96r0CXiVIG+wVds/QtJN3Rs8OzOg+Xh6dYJCH0PdBKcvjTBd7/GPh6IB+C7EY6bSGvRXdNsH/cx3yWrOb8LYIC0AkLnlo4/zOv1ylZy/KNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Thu, 30 Jun
 2022 16:09:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 16:09:02 +0000
Message-ID: <a5164fac-3e8c-3ac4-8ea7-88fe17c55914@amd.com>
Date: Thu, 30 Jun 2022 12:09:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] drm/amdkfd: change svm range evict
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628214315.235160-1-jinhuieric.huang@amd.com>
 <20220628214315.235160-3-jinhuieric.huang@amd.com>
 <99b8907f-9aa7-7aec-4895-cc94b0b58bec@amd.com>
 <4bf772cd-f66a-2dc6-4ace-81c56e3f6436@amd.com>
 <c3f52156-1a71-87c2-a84a-323fcaf85251@amd.com>
 <690ee98a-7fc7-83b1-3d80-2e28079275c6@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <690ee98a-7fc7-83b1-3d80-2e28079275c6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:610:4c::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f4d302f-8f87-4c95-5187-08da5ab2d97b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IjrvZD6BL/ce0DDovJzgJXaXpwnUZR5XPUILOMNidtngLIUuQc3MymvWRs7vcFx66rKKxHY9fSPASkyET91TUAgWgtnH32dAi5mGqqpTCN6zB/vDCqKPY79pnMy20yjGvYnGWA4/6bYkDluz7ddYIC6m0NThsZFwvq8trEJohee//cu34cTWMhUHTrL8U/xIepcCDZT0vY146tq142DtBSMGqeM3IhAvGGWZacotxvvJJYYcA+ZSJ7rWKaywWteeekb1XLpZX+Dwh17SaWfWduttsC/wab/7Cut9gjQ/OA4O0LAyMQiio6aZerbM0JPIkAbmVvIgfGRxFOaLKOCHJ6limbX+hH404322WGMkwoB53AvIRgP8bMFb1nzITmWP0UNZOXxRLk279e6Jynu2PWZVtvVsnKhKabhoBHlpDs+BtMU5LSdoQmgtkVW2k0YZTWtsrzJfrgZNO+mROtONjSbRc8qQZs7hpO/yFwqqN5/IzMx73mo/bIPzPXe3YB4CHh+UTsZ7dd1pdxWZr1nNvDkp/O4qk824G+OlmvzuxfewwoCYa2rYtcjkL0n4W12FVzUSEsxP5UBOHZAn85WKL4XoifqOdIfvvYU9QLIXk6Nm5n5+TrJAf4xiPe62lTYHzHfF2y60i3qD0f7SfcuiuZ7i7jRN4hgApwDbeUng3jgrLW/ANy8J/rbQ7xl7CL7a0eha0kw34yOLWQVEI7HUfNsIGaRFdgjCu0sJjvA4vWdEfY8pLjW+Ipf6gqUJw3AWYVLE0WKVPT/aKm7m+jDIwbeyKbkRuDbEHVkTtiP9YUERHMraHi4vjpa6US5jGtcZL2jhorrVI9iXkh7V3OKzSXoXcXeuvH4fZZUtErxU/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(316002)(36916002)(6486002)(36756003)(4326008)(66476007)(6506007)(31696002)(186003)(2906002)(2616005)(478600001)(66556008)(66946007)(26005)(86362001)(6512007)(53546011)(38100700002)(44832011)(8676002)(8936002)(31686004)(83380400001)(5660300002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUk2dDFZdmpWbDN6VWs3MnZZNnpQeFFPMFBCaVVUck0zS3o0WThicUl2TlRi?=
 =?utf-8?B?WHN3K3UvWlozR0t0THZZMWx0ejBvQlFnRWxYbHFZcVFxK212dDdXOU1PN2tC?=
 =?utf-8?B?NHhNREUvQ3ZSNlNzK0dZWU1VVElsZG11SEd5a0lsU05NNld3ZG9hdUV6SFhZ?=
 =?utf-8?B?Y2Y2eWNlYXpVaW9QdUxyblp1NW0raTRPNnpRY3JWNmh5YzJUaERXMGpiU2Zz?=
 =?utf-8?B?ekZlUGQyS01kWDRUOEVrSzBGdWNYRzU2MzBBRGJqV3UxbllMa3lqOFBLbzNx?=
 =?utf-8?B?Q3VCZm1qdnp2L29oUk81MFlIdGhHb1AvN2pRcG04N0F1MUs4Vmg4Uy9iZjhU?=
 =?utf-8?B?dFJ1UEpaWFpHRStzN0p2TDJuM3VsK2hiOVBmSFZ1eUFSQWZLQ2kzdUdWa2Q4?=
 =?utf-8?B?OUZFbTMzZk1adng5V3RtL0VjVGJPdDFHUFgrdTRkbTZYQ1k5SnVxYWF0RlNE?=
 =?utf-8?B?SVkwTjN2MklhY0F0WmZnT3M2Zlk4NjZoaEt5eEtDdjN6UWMvNlFIOHc4cDNN?=
 =?utf-8?B?OERqcUVKQk1Xbkx2UUV2Z2cvajFyelJuaEZpcmdkRnk5R2Z3ZDM2VW9Ud2tD?=
 =?utf-8?B?MVpVVnpyRWdWL3VlTlVQL2wzVlIxczJqTjFKb01XWE92dFoyTFhxMmhMYmJw?=
 =?utf-8?B?UnY3bzc3S0NJbXFveHF3SUxUNWJiS21ZVzRnaWlxY0ptQnl0ZkllYUJwd0RO?=
 =?utf-8?B?bmRXTHdwNC90NENWNnhPOHVzQUdzSDRlRnJiT0lLQlNkRHpkd0gxMWY5d3c1?=
 =?utf-8?B?RUdpUDNGd3FWUWVyTlM0L1djMHNTckN4TlNqdnhwdTllRmdQMzRxeDVETDFW?=
 =?utf-8?B?TEppSGZTNlJLZCtVQ3dNQXZuYXlCRGJaUmtpYnI2eER0eElremhDcUk1d0lU?=
 =?utf-8?B?N1VjM2o4RW9RNVplQlo2UzZZVWZTazBYbUNBaENtVHhESDZQcFloaGU5a2ZE?=
 =?utf-8?B?RWtRVjE4TjI5cXFnL0Z5dndHZ1Z1aFRUcnZzN05oZVFBMUh0UG5tbjB3Rmhp?=
 =?utf-8?B?VDFEaTFnZU5vQnFFU1R6RlBYdE9HV0MwanRUNHFnUC9SWW52WDFJbSt4eFBj?=
 =?utf-8?B?Rm5TRGc1aVB3OGNzZEt6SjdLVlZ3dGEvNWhQNElGNy81M1JSanVoQ1hyMU1x?=
 =?utf-8?B?UnRTWURPeXZDREFrK2RQRHMxYzJjM2oyTHJsYnNnWmRHU00xMU1aR0lyMjhT?=
 =?utf-8?B?aHFONUFnNFU0MEtITkRjdXl6M2RUSGpRaWVBY084NkR0UU1RaUdwU081MmRk?=
 =?utf-8?B?aURCTiszYWYyVW5DcnZQdXNFbDBFekMzdGx2djUrNHlsSm9icklCU2NIRFpj?=
 =?utf-8?B?ZDUxbkZkMk5tSzNqeDdwUmdPTm9NYUJjbjZrd1N3L2N5MnlmV0huVEVXYWM1?=
 =?utf-8?B?a3RUMU9pVGp4QmxlS2lzUFNpd1FCQ2R2ZHZSOGNSZjUybkVaVVJXS29DR1Z5?=
 =?utf-8?B?Q0hzM2plc3pCUXRQUk1SWXd3OC9KZDU2c3hmOFFYN0o2cnpDWmkzU3Q3anZ2?=
 =?utf-8?B?RDFuWDFlYlVJUmFMaEdKL3ZMMDRCUGlCTHdVUkRHeHFBNzlVMjFqalptWWpM?=
 =?utf-8?B?R0ZBbG40YWc4aU5temRDd3lINnZOTlhKZFlLVWVFRjV0eDl2QzJ4KzhsVTlS?=
 =?utf-8?B?MGxBaUVINy9vTHpaalZmNWZ4WjkxK3c4dGpYckcvTWY3eUZMa2toa0NKYXFT?=
 =?utf-8?B?RUpZYkNiTmFwZS8zV0NvMFI0aTZ4UmM5NmpIQ0IxZ0pNS0NOSEUyQk5DSHYz?=
 =?utf-8?B?QkxNWU5wWWZnem1jUDNPUmI1S2FEZW9IdU5LRWFXU1pxc25kV3lKSER3VWpv?=
 =?utf-8?B?bmNMa2c5TkRJMGZvZm4xNVVFVDBublpiQ1EzVVFwNUJWaGNhZEVNUE9zY1d6?=
 =?utf-8?B?cHp3MzVpeDE1TzFDMFBNZ2hqMnVLUVdOdjdaU3l0MlV3enRYbzhsa090VzJk?=
 =?utf-8?B?K0FXSzJIbUpqbFZTOW9PcFhOZThtd0hJVUt6NC9LU1JRMFNWNWYyVGtjNG1R?=
 =?utf-8?B?djlVbHlpWkJ1ZUZOckxENU80UGdqc0NLajE4OUVybThQM3YramxqeUQyeEhv?=
 =?utf-8?B?RElXWTNiM3BabWFhVDduSHhBeS9DYVFMLzNCZ2ZSVEF6aGZ4R3lqanUxWWZm?=
 =?utf-8?Q?b8fgKn2AcEVmHH7ARopCOSNOV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4d302f-8f87-4c95-5187-08da5ab2d97b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 16:09:02.7637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BF1nJLyydZro2jRNN3gZEAap8UJXQ6+24uiXfvU77ZANJS5ldgYKXOWqK3q5JUq8CTMcJQzMq2lGyILEqBFgkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-30 11:19, Eric Huang wrote:
>
> On 2022-06-29 19:29, Felix Kuehling wrote:
>> On 2022-06-29 18:53, Eric Huang wrote:
>>>
>>>
>>> On 2022-06-29 18:20, Felix Kuehling wrote:
>>>> On 2022-06-28 17:43, Eric Huang wrote:
>>>>> Two changes:
>>>>> 1. reducing unnecessary evict/unmap when range is not mapped to gpu.
>>>>> 2. adding always evict when flags is set to always_mapped.
>>>>>
>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 10 ++++++++--
>>>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> index 4bf2f75f853b..76e817687ef9 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> @@ -1767,12 +1767,16 @@ svm_range_evict(struct svm_range *prange, 
>>>>> struct mm_struct *mm,
>>>>>       struct kfd_process *p;
>>>>>       int r = 0;
>>>>>   +    if (!prange->mapped_to_gpu)
>>>>> +        return 0;
>>>>
>>>> This feels like an unrelated optimization that should be in a 
>>>> separate patch.
>>>>
>>>> But I'm not sure this is correct, because it doesn't consider child 
>>>> ranges. svm_range_unmap_from_gpus already contains this check, so 
>>>> ranges should not be unmapped unnecessarily either way. Is there 
>>>> any other benefit to this change that I'm missing?
>>> I will send another patch separately that considers child ranges.
>>
>> I think this should only be done in the XNACK-off case. For XNACK-on 
>> it's already handled in the svm_range_unmap_from_gpus.
> Yes and It is also done when KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED is set.
>>
>>
>>> The benefit is it will reduce unnecessary queue evicts when 
>>> allocating context save memory, which is unmapped to gpu.
>>
>> That sounds wrong. The context save area should never be unmapped 
>> from GPU. That's the whole point of setting the 
>> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED flag. I guess this is happening 
>> while migrating the context save area to VRAM for the first time, 
>> even before it's mapped to GPU?
> Yes. It is for the first time when registering svm range and migrating 
> to VRAM are doing together, at this moment, the range is not mapped to 
> GPU.
>>
>> I think there may be another eviction, when the CWSR header is 
>> initialized by the CPU. That would also migrate it back to system 
>> memory. To avoid that, you should probably register the context save 
>> area only after the header has been initialized.
> Yes. I am using this way. Please look at patch 4/4.
>>
>> I think avoiding an eviction when memory is migrated when it is first 
>> registered is worthwhile, not just for CWSR.
>>
>>
>>> It is for efficiency reason. On the other hand, without this 
>>> optimization KFDCWSRTest.InterruptRestore fails with queue 
>>> preemption error.
>>
>> What do you mean by "queue preemption error"? Does HWS hang?
> HWS doesn't hang immediately, so there is not error for fence timeout 
> "The cp might be in an unrecoverable state due to an unsuccessful 
> queues preemption". The error is "HIQ MQD's queue_doorbell_id0 is not 
> 0, Queue preemption time out" after checking mqd manager, which means 
> HWS abandons unmap queue request without returning timeout error to 
> driver. And after this error, the following test will fail at queue 
> creation as HWS hangs

OK, that sounds like the kind of bug the InterruptRestore test is meant 
to catch. I think you just created a better test by causing more 
preemptions. ;)

So we should do two things:

  * Avoid unnecessary preemptions in KFD
  * Improve the test to reproduce this hang even without unnecessary
    preemptions in KFD, so we can investigate the issue

Regards,
   Felix


>>
>>
>>> I think the reason is the extra queue evicts make HWS too busy to 
>>> preempt existing queues. There is one unmap_queue packet sent to HWS 
>>> in current code, and will be three unmap_queue packets with unified 
>>> memory allocation.
>>
>> When queues of a process are already evicted, they should not get 
>> evicted again. That's handled by the qpd->evicted counter. There 
>> should never be multiple unmap_queues packets in flight at the same 
>> time. If you're seeing three unmap_queues, you should also see queues 
>> restored three times.
>>
>> HWS should never be too busy to evict queues. If you're seeing 
>> preemptions fail, you may have found a bug.
> The restore delay worker will do something differently in term of 
> timing. It could restore queues before next unmap_queues, so the 
> situation is too complicate to debug in multiple queues evict/restore 
> environment. The error definitely means there is a bug, from driver 
> point of view there is nothing wrong even adding extra queue eviction, 
> so I try to avoid extra queue eviction and keep it as before. The 
> bottom line is to make sure unified svm range for context save area 
> doesn't cause any failure in kfdtest, so I can theoretically assume 
> extra queue eviction/restoring causes HWS failure.
>
> Regards,
> Eric
>>
>> Regards,
>>   Felix
>>
>>
>>> So this optimization will keep only one unmap_queue as before.
>>>
>>> Regards,
>>> Eric
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>> +
>>>>>       p = container_of(svms, struct kfd_process, svms);
>>>>>         pr_debug("invalidate svms 0x%p prange [0x%lx 0x%lx] [0x%lx 
>>>>> 0x%lx]\n",
>>>>>            svms, prange->start, prange->last, start, last);
>>>>>   -    if (!p->xnack_enabled) {
>>>>> +    if (!p->xnack_enabled ||
>>>>> +        (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
>>>>>           int evicted_ranges;
>>>>>             list_for_each_entry(pchild, &prange->child_list, 
>>>>> child_list) {
>>>>> @@ -3321,7 +3325,9 @@ svm_range_set_attr(struct kfd_process *p, 
>>>>> struct mm_struct *mm,
>>>>>           if (r)
>>>>>               goto out_unlock_range;
>>>>>   -        if (migrated && !p->xnack_enabled) {
>>>>> +        if (migrated && (!p->xnack_enabled ||
>>>>> +            (prange->flags & 
>>>>> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
>>>>> +            prange->mapped_to_gpu) {
>>>>>               pr_debug("restore_work will update mappings of 
>>>>> GPUs\n");
>>>>>               mutex_unlock(&prange->migrate_mutex);
>>>>>               continue;
>>>
>
