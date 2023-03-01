Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7476C678D4
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 19:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B3D10E235;
	Wed,  1 Mar 2023 19:24:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75BA010E239
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 19:24:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVAoIE29ueHfkktBs2/O2g8nCoi2TQAq1uueHhP0BcEShmHaAoahCPcnTyJMw8EE475rVHbXZsra9vnUqwONxFH1THoZJAWVHj3m9+u24MFU5i4tWJm0branpWJ3IDsIJVGleM1zUYT0QZLbTSMn6/3DdgNfEsY/wtkepE3/SNGcbJIDgRJo06ZgZ751bqNZTI0fg/UUvWeqhU6NWSxXBJ8iBp+N6MK0EdWhWBdPILSRnbqlUs3cejfeMp0XrE/DXO129Pd6gImXvXsUkyNCbKEXGZ6p+7etvP98fIiZ8icBK8to18jGmlHwWtR/WPYHOomxDVLIXE5pEC/N653X5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcWIfr2x8pQHpgyB6rO7WDTQE4A+srcOHXUXfGk76Iw=;
 b=BDNz6cfGEi7ILYDXoHOQs2gRUT6NKllyQb0fJwveobQzsldXEVflyNktOJ/Y4LDGhn1KamZkA2Wk0a97UCn8M4NGK/DJXwN9n5k6sMZaiBs4O9f4g4t+GRmfnLqdtIKJScpKYqfQv7VaPVa2x/OXaEQpbcuTTASphI3GxCV9q5KggL+OopZg012lxcBRXSqxHY+NwsSvF773hVX/R6PuNoYchKTY0KqpijgslrRSy9Q0YuwR6fGS/sV6qkiDItiXtP4LFDAmzufalgY/SZ2XnF4ENdOnKodbh+E5eWkNaGY66fLYAcOWqmQcThfaW0S22s6Hd/7aKrmBk2E4NsvOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcWIfr2x8pQHpgyB6rO7WDTQE4A+srcOHXUXfGk76Iw=;
 b=WtKNblUW4p3uGOaw4f+zboFi/9oQ1uYZ93j3jsyu/sdbFhyg9DmLxdrV9IUypEcY6lQKSPfpjOqY+duZFBfAgBz9VFdSMLsM6WCfzq5+4piIx2YgRgG+MEZ2hQh99yjDL8ek8ScI+UEm9vxy44fRURJrmSkVcln+eDY9PnRVV7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Wed, 1 Mar 2023 19:24:30 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::dcbe:dda5:a90d:eba3]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::dcbe:dda5:a90d:eba3%4]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 19:24:30 +0000
