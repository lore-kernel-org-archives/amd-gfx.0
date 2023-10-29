Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D97C4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Oct 2023 18:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B6C10E17C;
	Sun, 29 Oct 2023 18:40:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A5E10E17C
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Oct 2023 18:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWc5AGSs1R3G3iE4LnXNl/ne61x4uYe0PL5jZ4MaP0C1IKSxvPq5Spbu/Mj7oc2+YKUqjkRw4lHEkAhJuCaLUAz5C9Zj5KCIfv0vvJhQvIw8p7hw7U1NmraYllr93bPicmvdhTIsvQS2ut9crMu+H08u/XkbHgUiN0xLGbQ+bpBfusrUuIcGfDrNgX4kj1GbReiXznkOdNjU3bpzAFqTZSKFJcwZrz9SEQCbihnHPULUVY6JCYAZHNudupR4FqBG9rB9W1leBcs2pZz+Lsr84jTRzGFTZxO1LOMELZdxljfBGpjL4eEj/gEuFewaB2tC1gPnTcLOgOI/22ytzO7aFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0hb0pNAXr6J8LHDRl//0u50/kU7HLjQltZE7xeE3Y4=;
 b=YQcJDwWX4shfy5+zYLHw6laXwrLkNBvNJhaIZiQsvmsWAdKeJAhA+g0puRVwG8NmkOV3g7yxm0uEpDl/QPNunoRSlTRUADWws8wsgi0wzCzCh7QOpSlNDqB/vvunXt14oowkeuRFoKyBIGaukxtASPTC3Pgwu+2zpupxUrqQHzCLlWmTe0VKMzDkX01ZTTpdDcfBkqxCRmCelQF5eQko9lG7Nmba2m1OJqLTv04rhNPv1G4N/VZQ01gcI5swYmoWGrR1h9y16DxAXARtaNHosYPypupMUZGjtf0hCqjLiSmnjG7U1cmKYyEOz4eo24Oh0vfi6JmN32Urok9DBlBxOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0hb0pNAXr6J8LHDRl//0u50/kU7HLjQltZE7xeE3Y4=;
 b=YRsV61/NtlSZf+nOtB4SdlKDk453T+I/Scpo+jiS/xdcqP74m/cjpKSqdGJk70omzJwuOBRgPhUTgxahaALlbrAEmRdrbs8nhMiGUeRfRP/mDcBBy47HuTa1bH4Z5DVxP0YMw0pM0K9KAeQgZFV9jqWjY8n3Y6rfjHIWf2dCLcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Sun, 29 Oct
 2023 18:40:01 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::9578:681f:c050:51b9]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::9578:681f:c050:51b9%4]) with mapi id 15.20.6933.019; Sun, 29 Oct 2023
 18:40:00 +0000
