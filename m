Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC408CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 20:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF61810E06D;
	Thu, 19 Oct 2023 20:14:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D96A10E06D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 20:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF0VVKOOuINmzfnY2CAIrLSLdz9GmCbsxP8LhQ4WAuyHW82tDl+L8jmz7ahTk719Fq3jxRp+B/3nPyy21fT4nJKK0fS+fu+MXcCRt4be4VeCLKDX1h+dB2GoAqZ99KM6TLFnpBtQ1UDeisT57ayDRyAXkT1ChBhANDpS24usN575CsZA+g5yigAVQk3RpCUJOoLmBuIwEyD9iJvUCpLQgNqSvcfmNSbUO/IiWTJEvv8pVcbYDl8ZUWc62f30RmGpu/epSEVDZQB4kbdBZAFznzmX2trDYo/bcaNKgNhnkPMmWHG+Vt0droF52hiiQ0ls+ic2wqSm2hfGr+tPAzBhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4krZG6WBBpMIPDUeJS2oqsl1XcXNOfr5jTd9WR8BFk=;
 b=RJUArvGFPMEQO5DNTHwmiX6mrEv8Me/3NIVfftr6Phua3Jt/XIQPTj6p8s4RtikIrrMano3Ax88gSZzC2QkRxQ0bHpipaP60sjyk4KDup4ys8PZsuLDvPWXa2sWJ/36XFlJUvb3CPFgjc9cwZqQ42bUmywa5VfzvqpXoyegmSBD3ESm4nzVJJTlsLk8IndVYR3iZG/Khov4DGKd7K0ErWrmFKm9A79qNGLXXB6zpXuoROO58wVcvXWSPnCzRJWTLWErbzOeBBxWu7xYNX1fw5i+aqXxC3BAigyRmv2Ytac+mAhpCTa8reVkTrcfqfI6y8sko+sYpKdT2L5iCPbZxWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4krZG6WBBpMIPDUeJS2oqsl1XcXNOfr5jTd9WR8BFk=;
 b=0BpC9nrLHMjeNShNN/cl5NoUlBjg0gPkrgHFVxHPXnR+GsAiFa9jQ94fe9tZKsXcp8ce+OEYRkU6trXmPSsiy1eQ0f6S26ZVLjCTsT9gVmUxN3kv/HvWhLYsUY2mYvK2m6oYcyuag1rNjK/58qh6sXii21s990NPd6EqWk1Z8Lk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Thu, 19 Oct 2023 20:14:53 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8b00:757c:424:38c2]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8b00:757c:424:38c2%6]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 20:14:52 +0000