Message-ID: <a7a00a37-6fc3-02a9-f1f4-a197a6fd6388@amd.com>
Date: Wed, 1 Mar 2023 13:24:26 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amdkfd: Cal vram offset in TTM resource for each
 svm_migrate_copy_to_vram
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230301163430.1782358-1-xiaogang.chen@amd.com>
 <1334b675-406b-c864-31c8-99dbc7fb0e6b@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <1334b675-406b-c864-31c8-99dbc7fb0e6b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:610:58::27) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|DM6PR12MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbb3188-624b-43bb-0a43-08db1a8a9456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJWGIanpShzlfGk99QwM6U9Ue8DLc8NSMxwyD8g8MqwG99hhXvR8h8Zc3Y02UZVvYIIc3fh5Ety8QgOfdN9Q5ECLsAplVEK0A2Ah7LFAKIY7O0nW2Md7XFHA/yV8PUiJ+yu+VDDIMWkmoBqMgbO11gOVIl647hZqIOBcHcPpod7HMQIHz5lj98DTIvf6BmMgrdKbgcCnwuxVBkE24FEtHBB+SeI7tikQ6EHwclgpresDHC8EG/LntOEAn59/1qPblas5IQjtHuhTXP9ZflqH5sw/yYiAqmlyx4gYPBUu5tkWxZWYzuFUI9o/AnWnElbF50TK6R2awNWWeZSSJDrAtcNTcxihuV0ilEIQe1PCoGHDmzmQlUmn2QrpQm7aFC4UGfaaOK31nC6injTGTQk+DE5+xOa4SbnmmX0wiHkPPuXeEU1cjF2kCOehd4esQ5u8zxjnjmExmxRwYC2XOa3r2P0YYLzStiSEP8hjbhAOFGdA5eOq3nwV6BysIvK3RdokX+R218EsIr0c9kX4NGCYsRw1saZW8lqUAqUU+8Dt2xqX9CqSCebt1z1Bqu0+Wcll228TeE6lDV2zrGT1+rWACiHkuYcB0fHm9djBglfmHSY0I7imQLseNRGKMmiKUXskEe/6wSHQDsytNytoXLha0Qb3pRjP/ShVmBmkm9nQYPNycO9sK5EEGZER6EIP+haPKOlAWwZ2jsTRlspffvmODTLXRFuEOxRLv11T7GqY/k0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199018)(2906002)(31686004)(316002)(86362001)(478600001)(83380400001)(36756003)(5660300002)(8936002)(31696002)(8676002)(66946007)(66476007)(66556008)(38100700002)(4326008)(41300700001)(6512007)(6506007)(186003)(53546011)(26005)(6666004)(2616005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXdjcC8ycnFSakJ2WllSeGhsd3puKzhnK21pUndlTjV1Um9vbFpnYUpaWFU1?=
 =?utf-8?B?TkRoMndxZ1dNeGtJWjBpNDV2ZzdWcUhIa0IxRFVkK3VSMUhzbGtjM3p0T21x?=
 =?utf-8?B?YWpnWHpLY1Vqa3R5c0VBNVBQdDJqYkhsR0pZS0VHSjRmbnc0WkFxazAyZjBw?=
 =?utf-8?B?OFRoQWoyc3lDc09US3NuelQyckF1RlYzeXJkUzZ2UzlGSDBsbGRpdE5RbEk2?=
 =?utf-8?B?N1BWUXdUOExmVHBYdVV3VjNxR0d2Q3lRNU4vRHh4MWNKV3RUSDhPRUJ3V1ZJ?=
 =?utf-8?B?dm51UGNjUzh6YnRrMEJ3d1VFRXBTa3o5bUxaQmNJQlNOZmJ0dHJEd0pKQkhX?=
 =?utf-8?B?a1o4SWEvR2l0ZTBtayszTU1maUozZ2o5eU1BU2V4SFhOampWaU1Pa3FETzQv?=
 =?utf-8?B?NWp4WEowV01ZWmtqL1NkV0ZOZThwMzltcDcwdjhZQnRIWWxZZXRjTnFJTFl3?=
 =?utf-8?B?WVVjR2VXTGI1blYxOThZcE43b0pSL1dUM0wzWHpYZG9iT0JrL0VuRllyZUJl?=
 =?utf-8?B?ZGJSbFRFK1YrSVQ2aFFRUS8vNG5pUFJLdVV1ZjR3a1FFeXFkcTI4NzdnZFg2?=
 =?utf-8?B?Z3RrR1IrNElaQng2VzdvamRQSHV0ZWZEUWNCMEMrR1UzZ2c1SEU1Tm5VNXJZ?=
 =?utf-8?B?R3E0MVJVZjhBd3NkOFdEUGU4ampZTlpkZHhvU3V2clFoeFdTL3krWlo3OTN3?=
 =?utf-8?B?cUpUUitoMlBSV0RkZFZscnpJUWFwdU8vN1A0RW94NzF6dDZHSVBVTk5sMXRp?=
 =?utf-8?B?ZDFESDRqS2s3OU1mMkJ2dFFINXZ2STRUeHc3S1hldmNRNEJZOXhtV09tcmJw?=
 =?utf-8?B?YkRxTitsYWlVOHlrY04zb2ZhZVRsbTFTSSszU1RHWWU5Nm9pVG04anYzN1Jy?=
 =?utf-8?B?UTM0czVjSEYzY2pObldGbU1YdzZBeUZwRDk3TEtjbXZLMThmWnd1OUdmZkNX?=
 =?utf-8?B?WlFBWmFPYjZ6ZzlWbW9JVDcvL1JJaXBmalp3Z2hLUkxmUmc4WXdlYmFDU0xI?=
 =?utf-8?B?YjR5akthZkdvQVZCMkFiSGhJUDArTVQ0c040MnRmRWFUUks4WUw4VmJLS3lD?=
 =?utf-8?B?VVFKaGZSSVBoOWFRaktvKzdtQW1ueCsyMnFnQWM2VkxNdTZMeEp2SCsrUXdh?=
 =?utf-8?B?bTI1SGIxRGh6MHVPWFg1ZWFRZ3RqUG9CRTZwNmZVc1NMMC9URU56SHJrY1BW?=
 =?utf-8?B?c0o2YXZxb3NKR2RKQW15SkR3alVYUG15R3Z5T3hrM2JSM1B6aG5LejIrRVJX?=
 =?utf-8?B?cG5zRVVKRGFCSlFVWXNvWkF3eGgxSXprdzFXckNrQ0NZV2ZZUjBwZUJmNUF0?=
 =?utf-8?B?SktoNUJBeDFGNUlJYUxOZ3huejl2bDBORGdHWTU2SXFMMTVGaGd6RjI5WFZZ?=
 =?utf-8?B?MU5VcDdwTmVqTmFrYklibjVwcHM4MG55b2UzTWJWYUZmWUMzU3grOWlVQmdI?=
 =?utf-8?B?WUhFTnBRRUJ0V0cxRGdpZTZEeUVzZW5KeFFxRlpqTENFVGU0cVpOdjE4d0xh?=
 =?utf-8?B?WmFtZDNyZmFHbkpQY21YZ1I2VWt5QzhqUk5tL1NFZVI0dGF2RHRRNTdEZWdu?=
 =?utf-8?B?WUY5d2VFTDVxSlBaRnZBd00yVXZTcGx5cEhqbTB2Tmd4bUF6V1BTZ2hobHdY?=
 =?utf-8?B?dEx6emkrQnJwazBRR1VHbjZkcStVNTZKemljOGJscGU4UGRsbDhHa3VzTlpR?=
 =?utf-8?B?RTVHQk1JWFlNd1dSWE0yZ1ZlOXBKTk1ZSUdobGNBR0VEM04zWVdKUDlsRXhi?=
 =?utf-8?B?NUpHNVlpMDJUSHZZeGJVallTUzZWQ1FVMHB0KzdVc2ZnYXZyVXdoWGVvTW15?=
 =?utf-8?B?R0RoejgrZHVqamMwbmJEV0JwcG9iYW4wemthV2Yvb0FhUzdHeklQYmJyTzZE?=
 =?utf-8?B?b1M0OEZnNlorQU9CYWlMcmlMTHdGMjFpMm9MTVlGUS9oQmFiMm54dytDdTFD?=
 =?utf-8?B?bHpuSFpTeVF1MUJiaUx1Qkh4M2g5eTRQa3NYVmU2QW15MkREUEVsSUJVbUR5?=
 =?utf-8?B?MFpTc2owL0dxR1ovdzVFV2hWQXZlRTBoZS81NGhGWEtUZzJPeWdPNlVwS1dV?=
 =?utf-8?B?VlFVMnNmMFAwc0VxK0JkNk15WFdyRThXQkc0TjhpdHduQnFZUjZmaDVLVUJz?=
 =?utf-8?Q?bvrg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbb3188-624b-43bb-0a43-08db1a8a9456
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:24:30.1563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PamSl5CQrUzon0URC9FthA1SAb+ndt8S89vKr7flIZFDZG2r46cMA2I2YpXhDssD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
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


On 3/1/2023 12:54 PM, Felix Kuehling wrote:
> Am 2023-03-01 um 11:34 schrieb Xiaogang.Chen:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> svm_migrate_ram_to_vram migrates a prange from sys ram to vram. The 
>> prange may
>> cross multiple vma. Need remember current dst vram offset in the TTM 
>> resource for
>> each migration.
>>
>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>
> The patch looks good to me. Is this a typo in the title: "Cal vram 
> offset ..."? Should this be "Calculate vram offset ..."?
>
> For a shorter title I'd suggest: "Fix BO offset for multi-VMA page 
> migration".
>
ok.
> Is a similar fix needed for migration in the other direction, VRAM to 
> system memory?

 From vram to sys ram migration, vram is src and hmm collects vram pages 
by migrate_vma_setup. kfd gets each vram page addr by svm_migrate_addr 
from page. So addr is correspondent to each pages. I think it is ok.

Regards

Xiaogang

>
> Regards,
>   Felix
>
>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 ++++++++++-------
>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index 1c625433ff30..373cd7b0e1ca 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -294,7 +294,7 @@ static unsigned long 
>> svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
>>   static int
>>   svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct 
>> svm_range *prange,
>>                struct migrate_vma *migrate, struct dma_fence **mfence,
>> -             dma_addr_t *scratch)
>> +             dma_addr_t *scratch, uint64_t ttm_res_offset)
>>   {
>>       uint64_t npages = migrate->npages;
>>       struct device *dev = adev->dev;
>> @@ -304,8 +304,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>       uint64_t i, j;
>>       int r;
>>   -    pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, 
>> prange->start,
>> -         prange->last);
>> +    pr_debug("svms 0x%p [0x%lx 0x%lx 0x%lx]\n", prange->svms, 
>> prange->start,
>> +         prange->last, ttm_res_offset);
>>         src = scratch;
>>       dst = (uint64_t *)(scratch + npages);
>> @@ -316,7 +316,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>           goto out;
>>       }
>>   -    amdgpu_res_first(prange->ttm_res, prange->offset << PAGE_SHIFT,
>> +    amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>>                npages << PAGE_SHIFT, &cursor);
>>       for (i = j = 0; i < npages; i++) {
>>           struct page *spage;
>> @@ -403,7 +403,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>   static long
>>   svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct 
>> svm_range *prange,
>>               struct vm_area_struct *vma, uint64_t start,
>> -            uint64_t end, uint32_t trigger)
>> +            uint64_t end, uint32_t trigger, uint64_t ttm_res_offset)
>>   {
>>       struct kfd_process *p = container_of(prange->svms, struct 
>> kfd_process, svms);
>>       uint64_t npages = (end - start) >> PAGE_SHIFT;
>> @@ -456,7 +456,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>       else
>>           pr_debug("0x%lx pages migrated\n", cpages);
>>   -    r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, 
>> scratch);
>> +    r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, 
>> scratch, ttm_res_offset);
>>       migrate_vma_pages(&migrate);
>>         pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>> @@ -504,6 +504,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, 
>> uint32_t best_loc,
>>       unsigned long addr, start, end;
>>       struct vm_area_struct *vma;
>>       struct amdgpu_device *adev;
>> +    uint64_t ttm_res_offset;
>>       unsigned long cpages = 0;
>>       long r = 0;
>>   @@ -524,6 +525,7 @@ svm_migrate_ram_to_vram(struct svm_range 
>> *prange, uint32_t best_loc,
>>         start = prange->start << PAGE_SHIFT;
>>       end = (prange->last + 1) << PAGE_SHIFT;
>> +    ttm_res_offset = prange->offset << PAGE_SHIFT;
>>         for (addr = start; addr < end;) {
>>           unsigned long next;
>> @@ -533,13 +535,14 @@ svm_migrate_ram_to_vram(struct svm_range 
>> *prange, uint32_t best_loc,
>>               break;
>>             next = min(vma->vm_end, end);
>> -        r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, 
>> trigger);
>> +        r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, 
>> trigger, ttm_res_offset);
>>           if (r < 0) {
>>               pr_debug("failed %ld to migrate\n", r);
>>               break;
>>           } else {
>>               cpages += r;
>>           }
>> +        ttm_res_offset += next - addr;
>>           addr = next;
>>       }
