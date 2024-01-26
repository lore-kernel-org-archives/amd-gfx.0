Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B699C47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 15:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2857810FBA1;
	Fri, 26 Jan 2024 15:36:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81DAF10FB96
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 15:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfMO/qyegvb3walhjdJyjIDSSNNslMkNvtt55ur6Tk6HvAqer9xRzUKJEPgywJXKx1hzzzKKC740faLQ54qVrbnapvr8weP97NDUaWrFQdZOm5Jtt7G4tmr3RCKIQ4DT2ktw3vWxw/IEj4goYaxxnRT8p4MW9b8BKjH8oKUxudqDfthc9bMSYV1XnhEVmpamDJ/GMDNpK50pO8wP4LG4di/lWa2AKueMtKHitZf1I52AlFqni+Ekc9Bmrb7+doOBIXM0Ne9OKY+4lfT++bN4V9/QOaWamCnEL9dTyYMsJljq693Olr5WgB8sjdeqanZxs/HVijlElsnXmLQQdq8Jgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcMvmTUumTKnNyiRc9gdJs4lWmeFva5Agx9T8IopSaI=;
 b=G//j9Vd8p4B2sVNXlf21Yhoy9+2tU9PxrmRZ39o3inaBttFf+ZL6DHSx24ju/kibc5W0O87p8d3RfDsaGKEWPLnoxs6sO6qYEk7D7oBu0FWa/6GS/SdrjGhCFqrPDcoTbkB1zcnqVXGnwRC2UNbOufwahSXsbJrF16fsPZVpRD5+cvznO8isr8D4pRlruG5Mzv25CWGQX4c4SxtNyuiFoe9bPYFvMe+YEQWo0sGOZygUq/tq0Xdd3YoKbwfQkIsBGh+BCHLvEAIzGQFgBbQsIHQQlEbzW+PZVe5qjkxQRsL/S1lEkM8mAIRDwPhINUDzG07QuXjBf6B+6vEs2pZ5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcMvmTUumTKnNyiRc9gdJs4lWmeFva5Agx9T8IopSaI=;
 b=nwkWLcEBY92nHJVrzcn4T+HGsE69d47FAdwEoQwnCGgHFuZ9wplsCZOP3DqjeaxL5CT8Yo4U8R1o5kQvSDcZl8xiNJOsHAIKAgOCWBnk07sOloe7guGYlCEvv06q+Vn72ye0kyJvV1sBgwtOrfw4lgzTOvvkqE8Rhu3sbvFIMj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 15:35:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7228.026; Fri, 26 Jan 2024
 15:35:58 +0000
