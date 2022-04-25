Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8DDC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 13:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462FC10E9B9;
	Mon, 25 Apr 2022 13:47:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14A1810E9B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 13:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMK9i8Bu+AG31x60Ck3M9zAQkw9Yr6A2DSeh/1s9hTJO3Scgjt5LMpAW7aJlgKRtG8ePLTVUDKgpSLnPjcWlIK+N2N5Bm8NQ3mG8dd3edV3d+ZvLqnVMAvxBXszBWl/sBLpTsmco3MXLcu/4h3KxJJa8jHeQG5gbUNyOO7AYmcXqH5uZSNgwpAjKrzSHvFrQ6umsz9zKsj1VIeLXkrbNXeplQ1nu7UVoR1vzzeaz64pXDuGEKGNLagylzKUEZ64dznNLvW4cfRwRODMfqY4eo1I7CTffzDbRBQiCdLx5uHNltj72w8j6/1CG8Ae+fwiaY7ZgnY8J13qjXmgHH/PQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u03BTiFhTUslJrXi1gukgwp1HNfVdQo2hNlB3Z10cuY=;
 b=kcgIgUqR0SW0tKGP+l+gJ6MZgoSbsPMI6GSSafhYkErkgJUYB6Tg698lmWh5nucHnB/93bRg2vCjg0XE5PdfFPY4WT3rSpM610biCnzc2rSbP1SaDqKgskr0Saa/7kEkefSSD1QwE6bCc32uYiqIebYOlODDoRA7nAZfdMRugTNSWiA3J2SLYNw1f1NOd3ztphBOzNo3pGaszH4kQaFZf7ssZdlYAbv4WeJRJkvTkKBLk7PFgVXNFBF/hjGofACuHzbSaJYihRmajwevjm1UkzVJe7e0NgMnS7YqdDY5/waZmdJ9qKm0iaUhIZ4kttEZDSg0JOy2xcBBlie83PW/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u03BTiFhTUslJrXi1gukgwp1HNfVdQo2hNlB3Z10cuY=;
 b=FsJXTDTyRP2VZS7lwEVeIZ1cgrM7M2SOVeHlz/+gwQI7bJkZ3ruSlQNUFvEbPKrZNLWPyH5oa7/EPFjjFqyhzbF3yHGayzOz9x5UTlPwD1vhqvk6891iiybRZRkU+PLU9guUb35FbS9R/RWq5qaPayYU5BsSourNQ/FwET4mqWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 13:47:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 13:47:08 +0000
Message-ID: <1f8f303f-f7f8-1a06-0950-b4a0631107a9@amd.com>
Date: Mon, 25 Apr 2022 09:47:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Update mapping if range attributes
 changed
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220420004742.8780-1-Philip.Yang@amd.com>
 <20220422140640.26783-2-Philip.Yang@amd.com>
 <b8af3d1d-5877-d213-5a3a-c1795affb007@amd.com>
