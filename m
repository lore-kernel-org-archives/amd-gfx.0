Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAC2C678D4
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 20:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DAD310E23B;
	Wed,  1 Mar 2023 20:01:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C71210E23B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 20:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTZ8B4ygDq8vW31F9gfs51dYkjoQK8fDyKl4exhShVaHhnwUOTCP3+8Yt2HHczQ6ygjLg/n8xzadFi2JVULkFrZ44Ahib80xWlnpfotc6AAFMgLOHouwIcsOlA2zG9PvdajkLOkb3Av6AYF4gg+NFm97C19S61aQxJgYpLkRe0TI1Q2QkIN0TzZvpaTNOKmuGn3GE7xr4c7PfwRbmRu15fQLsBLiNsPc7nIJe6oG8T+zVhwrCG7J+1BdpoyTWShzN8lUd6Giq756/e7lmRR904C5idcL/z6Ak6D+bV65QR9YM12iKBuRaqobtGXJpMYhDIaMBXyOAkmgtZeHKbss+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxJgVmU3szEeHpcyRqAejRKEocxFZT6xKCAxSHElMi4=;
 b=FHprNy1LeE3Kgg+CIRfZRSiYpnlnknmxdUjIemIV40lZjuhLWICUqh73z0IBL2fqNnaCunEjj3nApntTYiW4hjAXqBcfpt45NXJdfQ/lpc6lK+U2DFjB5FH1mMiLu/BIWBeeKZge27IhM60k1kBE52+3uxlwbmVLcV/BQIc2eG7ZADOsP/zsPQoK2bYxyJLRuy4UEQmxeKD2rPI5OzXshs6E0iCftEl7nQ0dttqqSWcuqv4pbNxmFvvjsE3bthqh8oGtXeHqcsINr11PGfWNqlI/eQZM9vCrtk+XXWNvgUYC3niySfluUwH8jt9dmyOILmFj5fEuaVkqD5C9R7Gwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxJgVmU3szEeHpcyRqAejRKEocxFZT6xKCAxSHElMi4=;
 b=qcFY9/lepxnKQG3yemqMQBCKhI++YYFte/1STRnB4YKGzQBS92g/SbzMmW6dU2zPB/diWZCVmwvhR33kQyanvpb8915hczqjQCwKj7R76CnNUAfX2+U5P6wRV+2WGVCeC4ntiJhbptgdr+S8Xtg7RlJxLOj+u8xM/Ih0ZioOsRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 20:01:29 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 20:01:29 +0000