Message-ID: <5ad7382e-5b3f-49b1-9aba-59a316feb7ab@amd.com>
Date: Fri, 26 Jan 2024 16:35:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Limit the maximum fragment to granularity size
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240126143830.30586-1-Philip.Yang@amd.com>
 <9c59557b-f6e3-45a9-bd4d-bddea9339e92@amd.com>
 <170486a5-ec4b-08cd-a993-3efc569de0c9@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <170486a5-ec4b-08cd-a993-3efc569de0c9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 2016a9c8-1a97-41b6-48ec-08dc1e847e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BzX0XnkXfR1F0Dmir+bWnFC9Y9qFixbjys61Qm5hgTzXVZg89H/xzOTcttCtcnxsvU69yLQO+CTNb/vZ/yLjnsLFJLQcTvD9tafobKxD/rmY0gMnqibhSck16DNaK3vUe5S40oJ4wqFy1gnxoRvRg7y4q7xmNQLGDbk4N8Qpp1/deUsCodxhM4X8xc7uHHxK3htEIVeVZFf3FLYYPmBmSpuLjzvdckjGb4uTEyhlzeQQCTI6DE8OiWE44jwKb7/DBX2ePhgNCcWyou9PDki6pQpbCCCDVyQTNJnNoeeO/9/3h+dzFz4BNK8RK2kiK/ZVTxW6HUV2VuCWUbNB7HpM6PuYLBIFkjFUJwD1mvQfjakkmonQB2/us/N4uIi9AFyU6N5RE1dyNDLgr1604hjrxLLca3lpKsurfxxzgVLqpISpGfMkDwfTN91Q9HZhRtR5HKvYFuQhDhT99KpFeu2RXm6bVbxL0iOsrFlUKiVVSG1VDzZy0dBfKg5gvIjItBHJ3quvZwfxElQv4dQCeeNFkOCyl3J7nG4a7zZ95GAWZvbM2GjUK8ej/MaqIlj3A+laj8pg4K0ZHlAJnicKU+K3WylrhJUx13tIU/p7AnVKt4aflws010z1GDFD0MzVkaZOOWWPQcWWqki/KNZbViQ3eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(4326008)(8676002)(8936002)(316002)(66946007)(66556008)(86362001)(66476007)(31696002)(110136005)(5660300002)(31686004)(30864003)(2906002)(478600001)(6486002)(6506007)(6666004)(6512007)(36756003)(2616005)(38100700002)(26005)(66574015)(83380400001)(41300700001)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnQ1T0o2aHE0Y0lpU2kwQzVXOC9RU1lndEp5ejBqWFZnLzdVQkxmQXB2NGcv?=
 =?utf-8?B?RHNUVFRRVDlTTjQ4QjF6bnNNWjJBWUFQT3o3d2lZSEZpeSsrdmo5VnNvNUpV?=
 =?utf-8?B?MjN3c2tzSFNmbW9wY2FWeDVLSHJwQUsxUzB1M0U2WXp2MkJ2dDA0ZU1zaTN0?=
 =?utf-8?B?L1lvbzdneG9pTkVXL1c2ODVJWXE2andEekhXTzZHWjRoK1lKdXJNaUlIZTNm?=
 =?utf-8?B?VVJEYktCMHorQWE5bHo4elVjcW9GZ1BmZkNQT0VZRlUxYVd4RWtJYUhwVWRO?=
 =?utf-8?B?S2VFM2liN3hnSHZ5VHhJNG5kUjRteDRTKytMYzhaNmtBVzRETkZ2QlFJM285?=
 =?utf-8?B?QnluMVNQMktsNkhuN0E5c2ovQytCR2dWSENQY0lkemtKY3BXNE1CUDNxRXlx?=
 =?utf-8?B?Zm1nczNTSFgxTUdnTU42RHIyL2I3R21aR0Y0UHBNV1FVZXNMUlkzeFNDQ0po?=
 =?utf-8?B?TlQ1eng0Vmc1Wk5HR3I1ZlpYSTJaQTdFSWJrWjNlL2Y3cjV3eUF4K1JWQlRi?=
 =?utf-8?B?OVAycTZwdENaa1ZnNytyc2lyTDJuY0dMNmhLanZ3TlBsOEpCOUJpK1JqVWxV?=
 =?utf-8?B?a0s5UEFKMWVFb0hVMGJ3UGFsdU8zN2JCVkF0OGh6NDZYVEZ0LytNdzlUYU11?=
 =?utf-8?B?Y1c5cUlZVmhhVmtCbm1DbW54QktRQ2tsbkJ6enpzYjZCRThiSWU5ZHVRakgv?=
 =?utf-8?B?REJqZ2xqSnNSWmhFTWlKQ3FPUzZIbDVrQjVRakhQVm1iSS82R1RaM0lrdXJt?=
 =?utf-8?B?aGFRUTN0ZElpZ3pLM1dqbkw5V2g4Njc5OFJxQmtMR3YyalJ4RXpkVUdhTkpS?=
 =?utf-8?B?QTFUSWxRRTdtVk9hTjZiUDFzM0JhbDN0a2orQURGM2xiTTRWUlJFaEUzTmRP?=
 =?utf-8?B?NW52eXJ1TjBFSm5nRmpKdFc3aDNlMVpMOVpsODNzaFBHMCtrZGFmUzRFTXdj?=
 =?utf-8?B?NUJsL3Z4WEZWdWN2RDBVaTNFdmhVUE42UFdQQVNiN0huTWsyeE9FclhPTUhD?=
 =?utf-8?B?THRJQ2dUYW9EczU2ZGVSS3J1b3pnTGhUcUFickVlVWlFOXdaTEc2MW1JVERu?=
 =?utf-8?B?Rzd0cXl4dG5YdW5mc0pxb2ZhaFJiUENsZXFwUXJ4QmV1WlBJcnRLOS9rcDRT?=
 =?utf-8?B?Vng5NVBaWFRpWXBheGhNMThhYU5id3YyVCswenNqQjYvT1lyWEI2Smt6dkpt?=
 =?utf-8?B?UGwydVM3R29zSWJ2MFFKZUpJdDVhVC9mTFZzUUVSTkFkZFNveTFGOVl0b1Fy?=
 =?utf-8?B?dWFYckJORVc5NUptSC9peDFwY1BOTStqcjlpbkxYVDRLeUVzaHFMUzNXYmp2?=
 =?utf-8?B?NVRBYkZydGZNTHZVNG93RkRkbG5keFZqL3RUSzJqeVYyS2RDQzkxZ2s0K09V?=
 =?utf-8?B?N1ZWeVQ1T2QrN283Vkh1MjZuc2k0b3dRTWNKb2VKZkNNOUZPNW5RUExtZWZz?=
 =?utf-8?B?S0lzcnRRdXNqbnpoTk9nZGxwekxNLzhTMHJGZFVGd0pHeHRQcGNML0xYdERo?=
 =?utf-8?B?VUkyWkdNY2o3eFp1cXZiUTBPb3liUUtqU3pTdnJuellTY3ZZczB4SWRxYXlm?=
 =?utf-8?B?eXFNR0lzZXZZbTgxamlHa3lFWU9YUWkreVJ5WW9OQzBjMit4QUo5UlV6OGlh?=
 =?utf-8?B?NkljZHo0MXBHbDNaTjV3SXhTVzlXL1BTT2wxSks4SVoxbS9zdmc1Z1RSZFZu?=
 =?utf-8?B?aXZwcWdkdFpIZWd1Zk1tYWhUSEZvRzAyOEZCWG9Od0NQbmJ4cUQ0bGlGYzFI?=
 =?utf-8?B?M1p3b3ZUVXZLTTVpR2FhRmdCQ3BkbVg3YjM0ZmN0eThKYi9QNzYvemVIRVZv?=
 =?utf-8?B?VmdRaEdOR29od00wRERONnJNS0swSVJCSTZXUjcvOXplMUdRSVZ4VW9wVkRS?=
 =?utf-8?B?Q2k5aHdKcDUzZ0k4NXdJRWZtWmVUNHRCK3J2bW9Sb2d5eFZoV25JQmp3UUFQ?=
 =?utf-8?B?UURoUS9MVWdMUU5lWVFBNHpTb1YwektnQXdiVlhyNmIxNEpjZEJOeVB5Kytq?=
 =?utf-8?B?S1BhWVBRT2FGUWlqS3E2VlU2MERvUWpWUXZxMUZXZ0FaWm82SzIvZEFBYVh2?=
 =?utf-8?B?ZlhFc1hyY3V3RWJXRThCcktRYXJxaVEvNVUwajBjQXJnVU1yRjMraFM4UzJz?=
 =?utf-8?Q?/GUD2F8Nf84Ss3iqNnew809Fq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2016a9c8-1a97-41b6-48ec-08dc1e847e37
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:35:58.3581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N24zs4aMpeQKHLyDsUHwoWreFW/e7x9h/lSo8JwI9qeryEaQTZLCby9drSS//gm2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
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