In-Reply-To: <b8af3d1d-5877-d213-5a3a-c1795affb007@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6908cabf-8292-4846-55e0-08da26c2170c
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3876BD5D66D90445BF12DB8B92F89@BY5PR12MB3876.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjktF9gA3TGVoau2RREerBHfBNvoGQKYmfsvbeohi4SURVzskgFjUoRW3yvLJNcXkCRMfSm1G1Q13+hLLOEMwcQD+pmz5l36d5eVCT+tjRiV4sKGO3VRP+1BiSIPAkjMKVuHO5lpZb6P+4M8f+RtnVWopOWz/WMbQUU6KAntMVdAvsm4r8Ow4jbL8yNaAjMQtLubDA1e5NPUuDuJltZRNSbDeNWHjvMbpbqCF53BMeFY7fhgH0Pj5cIV0G5FwO2GKfLP/Y75uzk8Ipy+3rp8OWcsVj6QlRH/rMHNiLR9T8NDBB/8LNAsnvQJTYNng8HeQynNDFFEZw3Rgeev2EcYkc7X/nGVxBEQ/tywM+lxsjNZe/NzHfcFdt6Ua60Axs/ncR9bZ1o2PkTBsKe8uU0RBb8tF9DEVaWkTzJ1ztYcAvddarbSpJ75Y9WZ5qGBJVuVkGYMZ9D3xZhDW4sdh0i4fSV3WVf+C5iGG6Wom9mGUnZ3zRLrBbFQalV7MHfySxUZg1rI7PTYTC+29xblojC+osUfxwoliG/18ZBLy+vumR88Y4Pfos/hsgg4+gMvU/FXUjjSkDv4VhSKUPaGJoYqdFTa4FRZlIPaP5N/S8cE2995dJL1sZ+kJ/NKb6suTdFrC5JaE+6uP8bQlyJTvSL1jtvL+KMNStaDxSmVamE8ePH7dq1MxtWTUAbr4dga8Wyyapp0CNeqsUDjUyi5xNh+LMcdhHoNLiLmsLHW3iPyows=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(83380400001)(38100700002)(86362001)(53546011)(508600001)(31686004)(8936002)(36756003)(5660300002)(15650500001)(44832011)(2906002)(26005)(31696002)(66476007)(2616005)(6512007)(66556008)(8676002)(66946007)(6506007)(316002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mzd2UXhoUGdjM3VUNVY1VTU5cjFXbHZIWFg0eWZtTGEzYjdOTHVOVmVHT1ll?=
 =?utf-8?B?dG1XcW5iZ1Y5NzdrVGNpTXlVRW9xanhpbzg5MzhZMTkzMVJ4M1hDei84VVB1?=
 =?utf-8?B?U3k3UHBEU1JiOVRMdTJhSVF4QitLMGhuQ3VTRHo2N2s3N1ZwSHFrTG05RzdT?=
 =?utf-8?B?dEcwSmhIY0RWOGtMQXpDZDBIc1lQdVpMQmpVVUJ1Q2dOWERIVDgzS1BoOUp5?=
 =?utf-8?B?Mi9YL3hPTld2TWJ5VVFNazh5UjhaZ1dhWGtQOFNaZkJUdEkxeHdZSjlzNjYr?=
 =?utf-8?B?RlRCQ0g0b0o0ZTU1cGZ1SG9QdkpKc2JwSlpzMXhPbHRDdnFzVEQwQW0zY0hG?=
 =?utf-8?B?eGp3QmprZlBTRVYyYTJ1cXBOZ0o1WTNxMVRIdnUwRzU3Qy9KeU1PenAweXB1?=
 =?utf-8?B?cG5RSUhPL2lYVnZsRjlyYzlMT0tHWkVTdS9yK3RlY01SYitnUzA4TS9uYmlI?=
 =?utf-8?B?emsvNTZyTnVhV3hMK1hoME81TXQ0ZVY5b3VxNmxYQndST08zcHRndUVnQ0NQ?=
 =?utf-8?B?NmJFbU5Mdjllc0hUaWRFRGxTZ20xWFREeUhiZnhiQUdSR3g5Y1B1SEFrLy95?=
 =?utf-8?B?dUhuMUMyVUtMVWZYN1Qxa2VrNnNiQ0JGcmczN1JBQy9BY1VGRURseWtsaVhL?=
 =?utf-8?B?SkdTSlBmQ3VESFhvQlRXdmU4TkdvMGdGQ0d4SHBHeFRMRE9kS25TK0NFNXU1?=
 =?utf-8?B?UEFvNkRDYjJsZ2V0eGRnWkYwWWxFclFROEt1emk3VlQzSEhpZ1NydkdjbHBH?=
 =?utf-8?B?aDJCdEVnUVdkMEVJa1B6MmhnOGVJb1ZUS0UvNW11RTNJajBCSVNSN28yZ1VS?=
 =?utf-8?B?ZnYwQURCalRENit4T0VvU2JFSTN4NWkvSWlGZisybURLeXMzbU1UTmxpRXBm?=
 =?utf-8?B?djNZUkZ6cExxYnVMVmh3eGl4b0xpOFNlclNFbHh3dmZoMFJVTFgzQUM3USs2?=
 =?utf-8?B?S3o5aWFaMmFJRXpKdk03NktIWmM1L2UvUXZjU3NjY2xybTdhaTR2VEIyTlp4?=
 =?utf-8?B?REhycnMxbXlTM3FqQjFUdzdsMzhWa0NoV05sODJCWU91UUp0MmVhbTYybC83?=
 =?utf-8?B?eEhkVDJmVWZJeWxoZFErUXdXN1lWNnlrY2pkVzZGem4rU2dpaG5Mc1huSXdF?=
 =?utf-8?B?WUdQa1NYbFMxZ0haZXdsdko5TkF4TXNtZmhDT2RrWDJmL1UwelU5RUlNaGpX?=
 =?utf-8?B?VHIvejRramVsNHR5M3VSbjR3YksxRzMzNW1zVU0zMGZVSXdzMDhWZlQ0alMv?=
 =?utf-8?B?MnN0ZXZlcnRmL0hkV3pxcWVXem80a2QybzQ0OEdKQUpvdTkzMnFPK0hSQVBR?=
 =?utf-8?B?aVBTaUFMc0hLSEZ5cnBqREpzZVcwMTNaRnFVRXRia3l4cUhnbjRXdnNNT0E5?=
 =?utf-8?B?Z3F1KzA1WTZweGF2RnRuMUpzcTFnbUsyclB5MjVHRzFxWEJRVzE4cVNMWDM2?=
 =?utf-8?B?cUtQQ1RDN3d4RWRaalZMSWt2cjFJTlVsSjFmZHAzNTkrcU1xWHNocUVaQ1NG?=
 =?utf-8?B?ZmJwYlFaK3Z0QnBxTkl6TmFTOFNCMEd3b1R2azBlamVJRFRwN0RyTldVU3l2?=
 =?utf-8?B?WitxKzNiL01MNzkzMGkwZE9YWHBYbkFFeVdFTStxMDBVNTdlZ29iWmpKeEZQ?=
 =?utf-8?B?SXRPdWZncStLVkpLVC9FUTk2cm8zZ00yVmFsbDhyWmRQSXljRW9Pb1NOc0dH?=
 =?utf-8?B?RHFjMUU1YjdIRVdISUlWcDQ2UklnWGVPTFVCUnh0UEZHcENPOG1QdGxIOVUz?=
 =?utf-8?B?SlBwUmt1QmtTOTV6YjNmbnFQSndaTzg4cWswaWg2ZEdYWFV5d3FPbExqUE5x?=
 =?utf-8?B?MUlFZVJIUDBOYml3MUlHclFSTzcwR1puZkkvNWhBZlRTQ0tWalFYNldkTXht?=
 =?utf-8?B?U2ZmZnduT0dxblhlZGszOC9RMTdqenlINE0wOTZTY2p2ZEdHK2QzRTBXUUpo?=
 =?utf-8?B?YWV6UnpHZTRNQnhCb2tqVzBtMlFEc1pVMXVzNXQ3Y25TOVRLZ2hWWTF5ZzVy?=
 =?utf-8?B?UC9jRVc0SzdkcHNwWE5mVnNuRklESVVpbXVQNWp2WWZSUmcya0hhUmdmUm5h?=
 =?utf-8?B?WE5CTFBiV2M4eUl5VXVDNFp5ZmJLWlBEQTNoQTc0SkhaOW41UkorczdlK2lp?=
 =?utf-8?B?QmowcTlXd0Vwd041QWg4VUtuYWl2cmhpeFZ4SEpLdlpDRS9rQTBINzRoc1k1?=
 =?utf-8?B?SFU2WG9IekpQSGhBY2tINGhuM1ZicG14MGZwSFlDdVBXNWFqQVExQXBUVHdF?=
 =?utf-8?B?U29hcWcrSlk5Mm9nZkNuS2NkZFRKRWFCcFpuMkMwOE9NdmFsREJNeWwxd1NC?=
 =?utf-8?B?cDc1azl0Mno1Q1J4ek45V0hqTVE1Q3VnWCtFd25LS1lmVnFSWnpkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6908cabf-8292-4846-55e0-08da26c2170c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 13:47:08.0885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7EU1KB8CEi/jPLc6aaBf3HmfLIbjSEqdSgU0xwAqnjAwJBuJR+FmgU6xhmsTnOxIVbuviAzypPpddpmvd7F0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3876
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

Am 2022-04-22 um 18:05 schrieb Felix Kuehling:
> On 2022-04-22 10:06, Philip Yang wrote:
>> Change SVM range mapping flags or access attributes don't trigger
>> migration, if range is already mapped on GPUs we should update GPU
>> mapping and pass flush_tlb flag true to amdgpu vm.
>>
>> Change SVM range preferred_loc or migration granularity don't need
>> update GPU mapping, skip the validate_and_map.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 46 +++++++++++++++++++---------
>>   1 file changed, 32 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 8a077cd066a1..e740384df9c7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -686,7 +686,8 @@ svm_range_check_attr(struct kfd_process *p,
>>     static void
>>   svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>> -              uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs)
>> +              uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
>> +              bool *update_mapping)
>>   {
>>       uint32_t i;
>>       int gpuidx;
>> @@ -702,6 +703,7 @@ svm_range_apply_attrs(struct kfd_process *p, 
>> struct svm_range *prange,
>>           case KFD_IOCTL_SVM_ATTR_ACCESS:
>>           case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>>           case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
>> +            *update_mapping = true;
>>               gpuidx = kfd_process_gpuidx_from_gpuid(p,
>>                                      attrs[i].value);
>>               if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
>> @@ -716,9 +718,11 @@ svm_range_apply_attrs(struct kfd_process *p, 
>> struct svm_range *prange,
>>               }
>>               break;
>>           case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
>> +            *update_mapping = true;
>>               prange->flags |= attrs[i].value;
>>               break;
>>           case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
>> +            *update_mapping = true;
>>               prange->flags &= ~attrs[i].value;
>>               break;
>>           case KFD_IOCTL_SVM_ATTR_GRANULARITY:
>> @@ -1254,7 +1258,7 @@ static int
>>   svm_range_map_to_gpu(struct kfd_process_device *pdd, struct 
>> svm_range *prange,
>>                unsigned long offset, unsigned long npages, bool 
>> readonly,
>>                dma_addr_t *dma_addr, struct amdgpu_device *bo_adev,
>> -             struct dma_fence **fence)
>> +             struct dma_fence **fence, bool flush_tlb)
>>   {
>>       struct amdgpu_device *adev = pdd->dev->adev;
>>       struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
>> @@ -1292,7 +1296,7 @@ svm_range_map_to_gpu(struct kfd_process_device 
>> *pdd, struct svm_range *prange,
>>                (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>>                pte_flags);
>>   -        r = amdgpu_vm_update_range(adev, vm, false, false, false, 
>> NULL,
>> +        r = amdgpu_vm_update_range(adev, vm, false, false, 
>> flush_tlb, NULL,
>>                          last_start, prange->start + i,
>>                          pte_flags,
>>                          last_start - prange->start,
>> @@ -1326,7 +1330,7 @@ svm_range_map_to_gpu(struct kfd_process_device 
>> *pdd, struct svm_range *prange,
>>   static int
>>   svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>>                 unsigned long npages, bool readonly,
>> -              unsigned long *bitmap, bool wait)
>> +              unsigned long *bitmap, bool wait, bool flush_tlb)
>>   {
>>       struct kfd_process_device *pdd;
>>       struct amdgpu_device *bo_adev;
>> @@ -1361,7 +1365,8 @@ svm_range_map_to_gpus(struct svm_range *prange, 
>> unsigned long offset,
>>             r = svm_range_map_to_gpu(pdd, prange, offset, npages, 
>> readonly,
>>                        prange->dma_addr[gpuidx],
>> -                     bo_adev, wait ? &fence : NULL);
>> +                     bo_adev, wait ? &fence : NULL,
>> +                     flush_tlb);
>>           if (r)
>>               break;
>>   @@ -1482,8 +1487,8 @@ static void *kfd_svm_page_owner(struct 
>> kfd_process *p, int32_t gpuidx)
>>    * 5. Release page table (and SVM BO) reservation
>>    */
>>   static int svm_range_validate_and_map(struct mm_struct *mm,
>> -                      struct svm_range *prange,
>> -                      int32_t gpuidx, bool intr, bool wait)
>> +                      struct svm_range *prange, int32_t gpuidx,
>> +                      bool intr, bool wait, bool flush_tlb)
>>   {
>>       struct svm_validate_context ctx;
>>       unsigned long start, end, addr;
>> @@ -1522,8 +1527,12 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>                 prange->bitmap_aip, MAX_GPU_INSTANCE);
>>       }
>>   -    if (bitmap_empty(ctx.bitmap, MAX_GPU_INSTANCE))
>> -        return 0;
>> +    if (bitmap_empty(ctx.bitmap, MAX_GPU_INSTANCE)) {
>> +        if (!prange->mapped_to_gpu)
>> +            return 0;
>> +
>> +        bitmap_copy(ctx.bitmap, prange->bitmap_access, 
>> MAX_GPU_INSTANCE);
>> +    }
>>         if (prange->actual_loc && !prange->ttm_res) {
>>           /* This should never happen. actual_loc gets set by
>> @@ -1595,7 +1604,7 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>           }
>>             r = svm_range_map_to_gpus(prange, offset, npages, readonly,
>> -                      ctx.bitmap, wait);
>> +                      ctx.bitmap, wait, flush_tlb);
>>     unlock_out:
>>           svm_range_unlock(prange);
>> @@ -1691,7 +1700,7 @@ static void svm_range_restore_work(struct 
>> work_struct *work)
>>           mutex_lock(&prange->migrate_mutex);
>>             r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
>> -                           false, true);
>> +                           false, true, false);
>>           if (r)
>>               pr_debug("failed %d to map 0x%lx to gpus\n", r,
>>                    prange->start);
>> @@ -2847,7 +2856,7 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>           }
>>       }
>>   -    r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
>> +    r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, 
>> false);
>>       if (r)
>>           pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
>>                r, svms, prange->start, prange->last);
>> @@ -3264,6 +3273,8 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>       struct svm_range_list *svms;
>>       struct svm_range *prange;
>>       struct svm_range *next;
>> +    bool update_mapping = false;
>> +    bool flush_tlb;
>>       int r = 0;
>>         pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
>> @@ -3302,7 +3313,7 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>           svm_range_add_notifier_locked(mm, prange);
>>       }
>>       list_for_each_entry(prange, &update_list, update_list) {
>> -        svm_range_apply_attrs(p, prange, nattr, attrs);
>> +        svm_range_apply_attrs(p, prange, nattr, attrs, 
>> &update_mapping);
>>           /* TODO: unmap ranges from GPU that lost access */
>>       }
>>       list_for_each_entry_safe(prange, next, &remove_list, 
>> update_list) {
>> @@ -3335,8 +3346,15 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>               continue;
>>           }
>>   +        if (!migrated && !update_mapping) {
>> +            mutex_unlock(&prange->migrate_mutex);
>> +            continue;
>> +        }
>> +
>> +        flush_tlb = !migrated && update_mapping && 
>> prange->mapped_to_gpu;
>> +
>
> Please check that this doesn't break the XNACK off case. If a new 
> range is created, and that does not trigger a migration or any of the 
> conditions that set update_mapping, we still need to make sure the GPU 
> mapping is created so that a GPU access to the new range won't fault.

Thanks for following up offline. For the record, with XNACK off, the 
default is "not accessible". So to create a GPU mapping, the application 
has to set one of the accessibility attributes, which will trigger a 
page table update with your patch.

The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Regards,
>   Felix
>
>
>>           r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
>> -                           true, true);
>> +                           true, true, flush_tlb);
>>           if (r)
>>               pr_debug("failed %d to map svm range\n", r);