Message-ID: <c1217d9b-49af-f799-3091-cb8014553300@amd.com>
Date: Wed, 1 Mar 2023 15:01:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] drm/amdkfd: Cal vram offset in TTM resource for each
 svm_migrate_copy_to_vram
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230301163430.1782358-1-xiaogang.chen@amd.com>
 <1334b675-406b-c864-31c8-99dbc7fb0e6b@amd.com>
 <a7a00a37-6fc3-02a9-f1f4-a197a6fd6388@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <a7a00a37-6fc3-02a9-f1f4-a197a6fd6388@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0059.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: be3b50d0-4656-4448-8ee5-08db1a8fbedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rB6aRu6FvKFf3SLGaY1BgsFOMyFo+zPKlxj8SNBF3iFqOJtR6LcskYI6GS1gVy01cR5+3sg2rT890ITOzoMKlNOm78KGUxLDtH0o04zutJLlFeI2FqyUz4pHe85ylgFmnNcjKwtXjXt6sckIwP7mkvRX9tmiK0q/xAvwW4DHI4KnRMvYtSkdEkDo5wDlZ6YYolfngr85+WrsBg6jCy9X5xP4Bq06BUNJKF3qt5AfTfC3qFxYTl7M8ZS/bt1HBHuuShWqiAhhq4sQh9n4xf5MERPuzWXAcv6RSX6+B4CmWz99woZe6vCRdL1OMfkg2xMDFksoMWAwqOEQBuHdLltEki0Wm/T+T1sd5PkrTDVTcQSvrobZoY84X5vRyEv2Uzhh6vzlpK9co+x/24UH/Jc2qncwk9PK8mGPGjWkF1Rzg3DLkEmr1ufI4Zq04dhrWneZcO3Y3+/4/OZc89KVkd9mvYgM3orulbNdlobqsMX3bEogrd/OC+KBWY5kAoTUFDn0glMq+74qViCDR/5wiAIjmu8c5NMcc9km0+RzkXWoeea5Eyo+0ct80qRkTyBb4XrUsXZ/kbzMt67bhDI7JUnE99eMTxMWAcZu0cM6p5PxEbOwWDkpbyBat3IJesLd920GtHLv5PNWlSj8KQiJacCMxt7q1Hbkumc6inf1WTk9udQYqs7dnu+hm/NTUtNDIbTesMmZrVIN1pbXZca035R7n51BT8PNzeeOfVk00buHAjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199018)(66946007)(36916002)(53546011)(6506007)(6486002)(478600001)(83380400001)(31686004)(2616005)(186003)(8676002)(316002)(26005)(6512007)(4326008)(66476007)(66556008)(8936002)(5660300002)(44832011)(2906002)(41300700001)(38100700002)(36756003)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ait6REliK25ORHpNRlJ5MnZHV3Z5NW54ZnkzcmluRFBMcHBMZS9uUHpYTU5l?=
 =?utf-8?B?cmMxWVpZWS9xNmdhTUZ5STFuZUFkZnpNR3VpTzI2Q01Oc2NnTFhKMWdUUmNZ?=
 =?utf-8?B?Uy91UjBjN3Y2N1VUdWgxVjRnRXp4MjhlZ04zY0NKT1p3b1JFRWdxczNDemgw?=
 =?utf-8?B?RzdsMUp6a0xPckptMjBFOWdycG0vSU1yMCtwc1g5d2FwUHFtRU93eGUvWi8r?=
 =?utf-8?B?TlBFa2dwZE9PRWZpQm5rZGMvWktaNi82WTRUbDJFUDg2M0JPNkgrVE1hckxK?=
 =?utf-8?B?dHAzTmJvWUFjZi9DVHJ6OE1vOExURDB1Q1JxU29wanhWeitYYVpRRkJDdjkv?=
 =?utf-8?B?eGpaK0xkZjJIbkFMWVk1Yk5aUVp5MnpXRnIvWTVqSHhIdEk4OTM2R1lCcEwr?=
 =?utf-8?B?QkV6S2E5UEJURnE1OVV3MkcxbEMwK050dWppZ1NCanJ1Vnc1UE5xVjZSczA1?=
 =?utf-8?B?STd1QlBWT2R6VzVWMjRrK0pvNHJvcTUyemdvaFJGZlZ1QmVqNnZMWG9jMmZr?=
 =?utf-8?B?UTR1UEJYMWh3US9Vb2diSWNLUzdXeFZaMVM0SzJBcFZqeWhOM3JvQkpvQ1U1?=
 =?utf-8?B?QklqYjVTRkxPQVdSU0s3bjBwRjNDNUUzNkVtUkc5N09wMGYva2ZPVTdxN0VF?=
 =?utf-8?B?Nktod0p1aGRCZzFFY0hCclByOTIxYlg4OXpUUExZOGVyUVVqQnJlTE9KYk5K?=
 =?utf-8?B?STRNb3BpNmxPa1ZENGxyWmFqYlBYdVY5V0Zzd3RJejBkb0FpVnRsVUx3NGJU?=
 =?utf-8?B?ZkZZUjFpWkxONWF5d2NCZllBWk13bVJDTG5SaFdiMFVDK0RrZEtLdmtJWlRV?=
 =?utf-8?B?aFlvZk44azRCd290bld1UlJEVldFM2tYaGNqejNMbnJha0pxOFN5Y3g0VjN0?=
 =?utf-8?B?Qm5FMHovSmNEZUVZTFdyRnd2eWI0aFUwTlJKRzZ2TnEzRWNHUFlrL0FuWHVV?=
 =?utf-8?B?VVBGb0RIaFYzMXJCS2drb3BZL2FwWGlaZ1pMVkNhSlh4ZHFiTFBrYkhsZUpD?=
 =?utf-8?B?SndDSE52cWo4N1FlWEZIdFNNWWV5RWRFbng1ZzBxaUo4MjRDK3N2dTk3MnB1?=
 =?utf-8?B?ZnBYQ0wwcjZ6MEZ5akFQMVNaWUFNbWhXM2kyS1k1TDRQTmN6bDFmWks0ZU5o?=
 =?utf-8?B?MGkxL0Z1VUVwc1FSbEl3NFlhZnU1UFlHdDJJZkNSbDRKZlQvQ3F0Y254VEN3?=
 =?utf-8?B?QnFQSTRWMHZUNXJnMW9hT1ZlV2U3WTVVTzF1WlZsSUxEQk5tNVFwVE14aFV1?=
 =?utf-8?B?RHptMnBVYytUTVR2c2lBaXltaXlrQmZsYWpidHNKVlRFODRzOGlmenNxUDRV?=
 =?utf-8?B?ZU9ZY0VGVU1HSFEzUVFYTG1qSHVzWExkUG0xYzVtb3U4VlpjaXJZaURSeGd2?=
 =?utf-8?B?WTIvN3RsM3RxQVQ4WVpTeW1YZEx0TjZMWnZMYUlqb3dlQzZmekdxTmhzem1v?=
 =?utf-8?B?Y1NCS3dyOXNDdGF1eDR0alRpQ28rRVFSWFJJV1oxV1NVcnpNbFBlYVNETEE1?=
 =?utf-8?B?WjF6akhKUzlyejd1OHg0WkFkS28zRS82RTMrZTdhZGVITG5KdmlWa2VtRmJC?=
 =?utf-8?B?NlY1ZXhQanBxVy8zVjNKendBUnFHbi9SdHJVQ215L2NnQnpXWkV0d29jQit6?=
 =?utf-8?B?NENZcHZVQzNNd0d2RFZDZk9sS1RKUTdxSFI4b2dWdHZjMkxEcThoVnFIRjNL?=
 =?utf-8?B?YjBNeXdOaUpmY29aRkhEenF2U2VLZUVMT3pGUHVoUGxvQ0gvZGY0V1ZnaThV?=
 =?utf-8?B?b2hINE5jdmNuVDl0K3N1bjNGYjdzOXJXK1NhZ0FaaU1CaVNGdmhNdXR6aWtN?=
 =?utf-8?B?UzVqTGdhSi9JUm50UmNXdVJvZFBFQVBYZDVkRkRPeVk4NVNVY1ZhRUgraHJk?=
 =?utf-8?B?Y1FzeXpJZGpUM201RzVkV2hmeFF3R2RHRzBkRkRKZnRBWjB0RXpJOG9ZbEpm?=
 =?utf-8?B?NEUvYlY5aXpNcVBDcmtQenR5NGYvNnFvRVdtUERJajdqYmQyTkxjY0t6ZzR4?=
 =?utf-8?B?VGIyakMreVlxZzZkSUliZkRPeUVOK2I0SXZ0WnY5YnIrNFVJT2haYVUxNER4?=
 =?utf-8?B?bytIbWhENXRYMmlGeUFFSGlOejFPYXRyYVM0M0pkdG9rVnpiWVpyQU1rUVpM?=
 =?utf-8?Q?Cv9236ZY4uSKHOw2aMKOp2wGE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3b50d0-4656-4448-8ee5-08db1a8fbedc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 20:01:28.9703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNpupJIl5uhu7XQECOK2DQVhps24QkDUk6SYyebYA+SvzjGRFiArRr1nM+oys8ta1dFJPy2FGIOQq3j36VULrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269
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


