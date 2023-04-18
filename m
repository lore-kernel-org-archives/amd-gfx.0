Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F05C77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Apr 2023 23:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D53E10E2B3;
	Tue, 18 Apr 2023 23:18:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 151F710E2B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Apr 2023 23:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxyYACld8IyssWRitQ68hCoO6qQwSKk2LfnLMXG/mrVxtOZcP+fMJtMVPQwctOjRb8LXoQsrYsbKxmBHkXB/9xwe3qiqTqqzmPPlQ3uNVVYdLAuC4/vKmb+2XjloZVv1BCNU9K9845H4ZdPQ3y91r2r4+yrX9gHrHOfoGqUY0rts65QXYUe3cq82DzFvuvKy00H9mOFoazXfkEzoEMRV5orulGrcwmHOd9lK63eYnHzxLTjDsJmkcqnSJlAq0GSbs3WZqVybvm3HTQhMRinbSc24JCD5Iba2ulfcuZWVz3c06N116Iq/NKFwayabFLqx/m61V5Ms0pCOgcMfDQA2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQYqbiFyxrunmmTNW5JbcuWtNPJAbCXe0aarToLjMaA=;
 b=nzzbFwR5loxCl8xgk6mkLglARKjvXYaH+uBOJXCUxS0Ch7tAmoxtts84khA08eqrB7ammoGnix/Q83d0CatB6LfvP9PafzRmaCodD10fsJvJtt0FB8Id2m1tzsfxeoOQvFT4Vkswx7B8ipdlxSzVNwtUYbQKcrCnWvaSidKTVzUberDOzDE/I6vYQLSDGLRZzKqvhJcYY/34doM6NezzsSuFuehyBr7xEzozfdtxxJKep2nQPepKeCMjTqyfWmbA+C75+5zUAg3uvsX22SO+sKYe+aUdyHAkOsphG8gCDyqCENp8uht2q0M0YPYoi8IYsMlmIa63V35sUPFox9BqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQYqbiFyxrunmmTNW5JbcuWtNPJAbCXe0aarToLjMaA=;
 b=HmoV2ZY+ozaKIJOdGTOmC/wch3C6zilHgxIeNCE2nfaanfiXVCPzDum90p2Cfkx1YnKDf/CRq8PreXUUXFBpSaRrOrkB42CmjzAXsgz4ldM/FR/WLUZz4Uyl44C0z3cr3KqhUbzqP9yr7uWFDFKisLX4IZNN41E4+K3b01utLZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 23:17:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 23:17:58 +0000