Message-ID: <dbcaae2c-bc47-2137-ba43-2b471875630d@amd.com>
Date: Sun, 29 Oct 2023 13:39:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] drm/amdkfd: Use partial mapping in GPU page faults
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231020215316.247816-1-xiaogang.chen@amd.com>
 <f655fcea-e709-4ec9-8edd-298c5c122b70@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <f655fcea-e709-4ec9-8edd-298c5c122b70@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::22) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4677c1-e935-4958-82d4-08dbd8ae750f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnqc7Rcq0s1bEuGbN5yW8ogUjskgCKCP50rV13mLq0nPCTaO6DXgzmI6BgebPivcyTUwQDPSD4sjR0l4pLv01nkPcI5w3iubT6rJnajf9ieNbdunIXUnYcFEikOAUwlNXp5FjlWBLvmlKrA3Io7Dx67wAPe2VdqJ28HecSsZq/rRGA6Yz1GPNZU8MTz9xo7tc24SNT31+kVIhs2NivrUWsouXi65CLqtjAyoXnnANUq0b+3bK+H9ghr6ka6h5qjCD/fLcpJ9e9mg3xs72JKl1/Nz/CuUCthjFXQZx8LoimdVcGAZ1RIdVMnQOShIerdOwPt9/TJdmLQn19zyb5qT8kDgrYteKZUKxP6O3BxuQN+dsUHzWURGWmVxrS4ViIjEN9tRxcogOL6i3rOcah3uJysdBFL9N15Onktha8TpZeoEY1VMSLY1mrdZ3hhGtgZCRaUwCOC0V5A8fZh/C50hG/NOlohUffhDWIt9qHpqQXEa5En7sd5ubCQHsmoeu6E9Lyil3mP9q2NU/kU0dhDuCHnZFh9SDynzhAXxikZnxyZKWYd6XsLFwj6c/dP1ebaMMKewRZcZ6WhPEEMvSzWZW597fKS09CFup/6CP7l7sJCQ8YRGH8wno/APxCur0399eGc/62bSfixK2dpXbvlqMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(38100700002)(2906002)(31696002)(83380400001)(4001150100001)(5660300002)(2616005)(86362001)(6512007)(41300700001)(66476007)(36756003)(66556008)(66946007)(53546011)(6666004)(6506007)(316002)(4326008)(26005)(8676002)(6486002)(478600001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXQ3SmxzcmJ1Y1Y1eGNFRmVremZmOWVuZnJoUzhic0RqVTI2VWxqY2hrSDBQ?=
 =?utf-8?B?NmMrcktwWlJKZ3Nud05MaExkVmo4VGxpU01RVG43dUJzRGwrNGd4ZjJLNnY5?=
 =?utf-8?B?MDZBREwyMjdqdVVic1UwaG5QTjRGY1MvMjRDRlBycTgwdFhJcHpRK3ZBR2Nh?=
 =?utf-8?B?K21ER2ppRUxrcFltRDYwTUowMElsc3JkMy81N05kbHcxWDRxalNwaWpmcVEx?=
 =?utf-8?B?TFJiYUZBRm5WT1ZVaW9xdXdUaWd4MTFyeWNMOGRqWXd1elcwSEVYb2E0eFV4?=
 =?utf-8?B?S0s2WndwOFlvaU51cUNOSE5qK0F4MVliQ0F3TGRPbjZLdjZTdnlQZURlYWh5?=
 =?utf-8?B?QXVUNlR4NEsvN2ErcmRkWTdMNVd2a3Vxb1VoR1g3dWNLU1BML0NxOW55eTFt?=
 =?utf-8?B?R2c0YVNGcGhDRXNaaDdvdW9rbG4wUjJacUsyUDRmMmRRby95b0N0cG1xR0Y5?=
 =?utf-8?B?QWM5T2plWTAybmdaODJVNG43SmJRUXlIem9KVitiazJIRmovRHdGeXJORGJh?=
 =?utf-8?B?VVQ1UnBza3pXZnE3dDd3RmFWVWVOT1VvSDVrdlUyLzVzdVo4cjZ4UVpiWmJL?=
 =?utf-8?B?R1ZPQXJOdTFsUmp4dVF6ckZSREN1b0NKejJRb01LalhWN2dOdDhmUXZLeGwy?=
 =?utf-8?B?amMxdXhzWWpHc212Nk4xekpaYmFKMTA2c3BCZUU0TXI3Zk1PWDdYYW1VTEd4?=
 =?utf-8?B?UmFubzdqVStrRldZeWtGTkVhay94MlVPcW9BM3VTZFkvOFlDbDhBUXNyeE1G?=
 =?utf-8?B?K29QSlNGM2hmVG5Zd2pKWnc0ZGc3TzA3OWwvRGhyVUhvZ2NMUU52WkxvNXE1?=
 =?utf-8?B?S0xjT0NCQlVrNU8vWFIycUh2NFVLemVvbGJnYWIrcHh5RXVNREFmWW5LMlRk?=
 =?utf-8?B?WFlTaHJxa3VCRmJpcUlsRW9yU01kL29xYTJIUFBJVFZwUGt6Y2VZa0dDa0dF?=
 =?utf-8?B?RWtyRTZlVEJHU3Rkbno2bnd4Y095dHVZaDJNbS9xSE10ZExSaitPRzRhei9j?=
 =?utf-8?B?Z1J6SzVnd3d5SS9pd3ZidTRzRzFIT01YVFliRmp1TlNET3QxNVZkVHJmYmZl?=
 =?utf-8?B?QitwZFJHVFE0RzBmekRNdDcxMXJYdmRyMWUxcENHSDJaOTlFQmxZam1CSjUx?=
 =?utf-8?B?NlRtb0M2Q3plWXdacjRBaG5Bai9LZkl6d1JyQWlUdWIvbTFlWmw3T1FqbmpT?=
 =?utf-8?B?L3IyNjlnaDhZK1M4akxVSmRBV1g4T3B6dERIa0IrdGM0VkZ4SUNUeG9UZHQ0?=
 =?utf-8?B?ZkVIUXM4YkU2SlZrckFpSGs4M3lqcE0rSi96Zm1wVVc0YjdHRDIxR09wb25u?=
 =?utf-8?B?eDd5UURDaFd0cGJKdExLZFU1VHMybW9HdUVJMGFBVlEySjh4Qzhrb0ZpVWZl?=
 =?utf-8?B?U1N5ZnVBbzVDNE5TeStjUlN3dFh3eXpaY05SdklTMDhiS3VnSnVORVFIRER2?=
 =?utf-8?B?UGc4alN0SDZZUUhPS3EvSStWQlJKU01HRi9PMzJRK3RDeWpPNHJvVi9mTzZB?=
 =?utf-8?B?RThkbngyQ3pNR1J2SjU1OVNKL2lTdEpqcEljT0VJQ2c1Snp2NmtlYXRHWGlE?=
 =?utf-8?B?dzZ6bndpNVQ5NzNmbVc1K3plZzFSVzhKTUQ0RW5rM0RXREozcVdKd214Nzh1?=
 =?utf-8?B?ME1zOUlVbTdabm9Pa2MzSGxnWUIvZFBONGROamZYZjRXWm1TQlUvYkpWRE5C?=
 =?utf-8?B?ZWtlWm1IQzZEanpCR2JXTEgzNEhQenNNMXZqODB2ZVFSWkMrdVo2aUxjSzMz?=
 =?utf-8?B?VFZXZUI1dEZKWkxnVGNZVXNIMENXajJub3VHd1dWUFB2Qmo4NlFQMUdsLys3?=
 =?utf-8?B?eEZHRGovWkdlKzUyeTJnaFBxVUg3WEhJaG05UStoUSt4MGVpT0RHUVN4eU9O?=
 =?utf-8?B?eC9nTzFxVHZZTWhjblZSNVJsSDc1MkdTOVE2dmQ4ZGVySFQ0YUh5bGZhcUty?=
 =?utf-8?B?a2NiSUJHa0dHemQzbDd6Uk1XZ29OeTUvMWJpM1FUbkkwUm5QSjhERzlMTE56?=
 =?utf-8?B?SWpHMWtFWjFXZUlYbEg3ZXR5SGRaWkpkSGVqdklER3JpVmlmK2ZzQ2o5K1g3?=
 =?utf-8?B?SmlybU13ZGE1Tm9zTVpXSDhkc3U1TERVdVI5L3NudytaY2JUL2VlaUxIV2k4?=
 =?utf-8?Q?1SSs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4677c1-e935-4958-82d4-08dbd8ae750f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2023 18:40:00.4677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMRJ7TqkWi0XvQ//4J1m1BoXJIjl47EfyHXa5JU8cO44VaVybfwHviVb74Jdx9zu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983
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


On 10/23/2023 6:08 PM, Felix Kuehling wrote:
> On 2023-10-20 17:53, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> After partial migration to recover GPU page fault this patch does GPU vm
>> space mapping for same page range that got migrated intead of mapping 
>> all
>> pages of svm range in which the page fault happened.
>>
>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 29 ++++++++++++++++++++--------
>>   1 file changed, 21 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 54af7a2b29f8..3a71d04779b1 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1619,6 +1619,7 @@ static void *kfd_svm_page_owner(struct 
>> kfd_process *p, int32_t gpuidx)
>>    * 5. Release page table (and SVM BO) reservation
>>    */
>>   static int svm_range_validate_and_map(struct mm_struct *mm,
>> +                      unsigned long map_start, unsigned long map_last,
>>                         struct svm_range *prange, int32_t gpuidx,
>>                         bool intr, bool wait, bool flush_tlb)
>>   {
>> @@ -1699,6 +1700,8 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>       end = (prange->last + 1) << PAGE_SHIFT;
>>       for (addr = start; !r && addr < end; ) {
>>           struct hmm_range *hmm_range;
>> +        unsigned long map_start_vma;
>> +        unsigned long map_last_vma;
>>           struct vm_area_struct *vma;
>>           uint64_t vram_pages_vma;
>>           unsigned long next = 0;
>> @@ -1747,9 +1750,16 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>               r = -EAGAIN;
>>           }
>>   -        if (!r)
>> -            r = svm_range_map_to_gpus(prange, offset, npages, readonly,
>> -                          ctx->bitmap, wait, flush_tlb);
>> +        if (!r) {
>> +            map_start_vma = max(map_start, prange->start + offset);
>> +            map_last_vma = min(map_last, prange->start + offset + 
>> npages - 1);
>> +            if (map_start_vma <= map_last_vma) {
>> +                offset = map_start_vma - prange->start;
>> +                npages = map_last_vma - map_start_vma + 1;
>> +                r = svm_range_map_to_gpus(prange, offset, npages, 
>> readonly,
>> +                              ctx->bitmap, wait, flush_tlb);
>> +            }
>> +        }
>>             if (!r && next == end)
>>               prange->mapped_to_gpu = true;
>> @@ -1855,8 +1865,8 @@ static void svm_range_restore_work(struct 
>> work_struct *work)
>>            */
>>           mutex_lock(&prange->migrate_mutex);
>>   -        r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
>> -                           false, true, false);
>> +        r = svm_range_validate_and_map(mm, prange->start, 
>> prange->last, prange,
>> +                           MAX_GPU_INSTANCE, false, true, false);
>>           if (r)
>>               pr_debug("failed %d to map 0x%lx to gpus\n", r,
>>                    prange->start);
>> @@ -3069,6 +3079,8 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>       kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>>                          write_fault, timestamp);
>>   +    start = prange->start;
>> +    last = prange->last;
>
> This means, page faults that don't migrate will map the whole range. 
> Should we move the proper assignment of start and last out of the 
> condition below, so it applies equally to page faults that migrate and 
> those that don't?

This case means the buffer is at right place already, but not mapped to 
gpu vm due to some seasons. I thought that we do partial mapping too in 
this case. Since this patch was reverted I will do that next time.

Regards

Xiaogang

>
> Regards,
>   Felix
>
>
>>       if (prange->actual_loc != 0 || best_loc != 0) {
>>           migration = true;
>>           /* Align migration range start and size to granularity size */
>> @@ -3102,10 +3114,11 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>           }
>>       }
>>   -    r = svm_range_validate_and_map(mm, prange, gpuidx, false, 
>> false, false);
>> +    r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, 
>> false,
>> +                       false, false);
>>       if (r)
>>           pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
>> -             r, svms, prange->start, prange->last);
>> +             r, svms, start, last);
>>         kfd_smi_event_page_fault_end(node, p->lead_thread->pid, addr,
>>                        migration);
>> @@ -3650,7 +3663,7 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>             flush_tlb = !migrated && update_mapping && 
>> prange->mapped_to_gpu;
>>   -        r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
>> +        r = svm_range_validate_and_map(mm, prange->start, 
>> prange->last, prange, MAX_GPU_INSTANCE,
>>                              true, true, flush_tlb);
>>           if (r)
>>               pr_debug("failed %d to map svm range\n", r);
