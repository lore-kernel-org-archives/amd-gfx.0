Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D440C83F14
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 20:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 531D210E5D2;
	Wed, 30 Aug 2023 20:56:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5AD10E5D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 20:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6e3gqNb2Wl5tiKSibVjEJrdWx+WKH72SDHl6hVLZXH4qLxRt02Ui9Xwzl6H9LUpsD/8BWBu/NjARnk3YeMzU0+xDJSmues+ZQMOj2NaePU18/wKXtTp1gUE8AhsIvjRZoWZCbmY2kjJnYAogBYtdumU3mFcBZlb370Fl131MXwVg9NOTuz6SNQ/r7U7WbKzaWT9vhImRZjb9ymJX/XFdRySbxuekRW4XmBgKXN0KhvE4gHbwP3uK1nYR2GTIpz3viu0EezRsunzjS+3wUJ0/iPJZayEnGKf7DIeKJGv/QJmPxU0vMmAnnjQwoz+iq5yzr6lgE7wfSK2wi01PyEsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgv13gSo2JOC6pv+VQrKq+Z8h17QSpCxvz8zexGxEpo=;
 b=XIhHkNVmU+sQIFonTeelpMgwkVVWNYJtrfU4IPiSlnNP0OaWPuyVT4nngJLwGlkhBy1mfzTTvgDY4M+R2z5R8YZvpEuOk//r/WloEUG0u4IYORNgA9IGxHUeL4B5JFjfvo+pUbbDHBkx4su1pRA7mCvaW0yfpFotu4Pi807QCWjcgsaNeOgqxKQQMXmNc+/oR7OU+RJLY1o5MH0u5Y4rMhCPCu/5ul5T6WBmeK4qfs1E/+xBoJm/y+7Pdtpm7tea5xGe6dKTym3Ah8t22LR8u8Esx8IU2ALwCSWRwh5+rRyrKJYTm/u6PSaD9FHNuFpq5wvZvB3pEEi0LEpnDgAlzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgv13gSo2JOC6pv+VQrKq+Z8h17QSpCxvz8zexGxEpo=;
 b=EdAbdnS2T5ZBM54WmQL1NubxzEvFJZXBDlw75HWFknc+r+rU10sbJKDEW/PU3bw9CY1IQdoYKmtJjAKJTYpwICObMhaMJI3HpZ9ZFndmd/d2q3i5Tc5MzoxcfjKiU1L0O4UrpqegyNdEYRoul8n2t4OorPTlo/kmA41k6aOhL38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 20:56:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 20:56:18 +0000
Message-ID: <fef7aadd-fb8f-f5c2-10e6-b5ebdcf4be56@amd.com>
Date: Wed, 30 Aug 2023 16:56:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: Use partial migrations in GPU page faults
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230824220834.362948-1-xiaogang.chen@amd.com>
 <d31985b2-74d9-2536-2995-7b693928d443@amd.com>
 <f744c06c-284f-de8b-8ed2-05d0512823a1@amd.com>
 <ed0dd323-bd99-d2f7-8cbf-6a92e5201f8e@amd.com>
 <8670e751-9a76-b9d9-47f6-05461c279f09@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <8670e751-9a76-b9d9-47f6-05461c279f09@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB5434:EE_