Message-ID: <76d79bab-6015-989b-55e0-4e9bb6c7d160@amd.com>
Date: Tue, 18 Apr 2023 19:17:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdkfd: Fix some issues at userptr buffer validation
 process.
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412061432.207610-1-xiaogang.chen@amd.com>
 <aa76e51f-8343-a1d0-a4a9-8f1329288535@amd.com>
 <da29b4b9-0c7a-21ca-a050-007f4c7ce203@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <da29b4b9-0c7a-21ca-a050-007f4c7ce203@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0407.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a818bf-f41f-4b86-66db-08db406325c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbF4/lN/YNJis8gYH0D6vnjbqL3VWcY9FI85+jDsl98IXQwsyiDvdJ4w8x7yFSvVwxvQU5+tI8Teh8D5UE6ZeMhzjR026Ov20ofCLJdvNm1wldHS0mWCk+CRZSVeKnuZKeh2YsLbSVNjBgyDBnoCuMLOByHhZTSAia/zkaWSTS8TY03wXabMJwYvbSVhLJOdYEidPYyLdDpjKlRSfD93Dg/cz2+iBjEdqj3XprmZW19caocH/Y4zJEhPDLQ9yoKiZOi7YBaCaUp1YtXQBQ8qDQ79YFRRzt58nzxZPDL02tpmvJ1npReqVs3JCdPSGRPO1LeRnvCBCFcmsKiVwQuXVZ2kWwuWiJnmu7rF/mHQOB4mGoLUICmjGKljTGj9rODfCsHinQb9C+XFe2JQ8Y+DywPAiZXATTG19d6hEoLsH0+nQqHC4TOMJdAjIU+ybIjP+4AiNwki0ViO/+b6SW1GCw6dvzTHU2FzUkCcgpQSp7wFscaw6z36uJSNmd4E3r1mqwJd58Q/Ju5JVk0DpUipSCuNVdN7+m3FGEdDauE3cWWvpJsDooYw1PDg2RWAoWzBU0UfGw9Gq0gxT4FcyQBoX0O1fgGbJJeAizqr6GIhD3zI7QdndtakbvOLYwjYzlrKKQsl7f9EAV+ymRR+75ZMCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(31686004)(36916002)(478600001)(6486002)(83380400001)(316002)(66556008)(41300700001)(2616005)(186003)(6512007)(26005)(53546011)(66946007)(6506007)(66476007)(44832011)(2906002)(8676002)(36756003)(38100700002)(8936002)(31696002)(5660300002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHlZNWorR3NzWjRRNEh4bC9QL3FKTjVBUnYrNDFKQkFjcExXMzVMUnZrb1lz?=
 =?utf-8?B?SDVYaEwyai96UEY0Nk4yNWVndEpIZXpFc3dSRkdVQjU5eXIreDBLRnBPbVNL?=
 =?utf-8?B?Q2F2U1I1bjREcFFrb3RHZXVUU3VUcVl5OXpvdisydkozdDJZQVcvdzJLS09Z?=
 =?utf-8?B?dXFueTAybjFjRUluYW1KdUg1R21aZU8wOUwxdUdaYzVtcU84Ty9ZYm9CL084?=
 =?utf-8?B?bzhSOTBCaUlVWmk1Rjc0WTZNdVdUTXo3THNBY3ZSTTYxaEd2Nnc5aXZGUjJy?=
 =?utf-8?B?bkduRW9zWElBTnFLdDZvYzlYRHh3eDBrbC85VzQxT1M2RDRuTW9IYmYrT0RV?=
 =?utf-8?B?Q2hMcW93emlKR0xod1lla3E3SXJHZG02OXJOMG95bVEvYllsUWNxaSs5dmpa?=
 =?utf-8?B?WlRpZGxySjJrb240Um90YzlKc2pVRDhBVmtqcktDK0xXb0dpSnJPUWY5YkhQ?=
 =?utf-8?B?UkxML3RSZEcvUlg3SWhuRkFkbjNHV042VlBnck16NEU2eGszcTc2MHZoSlU3?=
 =?utf-8?B?REViUHA4MjJOOWhaL0p0bDBYUkw5Q3dTeHVwdU8xeFJrSVJYUGhOTlBIaUxq?=
 =?utf-8?B?R0VWRGR6cm4vMHZTL3hGc04vTHpzUWs5NmhvZllrQzFsMU9XdjFrRXB0b1ll?=
 =?utf-8?B?emswOVFaUE9wdDU1V25LS0YvNms4aklEbFA4N1JSVWFCMCtucXBLbjk0Y1ZX?=
 =?utf-8?B?QThpSTQwY2dqMlh5QmJNYzIwengyMUJqc05pYlN4cC9jMlgzM1BvNER5cHdV?=
 =?utf-8?B?T3ZxNkFUdDNvTFkrWEFQOExTWmxvR1BNeVNiRGFYTitnamlLZ2UyTmlkRDBZ?=
 =?utf-8?B?Vm9KMG5XNGVXWUl0OTRjWmhFOFQxS2p0WWpaQ2hlbUVmVjIwQk9oNXltMStZ?=
 =?utf-8?B?QXA5aUZxemFzVTBiZGtXZlRwWXBFQkZjckpQT3Q2SkRIVVB4cjMxVVpVNCsr?=
 =?utf-8?B?a3ZraUtyeHN0TU1Sb0JuN0lPYWErN3VqODNqd2ZPYThlTDR3MTNHd2pCVUJH?=
 =?utf-8?B?RDQwZDA5dXovU1pqTVo1cC9mbVMwaWxnODRNbVNmSmdENUc4TmtxWHJra01R?=
 =?utf-8?B?RVMwYUREN0g4aWRmeGI1YlBOM1FQM0RxcTBqT0FpYkJESURybDBYR09HSDU2?=
 =?utf-8?B?NUhFMWFUbDN4NzhaekVFMGhnQ09pd2xCYVdHVi9ibXZoUmdpWFRNVWZ4bFho?=
 =?utf-8?B?MnE3dm9CazBjRHo5WEhid25KSitiTmswNDd1MHJIMXBRY0x2MXh0TS9LeFVF?=
 =?utf-8?B?dE9JU1k4WVk3Zm1FczEyNnVUSXJXTW1wRlpKUWxrbzdkU1REdVBORTNzOXda?=
 =?utf-8?B?eExLZWh4YUxvMW5YakVyQWREU1ZoZnJXN3FCRFVxU2J6M0pTTER3eHZrRFV6?=
 =?utf-8?B?TkN6cUQ4WHUrNG5ZbllmMDdvSVE1NkFFa0lFeWszaVZWVVVQcE5GM3Y5ODZj?=
 =?utf-8?B?R0oxQzVlTlBYR29Hd3pYQUFCU09JdHBNVWwwbmwzTmNucjBScmZTYVEvdlk4?=
 =?utf-8?B?a0lhQmtobW1SZysrOHN0UVN1MTNraTRSMEN3cjdwdDhMVjI0US95WXVoWUJI?=
 =?utf-8?B?K2p5L1cweDFOdHU2T0REV2NoRjZnUWJXcGtBQzB4UXk0dDRIczRLQTJwMHhY?=
 =?utf-8?B?Y1VMbElOdE1yYlJleUxzWUcxUm5hNTlXZGhJWFUxdWJCa0V6d0FLQkNLQStn?=
 =?utf-8?B?eEczQnE5ZkQrTlNuanprSEpWaWFwcHFxejNUYzZ3VC9KUGJrc0ZiSE42WVRu?=
 =?utf-8?B?MXFjYzVoNG1vbkRYcHNSMXI1SzQvQU1CSUtzTWxSbkdzODhsUDZjYnJ2U1RE?=
 =?utf-8?B?UlBTbmc5VkxrV2hCb0FTalBJSnpNSk1Kai82ek0xT2RQR0h1WGppL0ZoSGJY?=
 =?utf-8?B?aE50eDNaRjY3SlYvVU9BU0lmT0JscmV4ZnpRSG1rdVVzK3BPcVJ6SFN3T3Nq?=
 =?utf-8?B?bjVOWHNTMUNIUVFvNm9RbW96dGNtMXVIalJ5M0ZIVWIydFlTMjVoUE9Oelgx?=
 =?utf-8?B?cTF6cUJVMzd2WEZHaE1mTE9KQ1p0a3Nld1lDdzlRTU4zUDZ5dUo3SHFyeWdY?=
 =?utf-8?B?djdTV0F0a3NEc3NiY21QTUErT01oMUYwcTNnSkpGT2RsOEk0anhSS3JkSXly?=
 =?utf-8?Q?WvPkMUsWYZvjs5S4yAN9RQCPd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a818bf-f41f-4b86-66db-08db406325c3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 23:17:58.3864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1sGYeeeTfvQyi4e3Ds/m/+oFDNZY7tcF2tTejmUkfRIG/0vGDNxDBCS3XBUxu0Zj0ZinqDliBoKEIfXXFOXLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-04-13 23:27, Chen, Xiaogang wrote:
>
> On 4/13/2023 3:08 PM, Felix Kuehling wrote:
>> Am 2023-04-12 um 02:14 schrieb Xiaogang.Chen:
>>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>>
>>> Notice userptr buffer restore process has following issues:
>>>
>>> 1: amdgpu_ttm_tt_get_user_pages can fail(-EFAULT). If it failed we 
>>> should not set
>>> it valid(mem->invalid = 0). In this case mem has no associated hmm 
>>> range or user_pages
>>> associated.
>>
>> We don't want to suspend the process indefinitely when this happens. 
>> This can happen if usermode calls munmap before unregistering the 
>> userptr. What we want to happen in this case is, the process should 
>> resume. If it accesses the virtual address, it will result in a page 
>> fault, which alerts the application to its mistake. If it doesn't 
>> access the virtual address, then there is no harm.
>>
>> It's a good catch that there is no useful hmm_range in this case to 
>> check validity, so we should not warn about it in 
>> confirm_valid_user_pages_locked.
>>
> Not sure why you said "suspend the process indefinitely". When 
> mem(kgd_mem) has no hmm_range due to amdgpu_ttm_tt_get_user_pages fail 
> the patch does not mark it valid( set mem->invalid != 0) and keep it 
> at userptr_inval_list. The process has not been suspended.

User mode queues are stopped. Until the queues are restarted, the 
process is effectively suspended (for GPU execution). If invalid userptr 
mappings cause restore to fail, that means, the GPU queues will remain 
stopped. That's what I mean with "suspend the process indefinitely".


>
> Yes, in this customer application case amdgpu_ttm_tt_get_user_pages 
> failed at vma_lookup. I think it unmap its buffer before unregister 
> from KFD. This patch handles amdgpu_ttm_tt_get_user_pages in general: 
> not mark it valid(mem->invalid != 0), keep it at userptr_inval_list, 
> then at confirm_valid_user_pages_locked, check if mem has hmm range 
> associated before WARN.

I think it would be easier to just mark it as valid. mem->invalid == 0 
means, it's safe to resume the user mode queues. For userptrs without a 
valid VMA this is the case as the corresponding page table entries have 
been invalidated (V=0).


>
>>> 2: mmu notifier can happen concurrently and update 
>>> mem->range->notifier->invalidate_seq,
>>> but not mem->range->notifier_seq. That causes 
>>> mem->range->notifier_seq stale
>>> when mem is in process_info->userptr_inval_list and 
>>> amdgpu_amdkfd_restore_userptr_worker
>>> got interrupted. At next rescheduled next attempt we use stale 
>>> mem->range->notifier_seq
>>> to compare with mem->range->notifier->invalidate_seq.
>>
>> amdgpu_hmm_range_get_pages updates mem->range->notifier_seq with the 
>> current mem->range->notifier->invalidate_seq. If an eviction happens 
>> after this, there is a collision and the range needs to be 
>> revalidated. I think when you say "mem->range->notifier_seq is 
>> stale", it means there was a collision. When this happens, 
>> mem->invalid should be set to true at the same time. So 
>> confirm_valid_user_pages_locked should not complain because 
>> mem->invalid and amdgpu_ttm_tt_get_user_pages_done should agree that 
>> the range is invalid.
>>
> Yes, "mem->range->notifier_seq is stale" means it is different from 
> mem->range->notifier_seq. It is caused by mmu notifier happened 
> concurrently on same buffer that is still in restore process. For this 
> case the patch update mem->range->notifier_seq:
>
> +            if (mem->range)
> +                mem->range->notifier_seq = 
> mem->range->notifier->invalidate_seq;

You should not update mem->range->notifier_seq without also getting an 
up-to-date page address list. Matching sequence numbers indicate that 
your page list is up to date. If you just update the sequence number, 
you're basically lying to yourself.

You need to call amdgpu_hmm_range_get_pages to get an updated page list 
and update the mem->range->notifier_seq at the same time. There is no 
need to do this in more than one place. That's in update_invalid_user_pages.


>
> Then restore process will skip confirm_valid_user_pages_locked, jump 
> to next scheduled attempt: "goto unlock_notifier_out".
>
>> "At next rescheduled next attempt we use stale 
>> mem->range->notifier_seq": This is not really stale. The notifier_seq 
>> indicates whether the pages returned by the last call to 
>> amdgpu_hmm_range_get_pages are still valid. If it's "stale", it means 
>> an invalidation (evict_userptr) happened and we need to 
>> amdgpu_hmm_range_get_pages again. In theory, if an invalidation 
>> happened since the last call, then mem->invalid should also be true. 
>> So again, the sequence numbers and mem->invalid should agree and 
>> there should be no warning.
>>
> When invalidation (evict_userptr) happen concurrently restore process 
> will schedule next attempt. The mem->invalid is set to true by 
> evict_userptr, also the sequence numbers. Both agree and with this 
> patch we do not see WARN.

Why do they disagree without this patch? I think what you did there 
(updating the sequence number without getting updated pages) is 
incorrect. If the sequence number and mem->invalid are updated together 
under the same lock, they should always agree. There should be no need 
to mess with the sequence numbers after the fact.

Regards,
   Felix


>> The warning messages printed in confirm_valid_user_pages_locked 
>> indicate that there is a mismatch between the sequence numbers and 
>> mem->invalid. As I understand it, such a mismatch should be 
>> impossible. Unless there are some bad assumptions in the code. I 
>> haven't figured out what those bad assumptions are yet. Other than 
>> the case for -EFAULT you pointed out above.
>>
> From my debugging this customer app the warnings is due to we did not 
> handle well if amdgpu_hmm_range_get_pages return -EFAULT and mmu 
> notifier happen on same buffer concurrently. That lead we use mem 
> without hmm range associated and stale mem->range->notifier_seq for 
> following operations. With this patch there is no warning messages and 
> not see other errors.
>
> Xiaogang
>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>>> ---
>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 45 
>>> +++++++++++++++----
>>>   1 file changed, 37 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 7b1f5933ebaa..6881f1b0844c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -2444,7 +2444,9 @@ static int update_invalid_user_pages(struct 
>>> amdkfd_process_info *process_info,
>>>               ret = -EAGAIN;
>>>               goto unlock_out;
>>>           }
>>> -        mem->invalid = 0;
>>> +         /* set mem valid if mem has hmm range associated */
>>> +        if (mem->range)
>>> +            mem->invalid = 0;
>>>       }
>>>     unlock_out:
>>> @@ -2576,16 +2578,28 @@ static int 
>>> confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
>>>       list_for_each_entry_safe(mem, tmp_mem,
>>>                    &process_info->userptr_inval_list,
>>>                    validate_list.head) {
>>> -        bool valid = amdgpu_ttm_tt_get_user_pages_done(
>>> -                mem->bo->tbo.ttm, mem->range);
>>> +        /* Only check mem with hmm range associated */
>>> +        bool valid;
>>>   -        mem->range = NULL;
>>> -        if (!valid) {
>>> -            WARN(!mem->invalid, "Invalid BO not marked invalid");
>>> +        if (mem->range) {
>>> +            valid = amdgpu_ttm_tt_get_user_pages_done(
>>> +                    mem->bo->tbo.ttm, mem->range);
>>> +
>>> +            mem->range = NULL;
>>> +            if (!valid) {
>>> +                WARN(!mem->invalid, "Invalid BO not marked invalid");
>>> +                ret = -EAGAIN;
>>> +                continue;
>>> +            }
>>> +        } else
>>> +            /* keep mem without hmm range at userptr_inval_list */
>>> +            continue;
>>> +
>>> +        if (mem->invalid) {
>>> +            WARN(1, "Valid BO is marked invalid");
>>>               ret = -EAGAIN;
>>>               continue;
>>>           }
>>> -        WARN(mem->invalid, "Valid BO is marked invalid");
>>>             list_move_tail(&mem->validate_list.head,
>>> &process_info->userptr_valid_list);
>>> @@ -2644,8 +2658,23 @@ static void 
>>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>>        * reference counting inside KFD will handle this case.
>>>        */
>>>       mutex_lock(&process_info->notifier_lock);
>>> -    if (process_info->evicted_bos != evicted_bos)
>>> +    if (process_info->evicted_bos != evicted_bos) {
>>> +        /* mmu notifier interrupted 
>>> amdgpu_amdkfd_restore_userptr_worker
>>> +         * before reschedule next attempt update stale 
>>> mem->range->notifier_seq
>>> +         * inside userptr_inval_list
>>> +         */
>>> +        struct kgd_mem *mem, *tmp_mem;
>>> +
>>> +        list_for_each_entry_safe(mem, tmp_mem,
>>> +                &process_info->userptr_inval_list,
>>> +                validate_list.head) {
>>> +
>>> +            if (mem->range)
>>> +                mem->range->notifier_seq = 
>>> mem->range->notifier->invalidate_seq;
>>> +        }
>>> +
>>>           goto unlock_notifier_out;
>>> +    }
>>>         if (confirm_valid_user_pages_locked(process_info)) {
>>>           WARN(1, "User pages unexpectedly invalid");
