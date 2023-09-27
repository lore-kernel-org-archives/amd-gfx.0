Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51999E82CBB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 18:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1FAF10E078;
	Wed, 27 Sep 2023 18:23:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1B410E078
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 18:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J355nPHHPxdoLjU/9bS6ipGVcR3XkbPII2ybpDLdR9Vdq573xIusZvO99HlTurSBUTIxs4kxluPo4oQXWG41C9Cr/jIG3cfMBl/IU2I3qDjKb1QjMaE+hv1982mwDJw/3SqkJapDmhGZrSOKIPo6dvEtgyAYHb6/6kY80dkzMkydvxB5i2NRFb8xJsvjJV9N+Lu6qth3ZKOzzmKkLU/H+fyYDOVRNEuH1dYf+XR51Ge65j7rwCyIAeq/vEILGCWA+IFq7ObHGbirfTgccHG9H5FqArVo0fI9qF2zLZLtVt9mkHIcQu+LJqG0Z99agRG1FIjCDLWcGDWswLQ46KdG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlytTk6c5GgFfDoexQpRufxxAnp315zOFnWuiq53Kbk=;
 b=G/7bZCA4RSZ97D4z3CEzXKuM/t8do1V6F/ZbHxOZDNVNtryXjyRhj0n4s3Vrbmw+GQThRc4pS2znAlq1i3Sv4kTofh8t7bXH0PA8h5ftZ/ZcB3BFtUBvyOnvXPjoUElniF688yUeQOco3RSnpLh4thi4f/BKBMgKrc722EUIHM7xqe9T6JnKaMlxcRZ9RStjbdYvqkWY8Kbvv9ViXzPdQn8wyGEVtNIV7UV6h/mJi2r7N9Jc2x9vnaslsUf2Xvgk/Ie+d253u6RSCUTwDhDZV0dpwPPYGtAQG3A3wXP8ULGNHiHri//IhrqCYURhi/bHSqG/OEP4qx3cOMx2ZXeUNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlytTk6c5GgFfDoexQpRufxxAnp315zOFnWuiq53Kbk=;
 b=xIQka/og4zd/HpFfLokVGtQUxZNKqArIJTKSih9oMbO0uoZty8K4CkPIUrO/r8BFrN7k8jBJhQT+nFwPovNW85CBALcNVIlCMU9HkFgNLwBLVNSejDFv4rw1UpJeVqEe5sMQabZLsZX2vwcqBgllzZH5F2r7kGmhRzM4qkGIznE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21; Wed, 27 Sep 2023 18:23:02 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 18:23:01 +0000