X-MS-Office365-Filtering-Correlation-Id: 06dc4c6c-1f65-46d1-764b-08dba99b8e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OU8FTu7nkGdzFiohwyHir2Dfk7KPsIK1V05DrLSEpNREbcQ15mKl0Ld5SNeFe5BJmQDglIbO4VLncs3x57osLlu/0ZPR6sH+nEQ/aAA7Le8qaMGmKEiX8OvXBDS1sp/0rCBeCDzzKEpQZgUbtoG+ITRgAOJl/qRn+RDlubazp+cj7wq3j7lZmm24jyo74ubBwAQ8dkfOE3Z6kv/C+OTPzFIAW/M34M2cwxHJY3xv1DVvr5wuCuopkXw4NxxUIZvrMqbgqswb0oA7uwNclKDQl3BcyXfktQ2+qqvk+bscB1cIIlMMah3Du/pQ0l3ODFciffZeA8j8gnLK7tV68CysOMbFexh5WTINiJ9a+yUhr5WpzV6bn6I+GKRyiDhUROx3UagTEr+6o4GwW0D4dwbHOy3ax33Mag9axSdxaeMHCJ/jEwBalC0iA+yFLgwr+AHcA4yAZgynMiSVI9IEX+z+E/c9tYdB8VGdORCzCHQ6wi8F7mWNW9p2pddY8mZnv+kRYPMGowG3bwxkbNFReVlTbxlc6x/f3Wt3umnzYGTOwyljo+2EPHIHTdEDtBXq2bSSXLRD4BMT/4mU0q+UJiZEr/ir2OvTWQXmJmOhZz/kxUjAfn/sB3EIPDbbsGe9KW0fu3cxfkyty7nxAl4UdB2rng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199024)(1800799009)(186009)(6512007)(38100700002)(316002)(41300700001)(4326008)(2906002)(2616005)(31696002)(30864003)(86362001)(36756003)(44832011)(8676002)(5660300002)(83380400001)(26005)(8936002)(6666004)(66476007)(6486002)(66946007)(66556008)(6506007)(36916002)(53546011)(478600001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGRPRHpWRm91MVowQkp5bnJ2SkRDejVLTGhOeDhRZE83K2wvTllvK0FKQzB2?=
 =?utf-8?B?NDBFZ1pTMjQ4KzFBb2xxM2dYUHdZSi82OTBrdndIMUFNSEtWVUxaWmxQVDRp?=
 =?utf-8?B?bFE2Vk5lYUwyZm5YamYvN3R3RlkzbmlrWmFVc01aWno3bHJRMTIvMXRmZjRT?=
 =?utf-8?B?d3Fud2J4R3V4VmVZTlYxNlFVamx6R3NyUnZPM3ZYMVJqNzRhSG8vdnluUGJD?=
 =?utf-8?B?b0pTMUpSVzlZQ3FFY2ZaMndDOUFtb2hOdUdSTFl3K25ZTW9pTHdqTzlQM2NY?=
 =?utf-8?B?Ykt0S3hZdXJ1bHFldnc2bnJuVVFoaVpkWk1RWjVTV0tnaC82b0hmVmZ2cFdD?=
 =?utf-8?B?QWZ5cllNVloxY2IxVGJudm1vU0l5MkF4aVhHdHBMMWNxRHN0ajRSRlVJSjU2?=
 =?utf-8?B?V3V6MHJGeFphNXhFbWdYSVh5UXRic0gwUGJIU0hQZWU1cnA1cklwRFFPUitw?=
 =?utf-8?B?OFVjUDROem1pYjBGZUc4MUFKa2FUWWdzTzhmdSt6MVV3eXozc1ZFSlBrVWVQ?=
 =?utf-8?B?czh1eUZtTGRkczR5TU1DZFVyc3RMU1VMNlZtREJrYzNjVDFHWVNpMGc2VkZP?=
 =?utf-8?B?ZDZ0MWFLSUZvTE51RjJQVkk2UlJEaS94amlHZ253NlR1ZTR3YWpTUVQvZHFq?=
 =?utf-8?B?US9HVjZnTUZXb2ZEdTlVZmdOYW9zTngwUERmNTBSbEErTUNVL3dRSTlpVzlp?=
 =?utf-8?B?cm5tU2o4NkpsOWdYWmg3V1hmMEpFOWNmWTNYNHVzYjZ6UThpR1RGMjNhb3hv?=
 =?utf-8?B?L2tzY242cGlENXFUVUdNRFRlQVN2cGJXUE8xZWcxOVFaK2pMcTJrT3Zoai8w?=
 =?utf-8?B?TlVlNXpQYURWK3FPRzM5dG1zN0IvK0J1dko1RmpPcGZndDZMRWJCTEJlcEZD?=
 =?utf-8?B?TzNuT3JNWVg4UXFjUDRxRUF4WjNscVpLcFRrcFhDenhkZ3kwRHpQMWFRMXVl?=
 =?utf-8?B?OU1SVzNwVnV0NWtTSlBlckMvajVzWVV1WmJ2amZBUW55VDJOVzArNWh5ek5n?=
 =?utf-8?B?d1JEVUg4Qnh5cXRvL0lxQ0ZWNGhsSDFGVkFLVWRZWU5McG1vNjlFQ3RqaFBM?=
 =?utf-8?B?S1ZOWjdIbDdBL3F5SWpzWDNuUm50dzFMUnJWd0JoWldXa1dpaGlleklLelhw?=
 =?utf-8?B?bmZxelREMUZzVjI3dFl6L2lHV1lzSnJ4TUQ1RlNZamRFVnFPR2pVbC9nelV2?=
 =?utf-8?B?emRHSTlwU2F1YWtyR3EyN3k1YlowUitWRTJxVzl6L0REczBZeDE1enZ0aHRl?=
 =?utf-8?B?N0JRU0Q2OEZPYm5VMURXUDZqNlRQdjBjMllXaWRIYWxEaFRFKzg0TUFock82?=
 =?utf-8?B?ZmNmMVowNjAxdjBRRHRnc21qMjA2ZkUvdjVvWkFHWDZDQW1QaERpeTBlN2RZ?=
 =?utf-8?B?NWwwTkFtM251M2MzU0Iwb1Z2ckhaYTBkVTNVU0Q5MWlVZGJlOG1HVHB1NE1q?=
 =?utf-8?B?WDlXVkpKeGZXbjM0cm9mczhWaFI2U3piWm1wY2E5UzdXTmJjSTVEL01Cc1No?=
 =?utf-8?B?ajVFTTVrSzNQeEZiVVRtOEkzRHRTaXc0R3h5SWswS1JOdmh1Q2lTYkk5K1dK?=
 =?utf-8?B?SEhpQWVrbDB6V1pVTHo5UWx3eXMyTGFWWU10a01meEp0TUpGK09SRmdUbDBF?=
 =?utf-8?B?UTFZMm5LVnIxczJaajNxYitYOTBwMDVWbG51amlxY095aXhQTE5sMWdnRGZR?=
 =?utf-8?B?WjlFVVFQMTlVZDlpVjV6N0tkQU9GWTJLa3ZLa3NRN25rbXpqRHoyVFNZanY2?=
 =?utf-8?B?QVUrdDVnM1lJMVB0UTREeEc3bXVtejkwOVNmSllnM1R3b3JKNlZvYXVZem8x?=
 =?utf-8?B?MVQ1OUloUWgvZnNhR1Y2UUVMUGVUOWcvOTNCc2wyTU5iSEZUR0JtVGQ1cENv?=
 =?utf-8?B?L1FPSkVaaDJvemNNcmllRHRRWHBUZXlvOUJxNWFvMTY2SDh1em5uV1psK0tS?=
 =?utf-8?B?b1RES2pkaEJTWHdaZndrUTlzd3lrMDZTMDlPTC93cy9TVWdacHZsbjd3UE9R?=
 =?utf-8?B?akpiV3VXbjdtZllndFMyc2NIbjVPczc1STk4elY5M2F5cHgzU0xMY1JRQVMv?=
 =?utf-8?B?V09nYi8vNk9xcUJSczNCeEwyZmtHcVlMbzkybXlEYUU1NUgvbGQ4NFNGRWd0?=
 =?utf-8?Q?0V2/vyTLtJyADqch2Mjb68Qzj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dc4c6c-1f65-46d1-764b-08dba99b8e8f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 20:56:18.1952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSdG2qkX9FN0w4yyiuTODWLKsWYRk8fzsCw6A7BlaohRp/r1BHiDyQ00QJV3d4ZzTTwi4pFnh50U4pE4/pEZxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434
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


On 2023-08-30 15:39, Chen, Xiaogang wrote:
>
> On 8/28/2023 5:37 PM, Felix Kuehling wrote:
>>
>> On 2023-08-28 16:57, Chen, Xiaogang wrote:
>>>
>>> On 8/28/2023 2:06 PM, Felix Kuehling wrote:
>>>>
>>>> On 2023-08-24 18:08, Xiaogang.Chen wrote:
>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>
>>>>> This patch implements partial migration in gpu page fault 
>>>>> according to migration
>>>>> granularity(default 2MB) and not split svm range in cpu page fault 
>>>>> handling.
>>>>> Now a svm range may have pages from both system ram and vram of 
>>>>> one gpu.
>>>>> These chagnes are expected to improve migration performance and 
>>>>> reduce
>>>>> mmu callback and TLB flush workloads.
>>>>>
>>>>> Signed-off-by: xiaogang chen <xiaogang.chen@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 153 
>>>>> +++++++++++++++--------
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |   6 +-
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  87 ++++++++-----
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   7 +-
>>>>>   4 files changed, 162 insertions(+), 91 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>> index 7d82c7da223a..5a3aa80a1834 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>> @@ -479,6 +479,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, 
>>>>> struct svm_range *prange,
>>>>>    * svm_migrate_ram_to_vram - migrate svm range from system to 
>>>>> device
>>>>>    * @prange: range structure
>>>>>    * @best_loc: the device to migrate to
>>>>> + * @start_mgr: start page to migrate
>>>>> + * @last_mgr: last page to migrate
>>>>>    * @mm: the process mm structure
>>>>>    * @trigger: reason of migration
>>>>>    *
>>>>> @@ -489,6 +491,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, 
>>>>> struct svm_range *prange,
>>>>>    */
>>>>>   static int
>>>>>   svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t 
>>>>> best_loc,
>>>>> +            unsigned long start_mgr, unsigned long last_mgr,
>>>>>               struct mm_struct *mm, uint32_t trigger)
>>>>>   {
>>>>>       unsigned long addr, start, end;
>>>>> @@ -498,9 +501,9 @@ svm_migrate_ram_to_vram(struct svm_range 
>>>>> *prange, uint32_t best_loc,
>>>>>       unsigned long cpages = 0;
>>>>>       long r = 0;
>>>>>   -    if (prange->actual_loc == best_loc) {
>>>>> -        pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 
>>>>> 0x%x\n",
>>>>> -             prange->svms, prange->start, prange->last, best_loc);
>>>>> +    if (!best_loc) {
>>>>> +        pr_debug("request svms 0x%p [0x%lx 0x%lx] migrate to sys 
>>>>> ram\n",
>>>>> +             prange->svms, start_mgr, last_mgr);
>>>>>           return 0;
>>>>>       }
>>>>>   @@ -513,8 +516,8 @@ svm_migrate_ram_to_vram(struct svm_range 
>>>>> *prange, uint32_t best_loc,
>>>>>       pr_debug("svms 0x%p [0x%lx 0x%lx] to gpu 0x%x\n", prange->svms,
>>>>>            prange->start, prange->last, best_loc);
>>>>>   -    start = prange->start << PAGE_SHIFT;
>>>>> -    end = (prange->last + 1) << PAGE_SHIFT;
>>>>> +    start = start_mgr << PAGE_SHIFT;
>>>>> +    end = (last_mgr + 1) << PAGE_SHIFT;
>>>>>         r = svm_range_vram_node_new(node, prange, true);
>>>>>       if (r) {
>>>>> @@ -544,10 +547,12 @@ svm_migrate_ram_to_vram(struct svm_range 
>>>>> *prange, uint32_t best_loc,
>>>>>         if (cpages) {
>>>>>           prange->actual_loc = best_loc;
>>>>> -        svm_range_free_dma_mappings(prange, true);
>>>>> -    } else {
>>>>> +        /* only free dma mapping in the migrated range */
>>>>> +        svm_range_free_dma_mappings(prange, true, start_mgr - 
>>>>> prange->start,
>>>>> +                         last_mgr - start_mgr + 1);
>>>>
>>>> This is wrong. If we only migrated some of the pages, we should not 
>>>> free the DMA mapping array at all. The array is needed as long as 
>>>> there are any valid DMA mappings in it.
>>>
>>> yes, I realized it after submit. I can not free DMA mapping array at 
>>> this stage.
>>>
>>> The concern(also related to comments below) is I do not know how 
>>> many pages in vram after partial migration. Originally I used bitmap 
>>> to record that.  I used bitmap to record which pages were migrated 
>>> at each migration functions. Here I do not need use hmm function to 
>>> get that info,  inside each migration function we can know which 
>>> pages got migrated, then update the bitmap accordingly inside each 
>>> migration function.
>>>
>>>>
>>>> I think the condition above with cpages should be updated. Instead 
>>>> of cpages, we need to keep track of a count of pages in VRAM in 
>>>> struct svm_range. See more below.
>>>>
>>> I think you want add a new integer in svm_range to remember how many 
>>> pages are in vram side for each svm_range, instead of bitmap. There 
>>> is a problem I saw: when we need split a prange(such as user uses 
>>> set_attr api) how do we know how many pages in vram for each 
>>> splitted prange?
>>
>> Right, that's a bit problematic. But it should be a relatively rare 
>> corner case. It may be good enough to make a "pessimistic" assumption 
>> when splitting ranges that have some pages in VRAM, that everything 
>> is in VRAM. And update that to 0 after migrate_to_ram for the entire 
>> range, to allow the BO reference to be released.
>>
> migrate_to_ram is partial migration too that only 2MB vram got 
> migrated. After split if we assume all pages are vram(pessimistic) we 
> will give the new vram pages number as all page number(in each spitted 
> prange). Then after 2MB vram migrated to ram, we still do not know if 
> we can release BO reference for this prange as we gave vram page 
> number in each spiltted prange(sub prange) more than it has.

Right. I think we still have cases where we migrate entire ranges to 
RAM, e.g. in svm_migrate_vram_to_vram. In those cases we could update 
the counter to 0 and drop the BO reference even after splitting a range.

Also, splitting ranges becomes more rare with your patch. The only 
remaining scenarios that would split ranges are partial munmap of a 
range, and changing attributes on partial ranges. If we want to update 
the counters accurately after splitting the ranges, we could just 
revalidate the entire ranges and update the counters in 
svm_validate_and_map based on the page addresses returned by 
hmm_range_fault. That avoids us having to track that information in our 
own bitmaps.


>
>> So in the worst case, you keep your DMA addresses and BOs allocated 
>> slightly longer than necessary. If that doesn't work, I agree that we 
>> need a bitmap with one bit per 4KB page. But I hope that can be avoided.
>>
>> That said, I'm not actually sure why we're freeing the DMA address 
>> array after migration to RAM at all. I think we still need it even 
>> when we're using VRAM. We call svm_range_dma_map in 
>> svm_range_validate_and_map regardless of whether the range is in VRAM 
>> or system memory. So it will just allocate a new array the next time 
>> the range is validated anyway. VRAM pages use a special address 
>> encoding to indicate VRAM pages to the GPUVM code.
>
> I think we do not need free DMA address array as you said, it is 
> another thing though.
>
> We need unmap dma address(dma_unmap_page) after migrate from ram to 
> vram because we always do dma_map_page at svm_range_validate_and_map. 
> If not we would have multiple dma maps for same sys ram page.

svm_range_dma_map_dev calls dma_unmap_page before overwriting an 
existing valid entry in the dma_addr array. Anyway, dma unmapping the 
old pages in bulk may still be cleaner. And it avoids delays in cleaning 
up DMA mappings after migrations.

Regards,
   Felix


> In partial migration(ram->vram) we can only unmap dma address for the 
> pages that got migrated.
>
> Overall it not seems that using an item in svm_range to record how 
> many vram page can solve spit prange case. Thought? or we talk offline.
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
>>>
>>>>> +    } else if (!prange->actual_loc)
>>>>> +        /* if all pages from prange are at sys ram */
>>>>>           svm_range_vram_node_free(prange);
>>>>> -    }
>>>>>         return r < 0 ? r : 0;
>>>>>   }
>>>>> @@ -762,6 +767,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>>>>> struct svm_range *prange,
>>>>>    * svm_migrate_vram_to_ram - migrate svm range from device to 
>>>>> system
>>>>>    * @prange: range structure
>>>>>    * @mm: process mm, use current->mm if NULL
>>>>> + * @start_mgr: start page need be migrated to sys ram
>>>>> + * @last_mgr: last page need be migrated to sys ram
>>>>>    * @trigger: reason of migration
>>>>>    * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is 
>>>>> CPU page fault callback
>>>>>    *
>>>>> @@ -771,7 +778,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>>>>> struct svm_range *prange,
>>>>>    * 0 - OK, otherwise error code
>>>>>    */
>>>>>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct 
>>>>> mm_struct *mm,
>>>>> -                uint32_t trigger, struct page *fault_page)
>>>>> +                    unsigned long start_mgr, unsigned long last_mgr,
>>>>> +                    uint32_t trigger, struct page *fault_page)
>>>>>   {
>>>>>       struct kfd_node *node;
>>>>>       struct vm_area_struct *vma;
>>>>> @@ -781,23 +789,30 @@ int svm_migrate_vram_to_ram(struct svm_range 
>>>>> *prange, struct mm_struct *mm,
>>>>>       unsigned long upages = 0;
>>>>>       long r = 0;
>>>>>   +    /* this pragne has no any vram page to migrate to sys ram */
>>>>>       if (!prange->actual_loc) {
>>>>>           pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
>>>>>                prange->start, prange->last);
>>>>>           return 0;
>>>>>       }
>>>>>   +    if (start_mgr < prange->start || last_mgr > prange->last) {
>>>>> +        pr_debug("migration range [0x%lx 0x%lx] out prange [0x%lx 
>>>>> 0x%lx]\n",
>>>>> +             start_mgr, last_mgr, prange->start, prange->last);
>>>>> +        return -EFAULT;
>>>>> +    }
>>>>> +
>>>>>       node = svm_range_get_node_by_id(prange, prange->actual_loc);
>>>>>       if (!node) {
>>>>>           pr_debug("failed to get kfd node by id 0x%x\n", 
>>>>> prange->actual_loc);
>>>>>           return -ENODEV;
>>>>>       }
>>>>>       pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x 
>>>>> to ram\n",
>>>>> -         prange->svms, prange, prange->start, prange->last,
>>>>> +         prange->svms, prange, start_mgr, last_mgr,
>>>>>            prange->actual_loc);
>>>>>   -    start = prange->start << PAGE_SHIFT;
>>>>> -    end = (prange->last + 1) << PAGE_SHIFT;
>>>>> +    start = start_mgr << PAGE_SHIFT;
>>>>> +    end = (last_mgr + 1) << PAGE_SHIFT;
>>>>>         for (addr = start; addr < end;) {
>>>>>           unsigned long next;
>>>>> @@ -822,8 +837,47 @@ int svm_migrate_vram_to_ram(struct svm_range 
>>>>> *prange, struct mm_struct *mm,
>>>>>       }
>>>>>         if (r >= 0 && !upages) {
>>>>> -        svm_range_vram_node_free(prange);
>>>>> -        prange->actual_loc = 0;
>>>>> +        /* all vram pages from prange got migrated to sys ram */
>>>>> +        if (start_mgr == prange->start && last_mgr == 
>>>>> prange->last) {
>>>>> +
>>>>> +            prange->actual_loc = 0;
>>>>> + spin_lock(&prange->svm_bo->list_lock);
>>>>> +            list_del_init(&prange->svm_bo_list);
>>>>> + spin_unlock(&prange->svm_bo->list_lock);
>>>>> +
>>>>> +            svm_range_vram_node_free(prange);
>>>>> +        } else {
>>>>> +
>>>>> +            /* cannot call svm_range_vram_node_free since only 
>>>>> part of its vram
>>>>> +             * pages got migrated. check if all vram pages from 
>>>>> all pranges
>>>>> +             * that shared this svm_bo have been released, then 
>>>>> unref
>>>>> +             * all svm_bo ref count.
>>>>
>>>> This feels wrong and I don't understand why it's necessary. The 
>>>> point of ref counting is, that you don't need to know what the 
>>>> other ranges are doing. Each range manages its own reference to the 
>>>> BO. When it no longer needs the BO, it drops its reference. When 
>>>> the ref count drops to 0, the BO gets freed.
>>>>
>>> As above: I did not know how many pages got migrated to sys ram in a 
>>> prange if not remember that. So I counter ref count of svm_bo after 
>>> each migration, when the counter reach to the prange(shared the 
>>> svm_bo)  number I release the svm_bo. It is how this awkward 
>>> checking came. Before I used bitmap in each prange to record that, 
>>> not need this kind checking. If use an integer for that I do not 
>>> know how to handle prange split?
>>>
>>>>
>>>>> +             */
>>>>> +            struct svm_range *tmp;
>>>>> +            unsigned int count = 0;
>>>>> +
>>>>> +            /* how many prangs refer to this svm_bo */
>>>>> + spin_lock(&prange->svm_bo->list_lock);
>>>>> +            list_for_each_entry(tmp, &prange->svm_bo->range_list, 
>>>>> svm_bo_list)
>>>>> +                count++;
>>>>> + spin_unlock(&prange->svm_bo->list_lock);
>>>>> +
>>>>> +            /* if svm_bo ref number is same as count above all 
>>>>> vram pages from
>>>>> +             * all pranges have been released, unref svm_bo count 
>>>>> times
>>>>> +             * from all pranges to force svm_bo released
>>>>
>>>> There is probably a possible race condition here if a range gets 
>>>> split concurrently. Or a page gets migrated between the ref count 
>>>> check and taking the list_lock.
>>>>
>>>> A better way to handle this would not need to look at the other 
>>>> ranges at all. What we really need to know is, how many pages of 
>>>> this range are currently in VRAM. We should be able to track this 
>>>> with a new counter in struct svm_range that gets incremented or 
>>>> decremented by cpages at the end of every migration.
>>>>
>>>>> +             */
>>>>> +            if (refcount_read(&prange->svm_bo->kref.refcount) == 
>>>>> count) {
>>>>> +
>>>>> + spin_lock(&prange->svm_bo->list_lock);
>>>>> +                list_for_each_entry(tmp, 
>>>>> &prange->svm_bo->range_list, svm_bo_list) {
>>>>> + spin_unlock(&prange->svm_bo->list_lock);
>>>>> +
>>>>> +                    svm_range_vram_node_free(tmp);
>>>>> + spin_lock(&prange->svm_bo->list_lock);
>>>>> +                }
>>>>> + spin_unlock(&prange->svm_bo->list_lock);
>>>>> +            }
>>>>> +        }
>>>>>       }
>>>>>         return r < 0 ? r : 0;
>>>>> @@ -833,17 +887,23 @@ int svm_migrate_vram_to_ram(struct svm_range 
>>>>> *prange, struct mm_struct *mm,
>>>>>    * svm_migrate_vram_to_vram - migrate svm range from device to 
>>>>> device
>>>>>    * @prange: range structure
>>>>>    * @best_loc: the device to migrate to
>>>>> + * @start: start page need be migrated to sys ram
>>>>> + * @last: last page need be migrated to sys ram
>>>>>    * @mm: process mm, use current->mm if NULL
>>>>>    * @trigger: reason of migration
>>>>>    *
>>>>>    * Context: Process context, caller hold mmap read lock, svms 
>>>>> lock, prange lock
>>>>>    *
>>>>> + * migrate all vram pages in prange to sys ram, then migrate 
>>>>> [start, last] pages
>>>>> + * from sys ram to gpu node best_loc.
>>>>> + *
>>>>>    * Return:
>>>>>    * 0 - OK, otherwise error code
>>>>>    */
>>>>>   static int
>>>>>   svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t 
>>>>> best_loc,
>>>>> -             struct mm_struct *mm, uint32_t trigger)
>>>>> +            unsigned long start, unsigned long last,
>>>>> +            struct mm_struct *mm, uint32_t trigger)
>>>>>   {
>>>>>       int r, retries = 3;
>>>>>   @@ -855,7 +915,8 @@ svm_migrate_vram_to_vram(struct svm_range 
>>>>> *prange, uint32_t best_loc,
>>>>>       pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, 
>>>>> best_loc);
>>>>>         do {
>>>>> -        r = svm_migrate_vram_to_ram(prange, mm, trigger, NULL);
>>>>> +        r = svm_migrate_vram_to_ram(prange, mm, prange->start, 
>>>>> prange->last,
>>>>> +                    trigger, NULL);
>>>>>           if (r)
>>>>>               return r;
>>>>>       } while (prange->actual_loc && --retries);
>>>>> @@ -863,18 +924,20 @@ svm_migrate_vram_to_vram(struct svm_range 
>>>>> *prange, uint32_t best_loc,
>>>>>       if (prange->actual_loc)
>>>>>           return -EDEADLK;
>>>>>   -    return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
>>>>> +    return svm_migrate_ram_to_vram(prange, best_loc, start, last, 
>>>>> mm, trigger);
>>>>>   }
>>>>>     int
>>>>>   svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
>>>>> -            struct mm_struct *mm, uint32_t trigger)
>>>>> +        unsigned long start, unsigned long last,
>>>>> +        struct mm_struct *mm, uint32_t trigger)
>>>>>   {
>>>>> -    if  (!prange->actual_loc)
>>>>> -        return svm_migrate_ram_to_vram(prange, best_loc, mm, 
>>>>> trigger);
>>>>> +    if  (!prange->actual_loc || prange->actual_loc == best_loc)
>>>>> +        return svm_migrate_ram_to_vram(prange, best_loc, start, 
>>>>> last,
>>>>> +                    mm, trigger);
>>>>>       else
>>>>> -        return svm_migrate_vram_to_vram(prange, best_loc, mm, 
>>>>> trigger);
>>>>> -
>>>>> +        return svm_migrate_vram_to_vram(prange, best_loc, start, 
>>>>> last,
>>>>> +                    mm, trigger);
>>>>>   }
>>>>>     /**
>>>>> @@ -889,10 +952,9 @@ svm_migrate_to_vram(struct svm_range *prange, 
>>>>> uint32_t best_loc,
>>>>>    */
>>>>>   static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>>>>>   {
>>>>> +    unsigned long start, last, size;
>>>>>       unsigned long addr = vmf->address;
>>>>>       struct svm_range_bo *svm_bo;
>>>>> -    enum svm_work_list_ops op;
>>>>> -    struct svm_range *parent;
>>>>>       struct svm_range *prange;
>>>>>       struct kfd_process *p;
>>>>>       struct mm_struct *mm;
>>>>> @@ -929,51 +991,34 @@ static vm_fault_t svm_migrate_to_ram(struct 
>>>>> vm_fault *vmf)
>>>>>         mutex_lock(&p->svms.lock);
>>>>>   -    prange = svm_range_from_addr(&p->svms, addr, &parent);
>>>>> +    prange = svm_range_from_addr(&p->svms, addr, NULL);
>>>>>       if (!prange) {
>>>>>           pr_debug("failed get range svms 0x%p addr 0x%lx\n", 
>>>>> &p->svms, addr);
>>>>>           r = -EFAULT;
>>>>>           goto out_unlock_svms;
>>>>>       }
>>>>>   -    mutex_lock(&parent->migrate_mutex);
>>>>> -    if (prange != parent)
>>>>> -        mutex_lock_nested(&prange->migrate_mutex, 1);
>>>>> +    mutex_lock(&prange->migrate_mutex);
>>>>>         if (!prange->actual_loc)
>>>>>           goto out_unlock_prange;
>>>>>   -    svm_range_lock(parent);
>>>>> -    if (prange != parent)
>>>>> -        mutex_lock_nested(&prange->lock, 1);
>>>>> -    r = svm_range_split_by_granularity(p, mm, addr, parent, prange);
>>>>> -    if (prange != parent)
>>>>> -        mutex_unlock(&prange->lock);
>>>>> -    svm_range_unlock(parent);
>>>>> -    if (r) {
>>>>> -        pr_debug("failed %d to split range by granularity\n", r);
>>>>> -        goto out_unlock_prange;
>>>>> -    }
>>>>> +    /* Align migration range start and size to granularity size */
>>>>> +    size = 1UL << prange->granularity;
>>>>> +    start = ALIGN_DOWN(addr, size);
>>>>> +    last = ALIGN(addr + 1, size) - 1;
>>>>> +
>>>>> +    start = (start >= prange->start) ? start : prange->start;
>>>>> +    last = (last <= prange->last) ? last : prange->last;
>>>>>   -    r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm,
>>>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
>>>>> -                    vmf->page);
>>>>> +    r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm, start, 
>>>>> last,
>>>>> +                KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page);
>>>>>       if (r)
>>>>>           pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 
>>>>> 0x%lx]\n",
>>>>> -             r, prange->svms, prange, prange->start, prange->last);
>>>>> -
>>>>> -    /* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
>>>>> -    if (p->xnack_enabled && parent == prange)
>>>>> -        op = SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP;
>>>>> -    else
>>>>> -        op = SVM_OP_UPDATE_RANGE_NOTIFIER;
>>>>> -    svm_range_add_list_work(&p->svms, parent, mm, op);
>>>>> -    schedule_deferred_list_work(&p->svms);
>>>>> +             r, prange->svms, prange, start, last);
>>>>>     out_unlock_prange:
>>>>> -    if (prange != parent)
>>>>> -        mutex_unlock(&prange->migrate_mutex);
>>>>> -    mutex_unlock(&parent->migrate_mutex);
>>>>> +    mutex_unlock(&prange->migrate_mutex);
>>>>>   out_unlock_svms:
>>>>>       mutex_unlock(&p->svms.lock);
>>>>>   out_unref_process:
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>>>>> index 487f26368164..9e48d10e848e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>>>>> @@ -41,9 +41,13 @@ enum MIGRATION_COPY_DIR {
>>>>>   };
>>>>>     int svm_migrate_to_vram(struct svm_range *prange, uint32_t 
>>>>> best_loc,
>>>>> +            unsigned long start, unsigned long last,
>>>>>               struct mm_struct *mm, uint32_t trigger);
>>>>> +
>>>>>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct 
>>>>> mm_struct *mm,
>>>>> -                uint32_t trigger, struct page *fault_page);
>>>>> +            unsigned long start, unsigned long last,
>>>>> +            uint32_t trigger, struct page *fault_page);
>>>>> +
>>>>>   unsigned long
>>>>>   svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned 
>>>>> long addr);
>>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> index 841ba6102bbb..012dceb7c0ed 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> @@ -247,7 +247,8 @@ void svm_range_dma_unmap(struct device *dev, 
>>>>> dma_addr_t *dma_addr,
>>>>>       }
>>>>>   }
>>>>>   -void svm_range_free_dma_mappings(struct svm_range *prange, bool 
>>>>> unmap_dma)
>>>>> +void svm_range_free_dma_mappings(struct svm_range *prange, bool 
>>>>> unmap_dma,
>>>>> +                unsigned long offset, unsigned long npages)
>>>>>   {
>>>>>       struct kfd_process_device *pdd;
>>>>>       dma_addr_t *dma_addr;
>>>>> @@ -269,7 +270,7 @@ void svm_range_free_dma_mappings(struct 
>>>>> svm_range *prange, bool unmap_dma)
>>>>>           }
>>>>>           dev = &pdd->dev->adev->pdev->dev;
>>>>>           if (unmap_dma)
>>>>> -            svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
>>>>> +            svm_range_dma_unmap(dev, dma_addr, offset, npages);
>>>>>           kvfree(dma_addr);
>>>>
>>>> This doesn't make sense. If we only unmapped some of the DMA 
>>>> mappings, we should not free the DMA mapping array at all, because 
>>>> that would mean leaking all the DMA mappings we did not unmap.
>>> right, I realized that after submit. It is also related to able 
>>> knowing if all pages are migrated to vram.
>>>>
>>>>> prange->dma_addr[gpuidx] = NULL;
>>>>>       }
>>>>> @@ -284,7 +285,7 @@ static void svm_range_free(struct svm_range 
>>>>> *prange, bool do_unmap)
>>>>>            prange->start, prange->last);
>>>>>         svm_range_vram_node_free(prange);
>>>>> -    svm_range_free_dma_mappings(prange, do_unmap);
>>>>> +    svm_range_free_dma_mappings(prange, do_unmap, 0, 
>>>>> prange->npages);
>>>>>         if (do_unmap && !p->xnack_enabled) {
>>>>>           pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, 
>>>>> size);
>>>>> @@ -384,6 +385,8 @@ static void svm_range_bo_release(struct kref 
>>>>> *kref)
>>>>>                prange->start, prange->last);
>>>>>           mutex_lock(&prange->lock);
>>>>>           prange->svm_bo = NULL;
>>>>> +        /* prange dose not hold vram page now */
>>>>> +        prange->actual_loc = 0;
>>>>
>>>> This is probably the wrong place to do this. The caller of 
>>>> svm_range_bo_release should probably update prange->actual_loc 
>>>> before calling this function.
>>>>
>>>>
>>>>> mutex_unlock(&prange->lock);
>>>>>             spin_lock(&svm_bo->list_lock);
>>>>> @@ -439,7 +442,8 @@ svm_range_validate_svm_bo(struct kfd_node 
>>>>> *node, struct svm_range *prange)
>>>>>           mutex_unlock(&prange->lock);
>>>>>           return false;
>>>>>       }
>>>>> -    if (prange->ttm_res) {
>>>>> +    /* requeset from same kfd_node and we still have reference to 
>>>>> it */
>>>>> +    if (prange->ttm_res && prange->svm_bo->node == node) {
>>>>>           /* We still have a reference, all is well */
>>>>>           mutex_unlock(&prange->lock);
>>>>>           return true;
>>>>> @@ -458,6 +462,8 @@ svm_range_validate_svm_bo(struct kfd_node 
>>>>> *node, struct svm_range *prange)
>>>>> spin_unlock(&prange->svm_bo->list_lock);
>>>>>                 svm_range_bo_unref(prange->svm_bo);
>>>>> +            prange->ttm_res = NULL;
>>>>> +            prange->svm_bo = NULL;
>>>>
>>>> If this is really necessary, it should probably be done inside the 
>>>> prange->lock.
>>>>
>>>>
>>>>>               return false;
>>>>>           }
>>>>>           if (READ_ONCE(prange->svm_bo->evicting)) {
>>>>> @@ -2888,6 +2894,7 @@ svm_range_restore_pages(struct amdgpu_device 
>>>>> *adev, unsigned int pasid,
>>>>>               uint32_t vmid, uint32_t node_id,
>>>>>               uint64_t addr, bool write_fault)
>>>>>   {
>>>>> +    unsigned long start, last, size;
>>>>>       struct mm_struct *mm = NULL;
>>>>>       struct svm_range_list *svms;
>>>>>       struct svm_range *prange;
>>>>> @@ -3023,34 +3030,38 @@ svm_range_restore_pages(struct 
>>>>> amdgpu_device *adev, unsigned int pasid,
>>>>>       kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>>>>>                          write_fault, timestamp);
>>>>>   -    if (prange->actual_loc != best_loc) {
>>>>> -        migration = true;
>>>>> -        if (best_loc) {
>>>>> -            r = svm_migrate_to_vram(prange, best_loc, mm,
>>>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>>>> -            if (r) {
>>>>> -                pr_debug("svm_migrate_to_vram failed (%d) at 
>>>>> %llx, falling back to system memory\n",
>>>>> -                     r, addr);
>>>>> -                /* Fallback to system memory if migration to
>>>>> -                 * VRAM failed
>>>>> -                 */
>>>>> -                if (prange->actual_loc)
>>>>> -                    r = svm_migrate_vram_to_ram(prange, mm,
>>>>> -                       KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>>>>> -                       NULL);
>>>>> -                else
>>>>> -                    r = 0;
>>>>> -            }
>>>>> -        } else {
>>>>> -            r = svm_migrate_vram_to_ram(prange, mm,
>>>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>>>>> -                    NULL);
>>>>> -        }
>>>>> +    /* Align migration range start and size to granularity size */
>>>>> +    size = 1UL << prange->granularity;
>>>>> +    start = ALIGN_DOWN(addr, size);
>>>>> +    last = ALIGN(addr + 1, size) - 1;
>>>>> +
>>>>> +    start = (start >= prange->start) ? start : prange->start;
>>>>> +    last = (last <= prange->last) ? last : prange->last;
>>>>
>>>> This could be written more compact:
>>>>
>>>>     start = max(prange->start, ALIGN_DOWN(addr, size));
>>>>     last = min(prange->last, ALIGN(addr + 1, size) - 1);
>>>>
>>>>
>>>>> +
>>>>> +    migration = true;
>>>>
>>>> If you make this always true, we don't need this variable any more. 
>>>> But see below ...
>>>>
>>>>
>>>>> +    if (best_loc) {
>>>>> +        r = svm_migrate_to_vram(prange, best_loc, start, last,
>>>>> +                        mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>>>
>>>> Maybe we can add an output parameter to svm_migrate_... to return 
>>>> whether an actual migration was performed (based on cpages). That 
>>>> could be used to update the migration variable more accurately.
>>>>
>>>>
>>>>>           if (r) {
>>>>> -            pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
>>>>> -                 r, svms, prange->start, prange->last);
>>>>> -            goto out_unlock_range;
>>>>> +            pr_debug("svm_migrate_to_vram failed (%d) at %llx, 
>>>>> falling back to system memory\n",
>>>>> +                     r, addr);
>>>>> +            /* Fallback to system memory if migration to
>>>>> +             * VRAM failed
>>>>> +             */
>>>>> +            if (prange->actual_loc)
>>>>> +                r = svm_migrate_vram_to_ram(prange, mm, start, last,
>>>>> + KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>>>> +            else
>>>>> +                r = 0;
>>>>>           }
>>>>> +    } else {
>>>>> +        r = svm_migrate_vram_to_ram(prange, mm, start, last,
>>>>> +                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>>>
>>>> This is only necessary if prange->actual_loc is non-0. And again, 
>>>> this could update migration with an output parameter based on cpages.
>>>>
>>>>
>>>>> +    }
>>>>> +    if (r) {
>>>>> +        pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
>>>>> +                 r, svms, start, last);
>>>>> +        goto out_unlock_range;
>>>>>       }
>>>>>         r = svm_range_validate_and_map(mm, prange, gpuidx, false, 
>>>>> false, false);
>>>>> @@ -3402,18 +3413,22 @@ svm_range_trigger_migration(struct 
>>>>> mm_struct *mm, struct svm_range *prange,
>>>>>       *migrated = false;
>>>>>       best_loc = svm_range_best_prefetch_location(prange);
>>>>>   -    if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
>>>>> -        best_loc == prange->actual_loc)
>>>>> +    /* when best_loc is a gpu node and same as prange->actual_loc
>>>>> +     * we still need migrate as prange->actual_loc does not mean all
>>>>> +     * pages in prange are vram. hmm migrate will pick up right 
>>>>> pages.
>>>>> +     */
>>>>> +    if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED)
>>>>>           return 0;
>>>>>         if (!best_loc) {
>>>>> -        r = svm_migrate_vram_to_ram(prange, mm,
>>>>> +        r = svm_migrate_vram_to_ram(prange, mm, prange->start, 
>>>>> prange->last,
>>>>>                       KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>>>>>           *migrated = !r;
>>>>
>>>> This could also use an output parameter from 
>>>> svm_migrate_vram_to_ram to update migrated more accurately.
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>> I think the main issue here is to know how many pages are from vram 
>>> for a prange. If use an integer to record how we handle prange split 
>>> case?
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>>
>>>>>           return r;
>>>>>       }
>>>>>   -    r = svm_migrate_to_vram(prange, best_loc, mm, 
>>>>> KFD_MIGRATE_TRIGGER_PREFETCH);
>>>>> +    r = svm_migrate_to_vram(prange, best_loc, prange->start, 
>>>>> prange->last,
>>>>> +                    mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>>>>>       *migrated = !r;
>>>>>         return r;
>>>>> @@ -3468,7 +3483,11 @@ static void 
>>>>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>>>>             mutex_lock(&prange->migrate_mutex);
>>>>>           do {
>>>>> +            /* migrate all vram pages in this prange to sys ram
>>>>> +             * after that prange->actual_loc should be zero
>>>>> +             */
>>>>>               r = svm_migrate_vram_to_ram(prange, mm,
>>>>> +                    prange->start, prange->last,
>>>>>                       KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
>>>>>           } while (!r && prange->actual_loc && --retries);
>>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>>> index 9e668eeefb32..c565e018cfb3 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>>> @@ -88,7 +88,9 @@ struct svm_work_list_item {
>>>>>    * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
>>>>>    * @perferred_loc: perferred location, 0 for CPU, or GPU id
>>>>>    * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
>>>>> - * @actual_loc: the actual location, 0 for CPU, or GPU id
>>>>> + * @actual_loc: this svm_range location. 0: all pages are from 
>>>>> sys ram;
>>>>> + *              GPU id: this svm_range may include vram pages 
>>>>> from GPU with
>>>>> + *              id actual_loc.
>>>>>    * @granularity:migration granularity, log2 num pages
>>>>>    * @invalid:    not 0 means cpu page table is invalidated
>>>>>    * @validate_timestamp: system timestamp when range is validated
>>>>> @@ -183,7 +185,8 @@ void svm_range_add_list_work(struct 
>>>>> svm_range_list *svms,
>>>>>   void schedule_deferred_list_work(struct svm_range_list *svms);
>>>>>   void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>>>>>                unsigned long offset, unsigned long npages);
>>>>> -void svm_range_free_dma_mappings(struct svm_range *prange, bool 
>>>>> unmap_dma);
>>>>> +void svm_range_free_dma_mappings(struct svm_range *prange, bool 
>>>>> unmap_dma,
>>>>> +             unsigned long offset, unsigned long npages);
>>>>>   int svm_range_get_info(struct kfd_process *p, uint32_t 
>>>>> *num_svm_ranges,
>>>>>                  uint64_t *svm_priv_data_size);
>>>>>   int kfd_criu_checkpoint_svm(struct kfd_process *p,