Message-ID: <8b0c0c80-e0f2-1eaa-4f62-ababa0a2077d@amd.com>
Date: Thu, 19 Oct 2023 15:14:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Use partial mapping in GPU page fault recovery
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231019142441.622430-1-xiaogang.chen@amd.com>
 <9e5addf0-9e91-d67d-af6e-e89479572478@amd.com>
 <56bbfe3b-38ec-22c3-4f57-61c409bc7c6c@amd.com>
 <969b5e0b-af22-7cfd-cfab-dbba402d1b01@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <969b5e0b-af22-7cfd-cfab-dbba402d1b01@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0119.namprd11.prod.outlook.com
 (2603:10b6:806:d1::34) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae8650d-fcdb-4e35-3ccf-08dbd0e00de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdXMRkL4j8iM55AUo01sJuqCu5Rem33m6RieqGrUXMr+V8LkpUYkmD+ojOex3fLVWShcB+HI23WGFcK48rVkh6SpZbVLk1ky1V6Dm0G1rlkv8oZLu+2+TuZFydhHuEMCBBxSeGkzaRdph45EBqEiOIlsBzjyhkXkA7Ks2SYYEpJ0QsFbcSbFTQDK+UTCY71FBnF1bLqOw8DB9d2wyjzWIgBRT6aYX9KWbb7KoWgNUwPgqEqEg3XSmxb8h3N1Q2s1HErSd1uDepDXiAoX+wuesbq8PRVXGS2FBTBnbJ572h8QYSysDxwO4igGME87nxQBdoqtVICByEaUNtW+gO0J238Cdz90mrmBXoTVCHp8JLuA/A51v8LCY+RkEMG97Wk4XlaaYwfSuQNVMvz5/whGYmgOyC+R4o638eYFNQYZUzRfJquKSjcZSMgPCp201vNZ7IAc6iH2MoYYqKXrT/TXfsROLiJ9nzvkYidb8k7ofj2rjjsAEgrhwRrWkIkp14eQK7O+nClge1Y+M2cJDWN8FehTI74I+tb1orF5B+xamSVA8pNtSkkfdP95KoHqzi1OXhPPZk+73tnP0E1PokviJDlHxU639Ix8apEhPlu20P7hO0L8dsKIkFYPYNBht8nuSktkJ/CWf0G6A9QmDQjfgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(478600001)(6486002)(31696002)(6666004)(5660300002)(4326008)(41300700001)(8676002)(8936002)(66556008)(66476007)(66946007)(36756003)(316002)(83380400001)(26005)(6506007)(2616005)(31686004)(4001150100001)(53546011)(38100700002)(86362001)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0l4Z20ya2E1OW1MWGZpUnIwcXh5eFNtQkxTWXE5bUFtSlpKQ0c3V2MxaUtY?=
 =?utf-8?B?VVl2bWVrTHBRQndSVlhwcGxjL1krbDFzUlZEdnozTWdoZWpWcmM5MUhHSnR4?=
 =?utf-8?B?ZEtJU3Q4aHlzZC83OXJIQWVQU3lzNDgrT2svUnZYMTFHZm5QeGphU3c5U012?=
 =?utf-8?B?VFNLcGMrRElnOTEzOE02V3NuMVlUOUJjR0Zqd2l0Y1Y3bFF3cnA5QTBSNkQ5?=
 =?utf-8?B?RXNCNGdTV1VhS2V6akNnSkNlMzFZV09saDdvOW5tQzhzN0s2TEtvTkd4NXVV?=
 =?utf-8?B?QjdjVGI2OXY2ZnByak92eFU3bHdlaUExTU1pZHFVdE01ZGd3dnBhOFV4cHpq?=
 =?utf-8?B?TmhSNFA2OVFWMDFjVmZBd3ZzK0NhVEhJbFJ6Qm5SRXY4SGlsQmdORDZlWStT?=
 =?utf-8?B?S0UyV0pWWGlsL2cwZ216LytzTmtOQ3JoTGhVQWFlZG44V1lEVDM1L3I0V2w5?=
 =?utf-8?B?d1FSS2Y0S0Fsb2tGM2d3RlN1ZUdwenFIN0tLeHZoSld5WDVPZUU2RFBrcnh6?=
 =?utf-8?B?WkVDamJ2anU4QWRJYURuUzl0cEYrQTVGMVlyeC9hSmxFUGNsRVRML1VnSnU1?=
 =?utf-8?B?L25hcEF1OHJndk5vZUdGTHdEMEZzVzJzb2VPTDJEV3hXdmkvVFppUkkra29k?=
 =?utf-8?B?MUFkM2NiNkJJVzVXc3VjYktRWktTOUhzK201TWIxOUFpL2w5VTlqRlVrYXFp?=
 =?utf-8?B?KzQrTVlOOVlHcnlwS2tDcW13dDhSNFpVbVdCc1NIa1FkajVwRjZlNGovdVha?=
 =?utf-8?B?eEpQUEJybDhjM1dEd0JaNVBLMXVwK3VhTytNQ3QrVTRFelZ6WDQ5ckMxMjJ4?=
 =?utf-8?B?UXRsd3ZFWGhucE1DdTREc1d5RHFMelZ4N0NOYnBGQlBBNi9PM3l1dDJqMlRv?=
 =?utf-8?B?dG9MTmRrZXlTQXEwOTViVlF2T1p0UnRDbUZXcndMQVZVeXdHV2piVW5oeElh?=
 =?utf-8?B?WXQ4eHRHQTl2dURvdC9RQlpPWXVxVHdTalY5SE5UK05hR1pwQWpPSUpmMVpr?=
 =?utf-8?B?U2Rra3RvckNHWUd2ZUVDNnVXZGVYdmFsb0xENU9FSHZLL1crOTFqNTBndGJj?=
 =?utf-8?B?WTlHcGJZK0dpSE9xWFQ3bHFSWG1DNE1PU0pUY2J6MStmUjZwSVc5RWZDQTFU?=
 =?utf-8?B?cHZSUFRESnczelVjUXRXN1dFdmo3SlVYNXU2QXgzenR0bWlMSTFZVGkvV1BR?=
 =?utf-8?B?djRTQjZLODF0VDdkazFXVmhyTlR2YTlhZmNIRThxQjdyYW0yekpBcm1zdE83?=
 =?utf-8?B?TWFrT2w5eFNqQUMySjg5Nkw2d0Y4Y3JmNTF0TkxnK3NqcGdmeUtmQWJMYjI4?=
 =?utf-8?B?NkliWWtlTWpNOVJZZFZCWkc4NUxxc0REdmxBSkZLRWJpazA4OGRGTUNMR1dy?=
 =?utf-8?B?cjhkQnRFaFdTZGJlb3V5OFEyeVczTXhjT1NvRFNUOC9kMEd2blZwNml0aldr?=
 =?utf-8?B?bFpaQ25HOGlUN3VUNDYvNExJOXdlZnBCRTVuYjJ0RkgxNFA4MTZGd1F2TjVS?=
 =?utf-8?B?T1k2dXhYem1xTGRNdThILzE4dE9NWEwwWUJRTTdrQ2NzNmI5VE5sN2lMZldB?=
 =?utf-8?B?VTF3ZktyTjVMbXZTQUZFZS9hMDluM2M0UTRjVGNYUFI4MmhXT3hlVkRzbWJF?=
 =?utf-8?B?amlTc09vdkc5TDl2UmhPYlR2L0JhUnh1U1JWNWZ0WWU5VXRENHFYc0xTQmVI?=
 =?utf-8?B?VlF2dUZ5Q25XT1hEL1JPRmdFYlFlT1hEUUptOVlrYi9QS1A5TWZ2cGxiWkNT?=
 =?utf-8?B?MzRwbFpVak8wQkxOMHlyaTdnaWtFaFQ5KzN4NnVFV2d2SE5nbDRLSis4eXVr?=
 =?utf-8?B?SEJ2L3luUUJ1YlkzaXR0d3gzOFFia1BxTVkxbDJlZXc5SGhnN2xLRFAwT2tl?=
 =?utf-8?B?YjBvdVhsL1NzbmhBRmxsQ1FPOXNYSS9DajYya2FxUlJPNlNkSjE4YWZLckpn?=
 =?utf-8?B?RW5VTDg2dE5tbnRtTEtzNWlSNHdJb20vTFN2UGxoUTh2dXYyN2h0R0UzUVB2?=
 =?utf-8?B?N24wMGNQSVo3ZTRmQ1d6Qk5XRnBkS3Jnd2djblE2K1YzaDBibjVBZ3cyL2ZG?=
 =?utf-8?B?MEFhd09zY2NuRDUwbXBPMk96a1ZXLzlKTmNSak5jSy9mS2FZVkwvUXpIVmxP?=
 =?utf-8?Q?otqs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae8650d-fcdb-4e35-3ccf-08dbd0e00de5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 20:14:52.9092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5g9sPJ6sHbE44wH/qh9TQRJqh04ERFwfT0rWJfk4p1jVFwYkdoeIrkXtfhIT5jV2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860
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
Cc: Philip.Yang@amd.com, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/19/2023 2:40 PM, Philip Yang wrote:
>
>
> On 2023-10-19 12:20, Chen, Xiaogang wrote:
>>
>> On 10/19/2023 11:08 AM, Philip Yang wrote:
>>>
>>>
>>> On 2023-10-19 10:24, Xiaogang.Chen wrote:
>>>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>>>
>>>> After partial migration to recover GPU page fault this patch does 
>>>> GPU vm
>>>> space mapping for same page range that got migrated instead of 
>>>> mapping all
>>>> pages of svm range in which the page fault happened.
>>>>
>>>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 33 
>>>> +++++++++++++++++++++-------
>>>>   1 file changed, 25 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 54af7a2b29f8..81dbcc8a4ccc 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -1619,6 +1619,7 @@ static void *kfd_svm_page_owner(struct 
>>>> kfd_process *p, int32_t gpuidx)
>>>>    * 5. Release page table (and SVM BO) reservation
>>>>    */
>>>>   static int svm_range_validate_and_map(struct mm_struct *mm,
>>>> +                      unsigned long map_start, unsigned long 
>>>> map_last,
>>>>                         struct svm_range *prange, int32_t gpuidx,
>>>>                         bool intr, bool wait, bool flush_tlb)
>>>>   {
>>>> @@ -1630,6 +1631,12 @@ static int svm_range_validate_and_map(struct 
>>>> mm_struct *mm,
>>>>       int32_t idx;
>>>>       int r = 0;
>>>>   +    if (map_start < prange->start || map_last > prange->last) {
>>> This is not needed, as this case should never happen, and you also 
>>> use max/min to limit map_start, map_last below.
>> This was just a sanity check, I can remove it.
>>>> +        pr_debug("range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
>>>> +                 map_start, map_last, prange->start, prange->last);
>>>> +        return -EFAULT;
>>>> +    }
>>>> +
>>>>       ctx = kzalloc(sizeof(struct svm_validate_context), GFP_KERNEL);
>>>>       if (!ctx)
>>>>           return -ENOMEM;
>>>> @@ -1747,9 +1754,16 @@ static int svm_range_validate_and_map(struct 
>>>> mm_struct *mm,
>>>>               r = -EAGAIN;
>>>>           }
>>>>   -        if (!r)
>>>> -            r = svm_range_map_to_gpus(prange, offset, npages, 
>>>> readonly,
>>>> -                          ctx->bitmap, wait, flush_tlb);
>>>> +        if (!r) {
>>>> +            map_start = max(map_start, prange->start + offset);
>>>> +            map_last = min(map_last, prange->start + offset + 
>>>> npages);
>>>
>>> This should move forward to outside the for loop, otherwise 
>>> amdgpu_hmm_range_get_pages and svm_range_dma_map still work on the 
>>> entire prange, and then prange->vram_pages update logic should be 
>>> changed accordingly.
>>>
>> We need use hmm function to get all vram page number on whole range 
>> as we did not know how many vram pages after partial migration, then 
>> we know if can release vram bo.
>
> ok,migrate to vram and migrate to ram have the vram pages updated 
> already, the is needed for the splite prange. We could update 
> prange->vram_pages when splitting prange, this can be done in another 
> patch.
>
> map_last is inclusive,
>
> +            map_last = min(map_last, prange->start + offset + npages 
> - 1);
>
ok, will update it.

Regards

Xiaogang

> Regards,
>
> Philip
>
>>
>> Regards
>>
>> Xiaogang
>>
>>> Regards,
>>>
>>> Philip
>>>
>>>> +            if (map_start <= map_last) {
>>>> +                offset = map_start - prange->start;
>>>> +                npages = map_last - map_start + 1;
>>>> +                r = svm_range_map_to_gpus(prange, offset, npages, 
>>>> readonly,
>>>> +                              ctx->bitmap, wait, flush_tlb);
>>>> +            }
>>>> +        }
>>>>             if (!r && next == end)
>>>>               prange->mapped_to_gpu = true;
>>>> @@ -1855,8 +1869,8 @@ static void svm_range_restore_work(struct 
>>>> work_struct *work)
>>>>            */
>>>>           mutex_lock(&prange->migrate_mutex);
>>>>   -        r = svm_range_validate_and_map(mm, prange, 
>>>> MAX_GPU_INSTANCE,
>>>> -                           false, true, false);
>>>> +        r = svm_range_validate_and_map(mm, prange->start, 
>>>> prange->last, prange,
>>>> +                           MAX_GPU_INSTANCE, false, true, false);
>>>>           if (r)
>>>>               pr_debug("failed %d to map 0x%lx to gpus\n", r,
>>>>                    prange->start);
>>>> @@ -3069,6 +3083,8 @@ svm_range_restore_pages(struct amdgpu_device 
>>>> *adev, unsigned int pasid,
>>>>       kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>>>>                          write_fault, timestamp);
>>>>   +    start = prange->start;
>>>> +    last = prange->last;
>>>>       if (prange->actual_loc != 0 || best_loc != 0) {
>>>>           migration = true;
>>>>           /* Align migration range start and size to granularity 
>>>> size */
>>>> @@ -3102,10 +3118,11 @@ svm_range_restore_pages(struct 
>>>> amdgpu_device *adev, unsigned int pasid,
>>>>           }
>>>>       }
>>>>   -    r = svm_range_validate_and_map(mm, prange, gpuidx, false, 
>>>> false, false);
>>>> +    r = svm_range_validate_and_map(mm, start, last, prange, 
>>>> gpuidx, false,
>>>> +                       false, false);
>>>>       if (r)
>>>>           pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to 
>>>> gpus\n",
>>>> -             r, svms, prange->start, prange->last);
>>>> +             r, svms, start, last);
>>>>         kfd_smi_event_page_fault_end(node, p->lead_thread->pid, addr,
>>>>                        migration);
>>>> @@ -3650,7 +3667,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>>> struct mm_struct *mm,
>>>>             flush_tlb = !migrated && update_mapping && 
>>>> prange->mapped_to_gpu;
>>>>   -        r = svm_range_validate_and_map(mm, prange, 
>>>> MAX_GPU_INSTANCE,
>>>> +        r = svm_range_validate_and_map(mm, prange->start, 
>>>> prange->last, prange, MAX_GPU_INSTANCE,
>>>>                              true, true, flush_tlb);
>>>>           if (r)
>>>>               pr_debug("failed %d to map svm range\n", r);