On 2023-03-01 14:24, Chen, Xiaogang wrote:
>
> On 3/1/2023 12:54 PM, Felix Kuehling wrote:
>> Am 2023-03-01 um 11:34 schrieb Xiaogang.Chen:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> svm_migrate_ram_to_vram migrates a prange from sys ram to vram. The 
>>> prange may
>>> cross multiple vma. Need remember current dst vram offset in the TTM 
>>> resource for
>>> each migration.
>>>
>>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>>
>> The patch looks good to me. Is this a typo in the title: "Cal vram 
>> offset ..."? Should this be "Calculate vram offset ..."?
>>
>> For a shorter title I'd suggest: "Fix BO offset for multi-VMA page 
>> migration".
>>
> ok.
>> Is a similar fix needed for migration in the other direction, VRAM to 
>> system memory?
>
> From vram to sys ram migration, vram is src and hmm collects vram 
> pages by migrate_vma_setup. kfd gets each vram page addr by 
> svm_migrate_addr from page. So addr is correspondent to each pages. I 
> think it is ok.

Makes sense. The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Regards
>
> Xiaogang
>
>>
>> Regards,
>>   Felix
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 ++++++++++-------
>>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> index 1c625433ff30..373cd7b0e1ca 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> @@ -294,7 +294,7 @@ static unsigned long 
>>> svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
>>>   static int
>>>   svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct 
>>> svm_range *prange,
>>>                struct migrate_vma *migrate, struct dma_fence **mfence,
>>> -             dma_addr_t *scratch)
>>> +             dma_addr_t *scratch, uint64_t ttm_res_offset)
>>>   {
>>>       uint64_t npages = migrate->npages;
>>>       struct device *dev = adev->dev;
>>> @@ -304,8 +304,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device 
>>> *adev, struct svm_range *prange,
>>>       uint64_t i, j;
>>>       int r;
>>>   -    pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, 
>>> prange->start,
>>> -         prange->last);
>>> +    pr_debug("svms 0x%p [0x%lx 0x%lx 0x%lx]\n", prange->svms, 
>>> prange->start,
>>> +         prange->last, ttm_res_offset);
>>>         src = scratch;
>>>       dst = (uint64_t *)(scratch + npages);
>>> @@ -316,7 +316,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device 
>>> *adev, struct svm_range *prange,
>>>           goto out;
>>>       }
>>>   -    amdgpu_res_first(prange->ttm_res, prange->offset << PAGE_SHIFT,
>>> +    amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>>>                npages << PAGE_SHIFT, &cursor);
>>>       for (i = j = 0; i < npages; i++) {
>>>           struct page *spage;
>>> @@ -403,7 +403,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device 
>>> *adev, struct svm_range *prange,
>>>   static long
>>>   svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct 
>>> svm_range *prange,
>>>               struct vm_area_struct *vma, uint64_t start,
>>> -            uint64_t end, uint32_t trigger)
>>> +            uint64_t end, uint32_t trigger, uint64_t ttm_res_offset)
>>>   {
>>>       struct kfd_process *p = container_of(prange->svms, struct 
>>> kfd_process, svms);
>>>       uint64_t npages = (end - start) >> PAGE_SHIFT;
>>> @@ -456,7 +456,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device 
>>> *adev, struct svm_range *prange,
>>>       else
>>>           pr_debug("0x%lx pages migrated\n", cpages);
>>>   -    r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, 
>>> scratch);
>>> +    r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, 
>>> scratch, ttm_res_offset);
>>>       migrate_vma_pages(&migrate);
>>>         pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>>> @@ -504,6 +504,7 @@ svm_migrate_ram_to_vram(struct svm_range 
>>> *prange, uint32_t best_loc,
>>>       unsigned long addr, start, end;
>>>       struct vm_area_struct *vma;
>>>       struct amdgpu_device *adev;
>>> +    uint64_t ttm_res_offset;
>>>       unsigned long cpages = 0;
>>>       long r = 0;
>>>   @@ -524,6 +525,7 @@ svm_migrate_ram_to_vram(struct svm_range 
>>> *prange, uint32_t best_loc,
>>>         start = prange->start << PAGE_SHIFT;
>>>       end = (prange->last + 1) << PAGE_SHIFT;
>>> +    ttm_res_offset = prange->offset << PAGE_SHIFT;
>>>         for (addr = start; addr < end;) {
>>>           unsigned long next;
>>> @@ -533,13 +535,14 @@ svm_migrate_ram_to_vram(struct svm_range 
>>> *prange, uint32_t best_loc,
>>>               break;
>>>             next = min(vma->vm_end, end);
>>> -        r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, 
>>> trigger);
>>> +        r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, 
>>> trigger, ttm_res_offset);
>>>           if (r < 0) {
>>>               pr_debug("failed %ld to migrate\n", r);
>>>               break;
>>>           } else {
>>>               cpages += r;
>>>           }
>>> +        ttm_res_offset += next - addr;
>>>           addr = next;
>>>       }
