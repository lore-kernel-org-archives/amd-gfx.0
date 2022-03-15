Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52248C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 15:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D293B10E45E;
	Tue, 15 Mar 2022 15:21:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D1E710E45E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 15:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc6ga6MLsxnaUf8poCPrHIorFMpaRbU0ZUVPRJ/aZr7ODYxqPS2fyxneAvwj1CrRhE1YrY/4hwL1qIt7CulKyeIGe5vo4fVTD48EtMpOeUhc/vroS+0cijMn4WF/qkc0DypPvrJGUn0KaDEnyxgqImwH5Vaog4ukFG/Cri/ndC0RAA14LNL1EZelYLHb3oAMnHSPhjRZJxsEpchpTXF+zGttvNrtdLo1P9+KXERwyxVQWBt096RSC3JByPfDegNsTsaOnZB/zFWdxJ8HAg0vRpp88R6EZAPjg6Cmf+pjGKwVZo89tU6kd5XhvJ98r6E06xGpYZk2R43RQD3fhR3+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buWOERSls4jfmYHT21uyOdN85qKdkgI9OrbvW6TWJ1M=;
 b=KLv0Fp0J3rxRUyB6mKSt4wawO5wQHX+zRkVtxZR6n5EMN2ko2mfeuudq5RzavfSsBHJpl+OeN4A80CViz6TpYTeXfViUreuqbfdA6qnLwKZmHcaSD+hBcJ/9Xi+DKMmQGp/6XCkIXJBrAUI7+bEw3L1m8IkYUmc3DrO0r0WdkL9Jhxtx9VY9wW8xP0gMHGSWAZ9sAY+nCdAOUkRec0b5r4qB3ickpDkBkIe2l2h0HbNxMuKyRgaL/g9YYrwFx7bjUHSeQ3Gd9ckA21WXDhYp12gBbPjGy4aXuM7zddcrLMn/uvqIDDZ83w4+sFoqd6n76KzAKcJUTMs5A+Akv4hMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buWOERSls4jfmYHT21uyOdN85qKdkgI9OrbvW6TWJ1M=;
 b=csvBXCXvgasQZ5XXRfBPk4SWR+3MPwW3eyNzYVWJbyVKxEZerH2SQ0yR70LfX+QNkBfcWYKn0zeWbCAJcBX2HGoJkIUGmwtzCs3Ml9YcR06KDmZVy/kqHvQs4Iu1RdNrnYoziqSklv90JTv8DE84RFL9RClckuXqs/8bJZ8z2EE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR1201MB0266.namprd12.prod.outlook.com (2603:10b6:4:57::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 15:21:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 15:21:02 +0000
Message-ID: <ffca8e20-60ae-2ed0-a22d-5b5e88e31bc8@amd.com>
Date: Tue, 15 Mar 2022 11:21:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] drm/amdkfd: evict svm bo worker handle error
Content-Language: en-US
To: philip yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220314145020.9142-1-Philip.Yang@amd.com>
 <486b326f-8842-5de4-07ad-7ab1f209132e@amd.com>
 <919baf93-e7b2-166f-02a0-e341bcb4d214@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <919baf93-e7b2-166f-02a0-e341bcb4d214@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2da057e-ef64-487d-ac0b-08da06976a37
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0266:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0266AF6BA611636A971502BE92109@DM5PR1201MB0266.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gxeU1XAr6dt/NZajfzxJS7VP7Od8bgwQn+qrxaiuF99+FEEnX2dYTkTCBn4hANKMD0DwTrdgukDsASpzHtRf6ptvwsWSNdal8LCk4ErvHS1xfBJRQ1U0R3aXt0XBlvgu20yW4BYUq+vPBSbj5xi9LmhNx1zdlzwIQ6gqi0Qv2oRZr+Xj6csy/eb/yafYXnyX2yYB1DuTu4rasUTZbl7zIp24d8b0GMT35RqO5cx7lKtIfpsNtGx41X80n+tCkXdO3CeIG+a9NmS3MM04K6PO9noluhI37aikVJpwcfolnJgIErfWYdSFUw4WoWbqkh8blydM59p3QwT+i6N0nmV2ZQe3+GoESmex6RFW+y0GL2NF2S1kEzqQrvq6/Yiq/D/0MCZFIIdqnjw8xY0nYeLavcaBQ607jNp8eDHd3KhZqon9rpFZJgiDbtaDmide3AfzAFKZGbH97R7pIRv6gfPbQBWMM7oiOStEHEwzBvvsDkcJShBqUWm2V4u63QdxNEnC2wP5Q/HcVCJ4nNkHzK1JSZ4PYoqVLSChPEQ6fAldc8IpdCjZ7B26ASKNION1HAHIATPyon8BGWNHDB8A/wfk17etUzD/OZ1hqY8NB0OdvOVqlWH0A/iYL1CRBNs99bgk/16EH3OM8BEKzrKMHF2WzECpBM+ZBRoC0o5frj3ndYqVzHZ4dZoObOu+1zXEopFluGAzIV01DUfG/GLK5OYeI2iT8BsKvdFh1SEro8qW1RowGIec/H4h3qdnCDcicjd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(6512007)(316002)(53546011)(4326008)(508600001)(6506007)(38100700002)(8676002)(6486002)(31696002)(66476007)(66556008)(66946007)(86362001)(31686004)(5660300002)(36756003)(44832011)(8936002)(26005)(83380400001)(2616005)(186003)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFVoSkwxY0JIUk5vc3VqRmUyY1BUbWpqVmlZTGkrMXVxcklCS2oyMzNaSGpK?=
 =?utf-8?B?RkVCeHh2N0FGSEI4OXhnNnhqREExQ3pWRkQxY0RicUpMVFdVSWl2WkZXNnV5?=
 =?utf-8?B?eFF6TFhPWmlOMitvd3NKeW1nUnIrbUxCZk1XMU95aWRYSjh3bkkydFhoZUxr?=
 =?utf-8?B?bkhndWlQVk9SMkJ6TXE5MjhQVUdEbmRIT1N1UVZoVHZ1NjlZQWREK2FCVHR5?=
 =?utf-8?B?MUp2aEZValpvU2sxZjZOVjNoenZCemdpM1NBL29IdUFkcWxNMFRoSFRJdm9F?=
 =?utf-8?B?S2VMNE9LNEVrVWc3aGxSdmNsWjVNYy9ob21lTkZ0VEtQTzlRbGdHSUhmbnRh?=
 =?utf-8?B?M1JKL0lYdlU3QjVnL20xeCtoZU5saS9GSmo3STQ1ZDAyUS9JeEFuT1FRWTZ5?=
 =?utf-8?B?VHFhbWlreWtBZnNnQW83d3hxSWxQMUtxNWN2UlBQQ3NpTDhyRTl5cGRRTHdt?=
 =?utf-8?B?aHlpbEwwazNtbXUvOHpKK3JFZzFWTGg5RWlCczd2d3d2ZjlmbzlxS1ZSR1Fj?=
 =?utf-8?B?WjcwWXE0L2YvaVpYamhNdDc1NG1PdzVNMm9lTWF0eVFJTU56NXR4cjhEYkpn?=
 =?utf-8?B?anhrWmdiVnZaR01tZjRwN1MwYmNhSkY0czZTeEUvVm1ZbEtaSUZ3d2tlMXNL?=
 =?utf-8?B?KzEvN0VtWEY5MXN5bkpQTmd6MHBGblJHeDBacXRIZklOMEhTVzFsUzRmanZZ?=
 =?utf-8?B?MjdPTGp2YU1YZktDZDlLVnFMdVpJVnMzYVNrRkl4VzJscHhKZnFHN05CcndV?=
 =?utf-8?B?MUhKeXJ5Uzd3K0ZOK3hGNTl1RDFoZG5sZ3F6Q2xnekRJN2pQblYrRkljQkd5?=
 =?utf-8?B?LzI2cjRzQk84czN2QTdDdXVoZTJ5aVJ6Z3VYUjk5RzZvNFhjWnJSREF3QlRk?=
 =?utf-8?B?Q2MvcXRZbStPMmY4SHJiWHYwaXdGekpCRVNoOWROSVJBQnN0R0VTSDBtY3FL?=
 =?utf-8?B?dThySGZzNnQzT25hM3IwNUh3NDZyK0pON1Y2SVFpT0RqVHg0eFA1aVBiM0Qv?=
 =?utf-8?B?NjU4OFlhYmNJS2RlYzlmMGpKc2tGSTFUbnlicFQvZVh6OG82T3lVaFFtTE96?=
 =?utf-8?B?UnJsYlp2dGlEMXJUNlhvaHJ3ZUdpK2d6Vm83K3Z0UFFiRlRWVURiS2VyNlFx?=
 =?utf-8?B?MUlhVDdmREVFVU40OTQwUjh3RHE4QXNFaE43cThHcm94Y2FJYUhnVXFodWM1?=
 =?utf-8?B?bHBrZVpiQ2QxR1J6L2hLWlZrOVVyakFucFk3K2xiQUp5cExnTWdSNzJTSURW?=
 =?utf-8?B?UkIyRC9WVzFHSDBJQWQ5TmRmOGNxTjM2NEFWSy9Ra0l1NE9YdG1IZW1zYXRx?=
 =?utf-8?B?WFQycjZ0Tlg0eDZGMmFqNU5QbTcwZytucmVoRDRyM2FTcVBVcGxnRmV5K3da?=
 =?utf-8?B?NWJVVXoxeE1EYkdVTjlBaHZybEtoOHlRSm1UVmRhZDV5Z0FoM0tXTHBMdzJq?=
 =?utf-8?B?VmFSd3BxMkNXT1pQMlZsQ012UHpxU3ovSlVWdWV5YmpyUlZIamdzcHkwZ0tV?=
 =?utf-8?B?alNYT3U0UmlGMXk1aGs5WFZQQm5JMVplajM1TjhKS3BvREo5dHdQVDFPRDJq?=
 =?utf-8?B?eHVLbU5QWEJjMndsQVFxd3gyMTZjOCtWTk5GVjVCZGJ6UHcxNkpmd2dLcXBq?=
 =?utf-8?B?b3ZYMHJMVUpFa2RtQ0Y3MFlxWnptMnk3b0FBb2wxQk5FVDdOeHcyalVFQ0Nq?=
 =?utf-8?B?bzdjUDk0cXlTNHJpa1VHY2ZwcDdmKzJWQ25FaVp3YjJnT2g1QTFNcEc1Mklw?=
 =?utf-8?B?YW53cjV3UUlXMjJrMEduV3lVVE1KUk9FeUpKMzlCV2lubHo4MWJrT0daUUdv?=
 =?utf-8?B?VmN1Qlp5T2thdTFZTGVUYzJJc2VJZzF4S1ZOVVp2dGZWc0pyaFNnYmgrUlM5?=
 =?utf-8?B?SjhUc2Y3SGR5R0NwY3MxSktEYnhYSXNFRlEwNGNQTlEvaVpUaDlieVI2NDdC?=
 =?utf-8?Q?/dJM5UDXAKml4G8ZjURzOtgfVNZ32Qls?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2da057e-ef64-487d-ac0b-08da06976a37
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 15:21:01.9301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0o80gRssiodET/2JjW3h7sty/xDgies27CeKyiJF5xyAyzlx9KCUfoJ5YXv2rwuA3Yp30uV395D+I7abLY/eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0266
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
Cc: alex.sierra@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-03-15 um 10:44 schrieb philip yang:
>
>
> On 2022-03-14 3:58 p.m., Felix Kuehling wrote:
>> Am 2022-03-14 um 10:50 schrieb Philip Yang:
>>> Migrate vram to ram may fail to find the vma if process is exiting
>>> and vma is removed, evict svm bo worker sets prange->svm_bo to NULL
>>> and warn svm_bo ref count != 1 only if migrating vram to ram
>>> successfully.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 27 
>>> +++++++++++++++++++-----
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 20 ++++++++++--------
>>>   2 files changed, 33 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> index 7f689094be5a..c8aef2fe459b 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> @@ -638,6 +638,22 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>>> *adev, struct svm_range *prange,
>>>       return r;
>>>   }
>>>   +/**
>>> + * svm_migrate_vma_to_ram - migrate range inside one vma from 
>>> device to system
>>> + *
>>> + * @adev: amdgpu device to migrate from
>>> + * @prange: svm range structure
>>> + * @vma: vm_area_struct that range [start, end] belongs to
>>> + * @start: range start virtual address in pages
>>> + * @end: range end virtual address in pages
>>> + *
>>> + * Context: Process context, caller hold mmap read lock, svms lock, 
>>> prange lock
>>> + *
>>> + * Return:
>>> + *   0 - success with all pages migrated
>>> + *   negative values - indicate error
>>> + *   positive values - partial migration, number of pages not migrated
>>> + */
>>>   static long
>>>   svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct 
>>> svm_range *prange,
>>>                  struct vm_area_struct *vma, uint64_t start, 
>>> uint64_t end)
>>> @@ -709,8 +725,6 @@ svm_migrate_vma_to_ram(struct amdgpu_device 
>>> *adev, struct svm_range *prange,
>>>           pdd = svm_range_get_pdd_by_adev(prange, adev);
>>>           if (pdd)
>>>               WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
>>> -
>>> -        return upages;
>>>       }
>>>       return r ? r : upages;
>>>   }
>>> @@ -759,13 +773,16 @@ int svm_migrate_vram_to_ram(struct svm_range 
>>> *prange, struct mm_struct *mm)
>>>           unsigned long next;
>>>             vma = find_vma(mm, addr);
>>> -        if (!vma || addr < vma->vm_start)
>>> +        if (!vma || addr < vma->vm_start) {
>>> +            pr_debug("failed to find vma for prange %p\n", prange);
>>> +            r = -EFAULT;
>>>               break;
>>> +        }
>>>             next = min(vma->vm_end, end);
>>>           r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
>>>           if (r < 0) {
>>> -            pr_debug("failed %ld to migrate\n", r);
>>> +            pr_debug("failed %ld to migrate prange %p\n", r, prange);
>>>               break;
>>>           } else {
>>>               upages += r;
>>> @@ -773,7 +790,7 @@ int svm_migrate_vram_to_ram(struct svm_range 
>>> *prange, struct mm_struct *mm)
>>>           addr = next;
>>>       }
>>>   -    if (!upages) {
>>> +    if (r >= 0 && !upages) {
>>>           svm_range_vram_node_free(prange);
>>>           prange->actual_loc = 0;
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 509d915cbe69..215943424c06 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -3155,6 +3155,7 @@ static void 
>>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>>       struct svm_range_bo *svm_bo;
>>>       struct kfd_process *p;
>>>       struct mm_struct *mm;
>>> +    int r = 0;
>>>         svm_bo = container_of(work, struct svm_range_bo, 
>>> eviction_work);
>>>       if (!svm_bo_ref_unless_zero(svm_bo))
>>> @@ -3170,7 +3171,7 @@ static void 
>>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>>         mmap_read_lock(mm);
>>>       spin_lock(&svm_bo->list_lock);
>>> -    while (!list_empty(&svm_bo->range_list)) {
>>> +    while (!list_empty(&svm_bo->range_list) && !r) {
>>>           struct svm_range *prange =
>>>                   list_first_entry(&svm_bo->range_list,
>>>                           struct svm_range, svm_bo_list);
>>> @@ -3184,15 +3185,15 @@ static void 
>>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>>             mutex_lock(&prange->migrate_mutex);
>>>           do {
>>> -            svm_migrate_vram_to_ram(prange,
>>> +            r = svm_migrate_vram_to_ram(prange,
>>>                           svm_bo->eviction_fence->mm);
>>> -        } while (prange->actual_loc && --retries);
>>> -        WARN(prange->actual_loc, "Migration failed during eviction");
>>> -
>>> -        mutex_lock(&prange->lock);
>>> -        prange->svm_bo = NULL;
>>> -        mutex_unlock(&prange->lock);
>>> +        } while (!r && prange->actual_loc && --retries);
>>
>> I think it would still be good to have a WARN here for other cases 
>> than process termination. Is there a way to distinguish the process 
>> termination case from the error code? Maybe we could even avoid the 
>> retry in this case.
>>
> It was bug that prange->actual_loc set to 0 even if vma not found, 
> that's why this WARN never trigger. With this fix, the WARN is kind of 
> duplicate with below WARN_ONCE. Change this to pr_info_once to help 
> debug, as below WARN_ONCE is real critical issue to notify TTM to 
> alloc VRAM from BO while svm_bo ref count is not 1.
>
OK, makes sense.


> retry is avoided if r return error code.
>
Right, I didn't read it carefully. I think my concern is, that the 
WARN_ONCE is only printed, if the migration failure occurs with r==0. If 
it fails for any other reason, we no longer warn about it. This is kind 
of intentional, because you don't want to print the warning in the 
process termination case, where the error is expected. I'm just a little 
worried that there may be other error conditions that can cause a 
migration failure with r!=0, where we're now failing silently.

Regards,
   Felix


> Regards,
>
> Philip
>
>> Other than that, this patch is a good improvement on the error handling.
>>
>> Regards,
>>   Felix
>>
>>
>>>   +        if (!prange->actual_loc) {
>>> +            mutex_lock(&prange->lock);
>>> +            prange->svm_bo = NULL;
>>> +            mutex_unlock(&prange->lock);
>>> +        }
>>>           mutex_unlock(&prange->migrate_mutex);
>>>             spin_lock(&svm_bo->list_lock);
>>> @@ -3201,10 +3202,11 @@ static void 
>>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>>       mmap_read_unlock(mm);
>>> dma_fence_signal(&svm_bo->eviction_fence->base);
>>> +
>>>       /* This is the last reference to svm_bo, after 
>>> svm_range_vram_node_free
>>>        * has been called in svm_migrate_vram_to_ram
>>>        */
>>> -    WARN_ONCE(kref_read(&svm_bo->kref) != 1, "This was not the last 
>>> reference\n");
>>> +    WARN_ONCE(!r && kref_read(&svm_bo->kref) != 1, "This was not 
>>> the last reference\n");
>>>       svm_range_bo_unref(svm_bo);
>>>   }