Message-ID: <18e51c37-08da-b076-8dd7-750e420de8b1@amd.com>
Date: Wed, 27 Sep 2023 13:22:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Wait vm update fence after retry fault
 recovered
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230922213759.20904-1-Philip.Yang@amd.com>
 <1d6af500-2a17-0f95-3c86-024cdded0fa9@amd.com>
 <4f696de5-3e2f-ceb9-bf09-43b4b1078cb0@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <4f696de5-3e2f-ceb9-bf09-43b4b1078cb0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0588.namprd03.prod.outlook.com
 (2603:10b6:408:10d::23) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b72329-3e3e-47e2-2c33-08dbbf86c8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wB5bkS1JZDKGmlO/xAANDKRnL0uUEPZk1Jiya5AXPDIKZGBd3L6vInqws78O9oLmhBx62oc/R6pwAmkTWUeMUgmQc4ZciE7wfzYSFmV3Jp8SVAUwGyY6vJPPlprTBlXC8HIvbf6LBYJ4pd4RXb9vy2UUpAt7tcy6O/HV5LXbXnI3WH7DANyJhDljdXLTWVdXRhtCNFdKZE+2h0k2zLw2uN3xbqrzpxzTnVWrQZes8B2GqjmLeJ/xnXB0GcZyO5DacjPEhIrteMPrDnbzfLdY1oxza2lYClQmZTGFDxDtxpb0QyYe+GaQjHfCoyrOshLF4BjhYNhjs9qqajAmLHEVQUVHQ+/QRsQm/kCdTfK1SCFAh5yhGTm6lur/0LZx6t/iaIHKI44PwV6LUc1nlXTDexzceTgI4ody+FxtnkZdZQvtQ4DDGcP+nNWRcgbavj1cWyM8MdQf/AD6S43ZBYkPuyzhm/vVzdifAk9iPUPbrpYAxcuEi8wULlMs1zU+wIv6F0MpGs6Qlp2Ziu8EVSDI5XLYiStlAgMFTRwh7Kawnk5tAzPEBodRTOumF+3W54y9jKwHzPdeImwUh9ozFuAUIjIv7QHLOpSBaFL6uJ9EAA2QenotLClH2Q8TOrCAoqnL/93txye4FD0rapLF7bAZbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(186009)(1800799009)(451199024)(2616005)(26005)(53546011)(6512007)(38100700002)(86362001)(31696002)(36756003)(83380400001)(110136005)(15650500001)(31686004)(2906002)(316002)(66946007)(8936002)(8676002)(41300700001)(4326008)(66476007)(5660300002)(66556008)(6666004)(6506007)(6486002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1lpUE45V2lpOUlYVHc2QlNlWVhPVWFpS1ZXU1g5MXFtUGJxOWhpdWI1SFVx?=
 =?utf-8?B?MndMank3NzZNWVppTEVhVDlFdERhZm5JODNwZ0RhUVUvZGxBeWZjdkdaQWlL?=
 =?utf-8?B?aGdVUmxJQWFiQ256dG9Nc3dibmxndXZHcyszSUwycW50a0g2NFMxNlFaVURx?=
 =?utf-8?B?K1NVeWNSZno1eWhiYzB3NXd3SWtlZUZ1WGEyM28zQW95Y241dkhXeWJtd2tq?=
 =?utf-8?B?d2hEU3N6UUJoVnlrUEEzcHZaR0N5T1VBZHhKemxRVG1VVmlOdVQxN0ljM2hH?=
 =?utf-8?B?UFk0dHZ1THhFWW9WWlhKeThOMlA3dlNKZ2l1b29XSGVPTXZCblFjZ1B5d0Nv?=
 =?utf-8?B?R0E4dnZjU2Y3WGdGZmpFMHdpU3JjdkhYcGw0ZG5ET08zV2h3WTVkbVhvYXhK?=
 =?utf-8?B?Vmk3Q1dhQmpZMUdOcmdNSVV2YUJKT0ZocmREWkt2dkNjbklKRUtLYzBXdW1D?=
 =?utf-8?B?aWsyZ21xVVlOYS9pMHpnK24wZDc2NHpGdGI0MlhTem1xYVYva3ltbStmWHB3?=
 =?utf-8?B?NUs3S2JrWE9sTjJKWTJlVDFOby9tUVcwcU83emFZS3J0NVNkOXB2a24razRE?=
 =?utf-8?B?bUN5aW5WakZuN2M2dmZhMmkyOVA3UHpCS2hrenNmMERxTzM3VmgxTk1rY3dW?=
 =?utf-8?B?ZlE1NWlzUSsxNHUzTHFUY01xTDhNQXdpdlB5RitPbUljVW5FZm9qYkhkbVFR?=
 =?utf-8?B?RUw0TFJXTnYzRDVTS3I0VURINzRGa040OU81VzFqdHpLNHZGSmJXWlFvZWNI?=
 =?utf-8?B?U1ZPTEdsQ2tTRmZYM2JlYnBxVWVZckx3b1VXSjlXSE9KaUdWQTFhSUNEQzh0?=
 =?utf-8?B?MU5VV1o1VFpDeG9HZjIwaVIzeVlwdU03cFlob0IvVFJKN2ZHU2oxN1BtUlgz?=
 =?utf-8?B?Y1hFdWJ3SzZzdFZNeGFhV2pLZ2FURVZ0MWMyK0o0dVR4Wk91MzlqOVU3TnRl?=
 =?utf-8?B?bWxjQmhybndxazNRNzRPSkFtVGlqRUE2QlVIbVVRNnJPTDlTU3o4a2swdVlW?=
 =?utf-8?B?TXkyNDBSYkpLVm1ndjdWTitaVUJlWGtmNDB4cmYvRjVYbnZxSjgvYjVJN0tQ?=
 =?utf-8?B?RHhnY0xJR2N5SUE0Vk9LMG95aWJoZkdLRzdMVjlZZlFyZ2dsaDRxemwrNmQ4?=
 =?utf-8?B?V1QwSWdKSWxpL3hmTFJYcmQ0bFJYVTVOY1doUUFidEMrN3FxTUs3YUlSbW9Q?=
 =?utf-8?B?eVJ3R2pLTnN5Y3Q0Z0JkQ0c5ZEVZQUZKMU5sdzRrZXNMVEF5aGdMWDhjSEl5?=
 =?utf-8?B?VThyVWU4UTZ6ZUtwTDJTVHV3bTdtM3NFSUxUbUJnVGtXUnpxV3R1Qzk2VDNs?=
 =?utf-8?B?SlY2dmFhNHhLNTZwMUlYNnZyRDkyZlpGQXovajIvenNYaHF1Zk1WQzhGd2JT?=
 =?utf-8?B?ZzB1KzBUbWFwalRtcmFnUklqUkk5amRJS29teGdTTis0a2FvRm9taEJtSzZX?=
 =?utf-8?B?Z2kwT212eFVuTTlnU1VVa1NXcHhhU0ZtZFcyWk03UWdLZ3NpM3R4bFpRZ3Bk?=
 =?utf-8?B?LzZpMU8wTDRCS3A3VFF6MTRWbXRwWW9YV2l4anNXdFNiNFRZckFvbUYxUUFz?=
 =?utf-8?B?K3AvWHNYV01MUjVvOFg4RFU4T09oa2o1aW41ZERhTnd1RDBJcjRGM2RWcVBO?=
 =?utf-8?B?RWlSNTBMRy9EK3pJMXdLRERSSEd0S1lvQUFBbjlKbld1emdsd3JJeDVqTXhS?=
 =?utf-8?B?bnI3bDV2NDFvQVdpTzNZSkkvWHUxQ2syYTVsVjBrK2JIT2dMbzNqWjJ2S1Jq?=
 =?utf-8?B?Qm83YzFTK2pidHcwc0FmZXBSenY0QkdFRkNjazFCR0dVamhlOTFvc1R1bmVJ?=
 =?utf-8?B?Mkc5N3dpVG93SGkvZUpMRmRPWmIzSTIwWjRSaGxYZW5Dam43NXFEQ0dkZzFK?=
 =?utf-8?B?V2Vub3QyY3RNSlUzSGF2SEprOVZWSFNkUDdsaUpUNm9xbXhveVpBbXducWhj?=
 =?utf-8?B?QVFFR2pBRWpXbzlWSkN1dW5KUG9LVVhueWorMHFBekVJcDZPemljN3pEb1VL?=
 =?utf-8?B?Vy9UcVpnYWFpdWhGSGdHdzdkeit0NzZ0SHZjOWprdVFaaTgwK2RWd2t2Z0hF?=
 =?utf-8?B?M0dlUFE0M3VNS1FwWEhwTkplcmlsWmJ0OXVZWkpMZlR6WWNHYy96ZUdybE1K?=
 =?utf-8?Q?bA3Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b72329-3e3e-47e2-2c33-08dbbf86c8a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:23:01.7964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9pDKTYAC1/uvQKEpMKqcd7CgJpwVLGZrsI+82DnnaduEvUxC31LeKf3KsOrKhy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 9/27/2023 9:29 AM, Philip Yang wrote:
>
>
> On 2023-09-26 16:43, Chen, Xiaogang wrote:
>>
>> On 9/22/2023 4:37 PM, Philip Yang wrote:
>>> Caution: This message originated from an External Source. Use proper 
>>> caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> Otherwise kfd flush tlb does nothing if vm update fence callback 
>>> doesn't
>>> update vm->tlb_seq. H/W will generate retry fault again.
>>>
>>> This works now because retry fault keep coming, recover will update 
>>> page
>>> table again after AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING timeout and 
>>> flush
>>> tlb.
>>
>> I think what this patch does is waiting vm->last_update fence at gpu 
>> page fault retry handler. I do not know what bug it tries to fix. h/w 
>> will keep generating retry fault as long as vm page table is not 
>> setup correctly, no matter kfd driver waits the fence or not. vm page 
>> table eventually will be setup.
>
> This issue was there, I notice it when implementing the granularity 
> bitmap_mapped flag for mGPUs, to skip the retry fault if prange mapped 
> on the GPU. The retry fault keep coming after updating GPU page table, 
> because restore_pages -> svm_range_validate_and_map doesn't wait for 
> vm update fence before kfd_flush_tlb.
>
Now I start knowing your change: it is a general issue for gpu retry 
fault handling that tlb flush did not happen actually since vm->tlb_seq 
was not updated as we did not give fence to amdgpu_vm_update_range.
>
> It is working now because we handle the same retry fault again after 
> timeout AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING, and kfd_flush_tlb does 
> flush on the second time
>
> The issue only exist if using sdma update GPU page table, as no fence 
> if cpu update GPU page table.
>
> There are several todo items to optimize this further:
>
> A. After updating GPU page table, we only wait for fence and flush tlb 
> if updating existing mapping, or vm params.table_freed (this needs 
> amdgpu vm interface change).
>
> B. Use sync to wait mGPUs update fences.
>
> C. Use multiple workers to handle restore_pages.
>
>>
>> There is a consequence I saw: if we wait vm page table update fence 
>> it will delay gpu page fault handler exit. Then more h/w interrupt 
>> vectors will be sent to sw ring, potentially cause the ring overflow.
>
> retry CAM filter, or sw filter drop the duplicate retry fault, to 
> prevent sw ring overflow.
>
Inside sw ring there is not only gpu retry fault type, also has other 
interrupt types, right? These filters just drop interrupt, not make sure 
all interrupts needed to handle got handled. I mean delay gpu retry 
handler exist may drop more interrupts, some of them never got handled.  
But I think this risk already existed, and we may need increase sw ring.

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
>>> Remove wait parameter in svm_range_validate_and_map because it is
>>> always called with true.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 15 +++++++--------
>>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 70aa882636ab..61f4de1633a8 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1447,7 +1447,7 @@ svm_range_map_to_gpu(struct kfd_process_device 
>>> *pdd, struct svm_range *prange,
>>>   static int
>>>   svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>>>                        unsigned long npages, bool readonly,
>>> -                     unsigned long *bitmap, bool wait, bool flush_tlb)
>>> +                     unsigned long *bitmap, bool flush_tlb)
>>>   {
>>>          struct kfd_process_device *pdd;
>>>          struct amdgpu_device *bo_adev = NULL;
>>> @@ -1480,8 +1480,7 @@ svm_range_map_to_gpus(struct svm_range 
>>> *prange, unsigned long offset,
>>>
>>>                  r = svm_range_map_to_gpu(pdd, prange, offset, 
>>> npages, readonly,
>>> prange->dma_addr[gpuidx],
>>> -                                        bo_adev, wait ? &fence : NULL,
>>> -                                        flush_tlb);
>>> +                                        bo_adev, &fence, flush_tlb);
>>>                  if (r)
>>>                          break;
>>>
>>> @@ -1605,7 +1604,7 @@ static void *kfd_svm_page_owner(struct 
>>> kfd_process *p, int32_t gpuidx)
>>>    */
>>>   static int svm_range_validate_and_map(struct mm_struct *mm,
>>>                                        struct svm_range *prange, 
>>> int32_t gpuidx,
>>> -                                     bool intr, bool wait, bool 
>>> flush_tlb)
>>> +                                     bool intr, bool flush_tlb)
>>>   {
>>>          struct svm_validate_context *ctx;
>>>          unsigned long start, end, addr;
>>> @@ -1729,7 +1728,7 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>
>>>                  if (!r)
>>>                          r = svm_range_map_to_gpus(prange, offset, 
>>> npages, readonly,
>>> - ctx->bitmap, wait, flush_tlb);
>>> + ctx->bitmap, flush_tlb);
>>>
>>>                  if (!r && next == end)
>>>                          prange->mapped_to_gpu = true;
>>> @@ -1823,7 +1822,7 @@ static void svm_range_restore_work(struct 
>>> work_struct *work)
>>>                  mutex_lock(&prange->migrate_mutex);
>>>
>>>                  r = svm_range_validate_and_map(mm, prange, 
>>> MAX_GPU_INSTANCE,
>>> -                                              false, true, false);
>>> +                                              false, false);
>>>                  if (r)
>>>                          pr_debug("failed %d to map 0x%lx to 
>>> gpus\n", r,
>>>                                   prange->start);
>>> @@ -3064,7 +3063,7 @@ svm_range_restore_pages(struct amdgpu_device 
>>> *adev, unsigned int pasid,
>>>                  }
>>>          }
>>>
>>> -       r = svm_range_validate_and_map(mm, prange, gpuidx, false, 
>>> false, false);
>>> +       r = svm_range_validate_and_map(mm, prange, gpuidx, false, 
>>> false);
>>>          if (r)
>>>                  pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] 
>>> to gpus\n",
>>>                           r, svms, prange->start, prange->last);
>>> @@ -3603,7 +3602,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>                  flush_tlb = !migrated && update_mapping && 
>>> prange->mapped_to_gpu;
>>>
>>>                  r = svm_range_validate_and_map(mm, prange, 
>>> MAX_GPU_INSTANCE,
>>> -                                              true, true, flush_tlb);
>>> +                                              true, flush_tlb);
>>>                  if (r)
>>>                          pr_debug("failed %d to map svm range\n", r);
>>>
>>> -- 
>>> 2.35.1
>>>