Am 26.01.24 um 16:17 schrieb Philip Yang:
> On 2024-01-26 09:59, Christian König wrote:
>> Am 26.01.24 um 15:38 schrieb Philip Yang:
>>> svm range support partial migration and mapping update, for size 4MB
>>> virtual address 4MB alignment and physical address continuous range, if
>>> mapping to GPU with fs=10, after updating mapping of the first 2MB,
>>> if the second 2MB mapping fs=10 in cache TLB, this causes the first 2MB
>>> access to the stale mapping.
>>
>> Well that sounds fishy. When that happens with (for example) 4MiB and 
>> 2MiB, why doesn't it happen with 8KiB and 4KiB as well?
>
> unmap svm range is aligned to granularity size, if the range size is 
> 8KB (all within one 2MB granularity range), it will be mapped/unmapped 
> as 8KB, even if only 4KB is migrated. This is handled in another patch 
> series "amd/amdkfd: Unmap range from GPU based on granularity".
>

Ok that makes a bit more sense.

But when you have a linear 4MiB mapping and unmap the first 2MiB of it 
you need to flush the TLB anyway.

So why would that cause a stale access?

Regards,
Christian.

> Regards,
>
> Philip
>
>>
>> Christian.
>>
>>>
>>> Limit the maximum fragment size to granularity size, 2MB by default,
>>> with the mapping and unmapping based on gramularity size, to solve this
>>> issue.
>>>
>>> The change is only for SVM map/unmap range, no change for gfx and 
>>> legacy
>>> API path.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 12 +++++++-----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 22 ++++++++++++----------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  9 +++++----
>>>   4 files changed, 26 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index ed4a8c5d26d7..a2bef94cb959 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -897,6 +897,7 @@ static void amdgpu_vm_tlb_seq_cb(struct 
>>> dma_fence *fence,
>>>    * @res: ttm_resource to map
>>>    * @pages_addr: DMA addresses to use for mapping
>>>    * @fence: optional resulting fence
>>> + * @frag_size: max map fragment size
>>>    *
>>>    * Fill in the page table entries between @start and @last.
>>>    *
>>> @@ -908,7 +909,7 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
>>>                  struct dma_resv *resv, uint64_t start, uint64_t last,
>>>                  uint64_t flags, uint64_t offset, uint64_t vram_base,
>>>                  struct ttm_resource *res, dma_addr_t *pages_addr,
>>> -               struct dma_fence **fence)
>>> +               struct dma_fence **fence, unsigned int frag_size)
>>>   {
>>>       struct amdgpu_vm_update_params params;
>>>       struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>>> @@ -1016,7 +1017,7 @@ int amdgpu_vm_update_range(struct 
>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>           }
>>>             tmp = start + num_entries;
>>> -        r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
>>> +        r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags, 
>>> frag_size);
>>>           if (r)
>>>               goto error_free;
>>>   @@ -1197,7 +1198,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>                          !uncached, resv, mapping->start, 
>>> mapping->last,
>>>                          update_flags, mapping->offset,
>>>                          vram_base, mem, pages_addr,
>>> -                       last_update);
>>> +                       last_update, 0);
>>>           if (r)
>>>               return r;
>>>       }
>>> @@ -1392,7 +1393,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device 
>>> *adev,
>>>           r = amdgpu_vm_update_range(adev, vm, false, false, true, 
>>> false,
>>>                          resv, mapping->start, mapping->last,
>>>                          init_pte_value, 0, 0, NULL, NULL,
>>> -                       &f);
>>> +                       &f, 0);
>>>           amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>           if (r) {
>>>               dma_fence_put(f);
>>> @@ -2733,7 +2734,8 @@ bool amdgpu_vm_handle_fault(struct 
>>> amdgpu_device *adev, u32 pasid,
>>>       }
>>>         r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
>>> -                   NULL, addr, addr, flags, value, 0, NULL, NULL, 
>>> NULL);
>>> +                   NULL, addr, addr, flags, value, 0, NULL, NULL,
>>> +                   NULL, 0);
>>>       if (r)
>>>           goto error_unlock;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 666698a57192..b34466b5086f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -465,7 +465,7 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
>>>                  struct dma_resv *resv, uint64_t start, uint64_t last,
>>>                  uint64_t flags, uint64_t offset, uint64_t vram_base,
>>>                  struct ttm_resource *res, dma_addr_t *pages_addr,
>>> -               struct dma_fence **fence);
>>> +               struct dma_fence **fence, unsigned int frag_size);
>>>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>>>               struct amdgpu_bo_va *bo_va,
>>>               bool clear);
>>> @@ -531,7 +531,7 @@ int amdgpu_vm_pde_update(struct 
>>> amdgpu_vm_update_params *params,
>>>                struct amdgpu_vm_bo_base *entry);
>>>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>>                 uint64_t start, uint64_t end,
>>> -              uint64_t dst, uint64_t flags);
>>> +              uint64_t dst, uint64_t flags, unsigned int frag_size);
>>>   void amdgpu_vm_pt_free_work(struct work_struct *work);
>>>     #if defined(CONFIG_DEBUG_FS)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index a160265ddc07..4647f700f1c6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -860,12 +860,14 @@ static void amdgpu_vm_pte_update_flags(struct 
>>> amdgpu_vm_update_params *params,
>>>    * @flags: hw mapping flags
>>>    * @frag: resulting fragment size
>>>    * @frag_end: end of this fragment
>>> + * @frag_size: max map fragment size
>>>    *
>>>    * Returns the first possible fragment for the start and end address.
>>>    */
>>>   static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params 
>>> *params,
>>>                      uint64_t start, uint64_t end, uint64_t flags,
>>> -                   unsigned int *frag, uint64_t *frag_end)
>>> +                   unsigned int *frag, uint64_t *frag_end,
>>> +                   unsigned int frag_size)
>>>   {
>>>       /**
>>>        * The MC L1 TLB supports variable sized pages, based on a 
>>> fragment
>>> @@ -893,7 +895,7 @@ static void amdgpu_vm_pte_fragment(struct 
>>> amdgpu_vm_update_params *params,
>>>       if (params->adev->asic_type < CHIP_VEGA10)
>>>           max_frag = params->adev->vm_manager.fragment_size;
>>>       else
>>> -        max_frag = 31;
>>> +        max_frag = frag_size ? frag_size : 31;
>>>         /* system pages are non continuously */
>>>       if (params->pages_addr) {
>>> @@ -904,12 +906,10 @@ static void amdgpu_vm_pte_fragment(struct 
>>> amdgpu_vm_update_params *params,
>>>         /* This intentionally wraps around if no bit is set */
>>>       *frag = min_t(unsigned int, ffs(start) - 1, fls64(end - start) 
>>> - 1);
>>> -    if (*frag >= max_frag) {
>>> +    if (*frag >= max_frag)
>>>           *frag = max_frag;
>>> -        *frag_end = end & ~((1ULL << max_frag) - 1);
>>> -    } else {
>>> -        *frag_end = start + (1 << *frag);
>>> -    }
>>> +
>>> +    *frag_end = start + (1 << *frag);
>>>   }
>>>     /**
>>> @@ -920,6 +920,7 @@ static void amdgpu_vm_pte_fragment(struct 
>>> amdgpu_vm_update_params *params,
>>>    * @end: end of GPU address range
>>>    * @dst: destination address to map to, the next dst inside the 
>>> function
>>>    * @flags: mapping flags
>>> + * @frag_size: max map fragment size
>>>    *
>>>    * Update the page tables in the range @start - @end.
>>>    *
>>> @@ -928,7 +929,7 @@ static void amdgpu_vm_pte_fragment(struct 
>>> amdgpu_vm_update_params *params,
>>>    */
>>>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>>                 uint64_t start, uint64_t end,
>>> -              uint64_t dst, uint64_t flags)
>>> +              uint64_t dst, uint64_t flags, unsigned int frag_size)
>>>   {
>>>       struct amdgpu_device *adev = params->adev;
>>>       struct amdgpu_vm_pt_cursor cursor;
>>> @@ -938,7 +939,7 @@ int amdgpu_vm_ptes_update(struct 
>>> amdgpu_vm_update_params *params,
>>>         /* figure out the initial fragment */
>>>       amdgpu_vm_pte_fragment(params, frag_start, end, flags, &frag,
>>> -                   &frag_end);
>>> +                   &frag_end, frag_size);
>>>         /* walk over the address space and update the PTs */
>>>       amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
>>> @@ -1040,7 +1041,8 @@ int amdgpu_vm_ptes_update(struct 
>>> amdgpu_vm_update_params *params,
>>>               if (frag_start >= frag_end) {
>>>                   /* figure out the next fragment */
>>>                   amdgpu_vm_pte_fragment(params, frag_start, end,
>>> -                               flags, &frag, &frag_end);
>>> +                               flags, &frag, &frag_end,
>>> +                               frag_size);
>>>                   if (frag < shift)
>>>                       break;
>>>               }
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index ed35a490fd9e..d71b2c8bf51a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1488,7 +1488,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
>>>   static int
>>>   svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm,
>>>                uint64_t start, uint64_t last,
>>> -             struct dma_fence **fence)
>>> +             struct dma_fence **fence, unsigned int frag_size)
>>>   {
>>>       uint64_t init_pte_value = 0;
>>>   @@ -1496,7 +1496,7 @@ svm_range_unmap_from_gpu(struct 
>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>         return amdgpu_vm_update_range(adev, vm, false, true, true, 
>>> false, NULL, start,
>>>                         last, init_pte_value, 0, 0, NULL, NULL,
>>> -                      fence);
>>> +                      fence, frag_size);
>>>   }
>>>     /**
>>> @@ -1579,7 +1579,7 @@ svm_range_unmap_from_gpus(struct svm_range 
>>> *prange, unsigned long start,
>>>             r = svm_range_unmap_from_gpu(pdd->dev->adev,
>>>                            drm_priv_to_vm(pdd->drm_priv),
>>> -                         start, last, &fence);
>>> +                         start, last, &fence, prange->granularity);
>>>           if (r)
>>>               break;
>>>   @@ -1647,7 +1647,8 @@ svm_range_map_to_gpu(struct 
>>> kfd_process_device *pdd, struct svm_range *prange,
>>>                          pte_flags,
>>>                          (last_start - prange->start) << PAGE_SHIFT,
>>>                          bo_adev ? 
>>> bo_adev->vm_manager.vram_base_offset : 0,
>>> -                       NULL, dma_addr, &vm->last_update);
>>> +                       NULL, dma_addr, &vm->last_update,
>>> +                       prange->granularity);
>>>             for (j = last_start - prange->start; j <= i; j++)
>>>               dma_addr[j] |= last_domain;
>>

