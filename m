Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57843E728CF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 18:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB1C10E19E;
	Fri, 29 Sep 2023 18:25:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D52410E19E
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 18:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BO3Up/yXfB1DdRgmGysgJwNIQw0spQ1XdJwh4vekqW0P7+vhjTm2rmxUoUoQAJ2IEyZHV5FT46XP8gL0dEIX9KqCuD+pRfMZJ/5GGaWfNuNdYkSffLug4YTqRgHs8ofJ1LtkEdoR9H66t5rT7IT6Smpa30getappzxq6qhYj6Gh+QiT7ADUydn4w5Pefp73dLa2liMMR9RwNA4zNGLEAcs14BKNZvwHlNlA+7HG7sKyPAHV6ySQb05h2IebvA036uK5UwsvYlUok4xpX4sXzW5h6eFq2WM0fX4WwtV2gKwOll+/rzOXg4sHuTTUKqAJ+FilmeO7xKIfgoUUAQN0+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVgnqysb1vFErmPjky+I+c9I5d6dzGzdrB6yNvma0zo=;
 b=Fj9ZEPH96blTmquG05Axcsq0SNism74CIwtBCpUtgQP9awQP6I9U/xHT+WzbYmxxjc+kM6GY1WqwSHSk2RSCKDrxzGkAEuRUIriSYm3e1hbCEmphenq/pDL9wMhhm9cyEqgOZ47M6QQE4LuMpczC+Al4S+WD1pSsgmIs8dgRWqTC3625+qKQZt93n91pm2qpSa9yjGV3LC6NFf/b9fhq2t82unel8AytXqyn9T6WrZiyi78QaGHef+lI30ExAW6fILr+0GvIoWjxd1+fjUpwA+GSAeGFHoOfFyYmSqCGX1L9dJhj85zGHylcjbQH1wpSreSdsmsmM+aHEbtEWGIePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVgnqysb1vFErmPjky+I+c9I5d6dzGzdrB6yNvma0zo=;
 b=p0bV14ynTG0VPjyIq+JFfjJQvY/TCZOwON/4fe+xL+C7LKA+Oav/yqWIEaCaNhcazJooP2b18J5XvenxOS+hDKVn5BRxHVWvNWBU40YZxhru68WR0Dd9vm/BRjX+LHW5tF/XLTDTOLsN0MJ6aYpezXxNRyLhgkWZTmCkwtO7VZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 29 Sep
 2023 18:25:47 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f%7]) with mapi id 15.20.6838.016; Fri, 29 Sep 2023
 18:25:47 +0000
Message-ID: <7ab40093-5e86-796d-eee8-c6172b41ef47@amd.com>
Date: Fri, 29 Sep 2023 13:25:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] drm/amdkfd: Use partial migrations in GPU page faults
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230920173203.12760-1-xiaogang.chen@amd.com>
 <cdbc2263-d6c7-ab0a-0bf2-3361dd34a358@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <cdbc2263-d6c7-ab0a-0bf2-3361dd34a358@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:806:122::6) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|SJ1PR12MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 032299b7-a674-4b0d-1efc-08dbc119802b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNke/mnN81TlN3/WCBBxpLY4zdelVo714D/zGQeWG/EfCrantnU9v4mevqaZIe378987SvPPucGYBmafRr4jVuKLiZAz+5ggpZLuM6qxKMuWkHeCEsZrMS2dlryoshb8ZDq44I1VYxBCGZ2SzHKgj2n0spSdHk9clcj0fwNYEf6Ucg8kuns3avDa1vZkGweKY6ddti05oh2EMtVSdHPaTuRP58ArvU62My8on59KCqPyN0UC6u58Y3W1042cdhsuhckEbVD7TT7/vk613HJgEXvDASjHBOrMmjlIVX+B4ijA1hP+IX31z8NhaSZJnMooKXqXLIm8OFyWEwLRM0aCFx4yTDeJC9TSKxmdtsbaNk3hTBHXmiPgamllInsmvXZLp3ZTQ3MsabU66G/JuHjfWnFCxJeXwRw5sKjTXMfyKH/MW2sRaBUhyQl0p1dOhzai1HXiyDHVF+CW8dgT0OJnMkjjIY2QtvjAJFrJLZER+ys9oflYqZ6QbV3V4MZ+ldcCQx0cTlv22IB98VzoWvP8LWVcoJK0sPW/eQ3XG1fngwn/1NtRe9aUdAb0YNtmRbmr3UVIISn0Y/AQexUmnKPDTevxLpyiG7uxLiLJ2tkKn3s/KWCH0y2ONHzhyeP92SrE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(6486002)(53546011)(6506007)(6666004)(26005)(2616005)(41300700001)(316002)(66476007)(66556008)(30864003)(2906002)(66946007)(38100700002)(8676002)(86362001)(31686004)(31696002)(4326008)(5660300002)(8936002)(36756003)(478600001)(966005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1ZocXVRdFhneXRZdndoYVNSMllNZ1BhL0FtRm5VY1VOZ2ZHOTJSMVlnNm4w?=
 =?utf-8?B?czR0b2tMUHFMSHBRcmRyUlAxelZBT3FWcXIyM1c1aHkzMHAzLzJCOTVIaXZY?=
 =?utf-8?B?K24wcCtVa2lmdDVpTnVGWG1Kb3ZoRXl6TE84NHIrU1paVkNncFUzQlZjTmFv?=
 =?utf-8?B?UHZvNEZLa2FGOERIWi9JMTdOQlZtNVY2UHZkQkdqd0VLaFB0SmFqV0t2MEhI?=
 =?utf-8?B?RW44OEh2aFNScEE4aTRlR3NmWTZkSjNmaDdCZ2pJcCswb3ZmRk1rcXpRNnh5?=
 =?utf-8?B?K2ptRXBmOXFHMDEwa0t4TDZUcFgzK1pCRk9TZ0U5c2Zwb3ZKSk9JcWxqMVdu?=
 =?utf-8?B?Q3Y5MDhNNlJYUzdSS1Bjc2NBR2s1dWZzeHkxNmpkckpVbVcyUkVVQnp4dUMr?=
 =?utf-8?B?U0tFUENmNFhtVm1UZmQ2VGE0dEhURjArZlRTUmg0MzVpcTloZEJSSUF5bndl?=
 =?utf-8?B?Q2tickYrUXpncEpjeXdNYVZnaGt2bUkxbkJ6T2NwRC90NUdTeGRSemVMRlF1?=
 =?utf-8?B?L0N5UnNFdnZyOVk5UWpmdW9McFBBWlVFcWk3bUs4N2gzMmpvWSs3cGcySUI3?=
 =?utf-8?B?TVJlUWEyaHRObzljWkd6eFR1d3Ntdk1wVE9Pak0zL0dzelllSTJYVmxGSmYv?=
 =?utf-8?B?TzJlWHhlNTB5c1Ftd3Y5Z1ZZWDEzYklFTEt2MjFDZVpEWGhJc0o4b2lyRWFy?=
 =?utf-8?B?bnZ1NndaclR6SDZlUUFNYWsxSkU4Y29qcjdlcTVvYXRBVnR5UGxZS1l3Ritj?=
 =?utf-8?B?NFRpcUIxZGZlMjdOMHZiQzMxcUU0VU9KeVB3RGJRKzZucmI3emNvbCtYWkd6?=
 =?utf-8?B?djIwRXR5S0MzajlBUFdJdWU0K0dWYlJodlROeWd5aTRab0F6WnFVdVZWRUtS?=
 =?utf-8?B?cjl4VkordGUzV1hwajRkSUErVXVRN2ZtenIyNm9mSVQ5cFBxdWZyWFdhazN6?=
 =?utf-8?B?WENvQ25hQWJjKzJFWm1hQmJsbWMwOUZySlRkSWIvRDhpOGo0M3RTdEh5SGEr?=
 =?utf-8?B?ZG1iZlFFMFcxaEUzRkltRHY2VUFxWFdWL05INjBUM2dkaWdFbmtteDlIY3B3?=
 =?utf-8?B?c2dhcHNoTmxhVUhwNm0zaTJOWE9HK0I3ZzZkUFJUZUcvM1RNUndtVnlNbzNl?=
 =?utf-8?B?cENQa3IzT2xUV0I5ODlIMkYyZWQrenRWUGZXMUhMNEtLSnN1My91emJtRWVt?=
 =?utf-8?B?UjRENzF1bXRJSTdodnU0OUFzS0FBSTBJRFYrWENIcklJRkxUWFBlZEp6cFJD?=
 =?utf-8?B?MEhLRisyNnBORjRQOElscUJoY2FIZVlVK2tOakZYeGhTRVVtV1prRHF5N0xL?=
 =?utf-8?B?MVcwZExGbERXVWp1dXd0aiszRjc2TmhzSHE3VWZxTHE2U0lBcis2MWxaN0Z6?=
 =?utf-8?B?YlBFK2NmZHlBa3pNOFpQV2YxblJHYys4b1Q3RnYwbGs5OHhuQjdoUjNrZDhU?=
 =?utf-8?B?VkxCbEtsNC9Qc09TQXgwWTFpR1pJaStyRHI3VkFIa1QzOExFSERFdWNnNDBE?=
 =?utf-8?B?VzF6aFEzTXBNUVE2aXUvQVBPYjNDN2JyaS8vQzExN0NBakpCK1BjSEx5N3Ix?=
 =?utf-8?B?NzRDT0tSVWRHRVhidTdhRnQ1TFBZZVJlTXRXZHdKUlFQZmhkMkpGeVNTdDBk?=
 =?utf-8?B?S0grZ01oZXkxdHM2VENjZno1OG9jWXV6V3EyMnZMTXE4SXlvWWxoaDI1MG9t?=
 =?utf-8?B?Nm81LzRsakNLK01iempYMng0TUdydVFvUG1oNUtDZCtwQi9SVmFGSGY0YUdD?=
 =?utf-8?B?ZVh0WXhDQ0ZDSlhSa1pHelBEcjg5NGRsK0Zxamt5QWhwMVdBcWY3ZW43VytQ?=
 =?utf-8?B?Tk1QRkc0MC80Vm1JUXhxUWs5bklCNzM2cm9NSEMwOWJ6ZW13eUJIUWxXMDEz?=
 =?utf-8?B?cWIrclRMbzdrVXpUMDVnZXI0djBva1p5N3g1aEk1SWNOR3BvbE5HS2tMRE5u?=
 =?utf-8?B?Vmg3NDE4cG1ZbjlpTHd5cUZSc08wWlhJYUNvOVppeENwQnZYdmdtUHdNb2Yr?=
 =?utf-8?B?Z2hZRlc0Y1hqdzU5SCtlUDVYZzBNY3N2bWY5akdtOU5zaG1MZ1J5UHRNRmJu?=
 =?utf-8?B?d0h4ZDVMK1Y1SkRXbFNkZTZja2xkRHhQclZhY0ZHQ1NFZnkwMnBJTTNNekFT?=
 =?utf-8?Q?2Xzg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032299b7-a674-4b0d-1efc-08dbc119802b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:25:47.3628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hv9NxXJtxnpIT7mrhnoNMDXHkwyx2lX3A3FMsvYk7ivEOZgeEc30JviSCoQQyuo3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194
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


On 9/28/2023 4:26 PM, Felix Kuehling wrote:
> On 2023-09-20 13:32, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> This patch implements partial migration in gpu page fault according 
>> to migration
>> granularity(default 2MB) and not split svm range in cpu page fault 
>> handling.
>> A svm range may include pages from both system ram and vram of one 
>> gpu now.
>> These chagnes are expected to improve migration performance and 
>> reduce mmu
>> callback and TLB flush workloads.
>>
>> Signed-off-by: xiaogang chen<xiaogang.chen@amd.com>
>
> Some more nit-picks inline.
>
>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 156 +++++++++++++----------
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |   6 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 104 +++++++++++----
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   6 +-
>>   4 files changed, 178 insertions(+), 94 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index 6c25dab051d5..e886f9ce40ac 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -442,10 +442,10 @@ svm_migrate_vma_to_vram(struct kfd_node *node, 
>> struct svm_range *prange,
>>           goto out_free;
>>       }
>>       if (cpages != npages)
>> -        pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
>> +        pr_debug("partial migration, 0x%lx/0x%llx pages collected\n",
>>                cpages, npages);
>>       else
>> -        pr_debug("0x%lx pages migrated\n", cpages);
>> +        pr_debug("0x%lx pages collected\n", cpages);
>>         r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, 
>> scratch, ttm_res_offset);
>>       migrate_vma_pages(&migrate);
>> @@ -479,6 +479,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, 
>> struct svm_range *prange,
>>    * svm_migrate_ram_to_vram - migrate svm range from system to device
>>    * @prange: range structure
>>    * @best_loc: the device to migrate to
>> + * @start_mgr: start page to migrate
>> + * @last_mgr: last page to migrate
>>    * @mm: the process mm structure
>>    * @trigger: reason of migration
>>    *
>> @@ -489,6 +491,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, 
>> struct svm_range *prange,
>>    */
>>   static int
>>   svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>> +            unsigned long start_mgr, unsigned long last_mgr,
>>               struct mm_struct *mm, uint32_t trigger)
>>   {
>>       unsigned long addr, start, end;
>> @@ -498,23 +501,30 @@ svm_migrate_ram_to_vram(struct svm_range 
>> *prange, uint32_t best_loc,
>>       unsigned long cpages = 0;
>>       long r = 0;
>>   -    if (prange->actual_loc == best_loc) {
>> -        pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
>> -             prange->svms, prange->start, prange->last, best_loc);
>> +    if (!best_loc) {
>> +        pr_debug("svms 0x%p [0x%lx 0x%lx] migrate to sys ram\n",
>> +            prange->svms, start_mgr, last_mgr);
>>           return 0;
>>       }
>>   +    if (start_mgr < prange->start || last_mgr > prange->last) {
>> +        pr_debug("range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
>> +                 start_mgr, last_mgr, prange->start, prange->last);
>> +        return -EFAULT;
>> +    }
>> +
>>       node = svm_range_get_node_by_id(prange, best_loc);
>>       if (!node) {
>>           pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
>>           return -ENODEV;
>>       }
>>   -    pr_debug("svms 0x%p [0x%lx 0x%lx] to gpu 0x%x\n", prange->svms,
>> -         prange->start, prange->last, best_loc);
>> +    pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
>> +        prange->svms, start_mgr, last_mgr, prange->start, prange->last,
>> +        best_loc);
>>   -    start = prange->start << PAGE_SHIFT;
>> -    end = (prange->last + 1) << PAGE_SHIFT;
>> +    start = start_mgr << PAGE_SHIFT;
>> +    end = (last_mgr + 1) << PAGE_SHIFT;
>>         r = svm_range_vram_node_new(node, prange, true);
>>       if (r) {
>> @@ -544,8 +554,11 @@ svm_migrate_ram_to_vram(struct svm_range 
>> *prange, uint32_t best_loc,
>>         if (cpages) {
>>           prange->actual_loc = best_loc;
>> -        svm_range_dma_unmap(prange);
>> -    } else {
>> +        prange->vram_pages = prange->vram_pages + cpages;
>> +    } else if (!prange->actual_loc) {
>> +        /* if no page migrated and all pages from prange are at
>> +         * sys ram drop svm_bo got from svm_range_vram_node_new
>> +         */
>>           svm_range_vram_node_free(prange);
>>       }
>>   @@ -663,19 +676,19 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>    * Context: Process context, caller hold mmap read lock, 
>> prange->migrate_mutex
>>    *
>>    * Return:
>> - *   0 - success with all pages migrated
>>    *   negative values - indicate error
>> - *   positive values - partial migration, number of pages not migrated
>> + *   positive values or zero - number of pages got migrated
>>    */
>>   static long
>>   svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range 
>> *prange,
>> -               struct vm_area_struct *vma, uint64_t start, uint64_t 
>> end,
>> -               uint32_t trigger, struct page *fault_page)
>> +            struct vm_area_struct *vma, uint64_t start, uint64_t end,
>> +            uint32_t trigger, struct page *fault_page)
>>   {
>>       struct kfd_process *p = container_of(prange->svms, struct 
>> kfd_process, svms);
>>       uint64_t npages = (end - start) >> PAGE_SHIFT;
>>       unsigned long upages = npages;
>>       unsigned long cpages = 0;
>> +    unsigned long mpages = 0;
>>       struct amdgpu_device *adev = node->adev;
>>       struct kfd_process_device *pdd;
>>       struct dma_fence *mfence = NULL;
>> @@ -725,10 +738,10 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>           goto out_free;
>>       }
>>       if (cpages != npages)
>> -        pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
>> +        pr_debug("partial migration, 0x%lx/0x%llx pages collected\n",
>>                cpages, npages);
>>       else
>> -        pr_debug("0x%lx pages migrated\n", cpages);
>> +        pr_debug("0x%lx pages collected\n", cpages);
>>         r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
>>                       scratch, npages);
>> @@ -751,17 +764,21 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>       kvfree(buf);
>>   out:
>>       if (!r && cpages) {
>> +        mpages = cpages - upages;
>>           pdd = svm_range_get_pdd_by_node(prange, node);
>>           if (pdd)
>> -            WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
>> +            WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
>>       }
>> -    return r ? r : upages;
>> +
>> +    return r ? r : mpages;
>>   }
>>     /**
>>    * svm_migrate_vram_to_ram - migrate svm range from device to system
>>    * @prange: range structure
>>    * @mm: process mm, use current->mm if NULL
>> + * @start_mgr: start page need be migrated to sys ram
>> + * @last_mgr: last page need be migrated to sys ram
>>    * @trigger: reason of migration
>>    * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is 
>> CPU page fault callback
>>    *
>> @@ -771,33 +788,41 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>    * 0 - OK, otherwise error code
>>    */
>>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct 
>> mm_struct *mm,
>> -                uint32_t trigger, struct page *fault_page)
>> +            unsigned long start_mgr, unsigned long last_mgr,
>> +            uint32_t trigger, struct page *fault_page)
>>   {
>>       struct kfd_node *node;
>>       struct vm_area_struct *vma;
>>       unsigned long addr;
>>       unsigned long start;
>>       unsigned long end;
>> -    unsigned long upages = 0;
>> +    unsigned long mpages = 0;
>>       long r = 0;
>>   +    /* this pragne has no any vram page to migrate to sys ram */
>>       if (!prange->actual_loc) {
>>           pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
>>                prange->start, prange->last);
>>           return 0;
>>       }
>>   +    if (start_mgr < prange->start || last_mgr > prange->last) {
>> +        pr_debug("range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
>> +                 start_mgr, last_mgr, prange->start, prange->last);
>> +        return -EFAULT;
>> +    }
>> +
>>       node = svm_range_get_node_by_id(prange, prange->actual_loc);
>>       if (!node) {
>>           pr_debug("failed to get kfd node by id 0x%x\n", 
>> prange->actual_loc);
>>           return -ENODEV;
>>       }
>>       pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to 
>> ram\n",
>> -         prange->svms, prange, prange->start, prange->last,
>> +         prange->svms, prange, start_mgr, last_mgr,
>>            prange->actual_loc);
>>   -    start = prange->start << PAGE_SHIFT;
>> -    end = (prange->last + 1) << PAGE_SHIFT;
>> +    start = start_mgr << PAGE_SHIFT;
>> +    end = (last_mgr + 1) << PAGE_SHIFT;
>>         for (addr = start; addr < end;) {
>>           unsigned long next;
>> @@ -816,14 +841,21 @@ int svm_migrate_vram_to_ram(struct svm_range 
>> *prange, struct mm_struct *mm,
>>               pr_debug("failed %ld to migrate prange %p\n", r, prange);
>>               break;
>>           } else {
>> -            upages += r;
>> +            mpages += r;
>>           }
>>           addr = next;
>>       }
>>   -    if (r >= 0 && !upages) {
>> -        svm_range_vram_node_free(prange);
>> -        prange->actual_loc = 0;
>> +    if (r >= 0) {
>> +        prange->vram_pages = prange->vram_pages - mpages;
>
>     prange->vram_pages -= mpages;
>
ok
>
>> +
>> +        /* prange dos not have vram page drop its svm_bo ref */
>> +        if (prange->vram_pages == 0 && prange->ttm_res) {
>> +            svm_range_vram_node_free(prange);
>> +            mutex_lock(&prange->lock);
>
> Do we really need prange->lock here? I think this function runs with 
> prange->migrate_mutex held, and I think that should be enough to 
> prevent concurrent access to prange->actual_loc. If not, I'd be 
> worried about races between checking the condition above and freeing 
> the node/updating actual_loc.

It maybe overprotected. I checked  prange->actual_loc using, it is 
mostly used during migration, so protected by prange->migrate_mutex. The 
other using is at svm_range_bo_release, as you said following, at this 
stage vram should be moved to ram,  so prange->actual_loc should be zero 
already, not need set it to zero again.

I will remove the lock here and not set prange->actual_lock=0 at 
svm_range_bo_release or set WARN_ON instead as mentioned below.

>
>
>> +            prange->actual_loc = 0;
>> +            mutex_unlock(&prange->lock);
>> +        }
>>       }
>>         return r < 0 ? r : 0;
>> @@ -833,17 +865,23 @@ int svm_migrate_vram_to_ram(struct svm_range 
>> *prange, struct mm_struct *mm,
>>    * svm_migrate_vram_to_vram - migrate svm range from device to device
>>    * @prange: range structure
>>    * @best_loc: the device to migrate to
>> + * @start: start page need be migrated to sys ram
>> + * @last: last page need be migrated to sys ram
>>    * @mm: process mm, use current->mm if NULL
>>    * @trigger: reason of migration
>>    *
>>    * Context: Process context, caller hold mmap read lock, svms lock, 
>> prange lock
>>    *
>> + * migrate all vram pages in prange to sys ram, then migrate
>> + * [start, last] pages from sys ram to gpu node best_loc.
>> + *
>>    * Return:
>>    * 0 - OK, otherwise error code
>>    */
>>   static int
>>   svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>> -             struct mm_struct *mm, uint32_t trigger)
>> +            unsigned long start, unsigned long last,
>> +            struct mm_struct *mm, uint32_t trigger)
>>   {
>>       int r, retries = 3;
>>   @@ -855,7 +893,8 @@ svm_migrate_vram_to_vram(struct svm_range 
>> *prange, uint32_t best_loc,
>>       pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, 
>> best_loc);
>>         do {
>> -        r = svm_migrate_vram_to_ram(prange, mm, trigger, NULL);
>> +        r = svm_migrate_vram_to_ram(prange, mm, prange->start, 
>> prange->last,
>> +                                trigger, NULL);
>>           if (r)
>>               return r;
>>       } while (prange->actual_loc && --retries);
>> @@ -863,17 +902,21 @@ svm_migrate_vram_to_vram(struct svm_range 
>> *prange, uint32_t best_loc,
>>       if (prange->actual_loc)
>>           return -EDEADLK;
>>   -    return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
>> +    return svm_migrate_ram_to_vram(prange, best_loc, start, last, 
>> mm, trigger);
>>   }
>>     int
>>   svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
>> -            struct mm_struct *mm, uint32_t trigger)
>> +            unsigned long start, unsigned long last,
>> +            struct mm_struct *mm, uint32_t trigger)
>>   {
>> -    if  (!prange->actual_loc)
>> -        return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
>> +    if  (!prange->actual_loc || prange->actual_loc == best_loc)
>> +        return svm_migrate_ram_to_vram(prange, best_loc, start, last,
>> +                            mm, trigger);
>> +
>>       else
>> -        return svm_migrate_vram_to_vram(prange, best_loc, mm, trigger);
>> +        return svm_migrate_vram_to_vram(prange, best_loc, start, last,
>> +                                    mm, trigger);
>>     }
>>   @@ -889,10 +932,9 @@ svm_migrate_to_vram(struct svm_range *prange, 
>> uint32_t best_loc,
>>    */
>>   static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>>   {
>> +    unsigned long start, last, size;
>>       unsigned long addr = vmf->address;
>>       struct svm_range_bo *svm_bo;
>> -    enum svm_work_list_ops op;
>> -    struct svm_range *parent;
>>       struct svm_range *prange;
>>       struct kfd_process *p;
>>       struct mm_struct *mm;
>> @@ -929,51 +971,31 @@ static vm_fault_t svm_migrate_to_ram(struct 
>> vm_fault *vmf)
>>         mutex_lock(&p->svms.lock);
>>   -    prange = svm_range_from_addr(&p->svms, addr, &parent);
>> +    prange = svm_range_from_addr(&p->svms, addr, NULL);
>>       if (!prange) {
>>           pr_debug("failed get range svms 0x%p addr 0x%lx\n", 
>> &p->svms, addr);
>>           r = -EFAULT;
>>           goto out_unlock_svms;
>>       }
>>   -    mutex_lock(&parent->migrate_mutex);
>> -    if (prange != parent)
>> -        mutex_lock_nested(&prange->migrate_mutex, 1);
>> +    mutex_lock(&prange->migrate_mutex);
>>         if (!prange->actual_loc)
>>           goto out_unlock_prange;
>>   -    svm_range_lock(parent);
>> -    if (prange != parent)
>> -        mutex_lock_nested(&prange->lock, 1);
>> -    r = svm_range_split_by_granularity(p, mm, addr, parent, prange);
>> -    if (prange != parent)
>> -        mutex_unlock(&prange->lock);
>> -    svm_range_unlock(parent);
>> -    if (r) {
>> -        pr_debug("failed %d to split range by granularity\n", r);
>> -        goto out_unlock_prange;
>> -    }
>> +    /* Align migration range start and size to granularity size */
>> +    size = 1UL << prange->granularity;
>> +    start = max(ALIGN_DOWN(addr, size), prange->start);
>> +    last = min(ALIGN(addr + 1, size) - 1, prange->last);
>>   -    r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm,
>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
>> -                    vmf->page);
>> +    r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm, start, last,
>> +                        KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page);
>>       if (r)
>>           pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 
>> 0x%lx]\n",
>> -             r, prange->svms, prange, prange->start, prange->last);
>> -
>> -    /* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
>> -    if (p->xnack_enabled && parent == prange)
>> -        op = SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP;
>> -    else
>> -        op = SVM_OP_UPDATE_RANGE_NOTIFIER;
>> -    svm_range_add_list_work(&p->svms, parent, mm, op);
>> -    schedule_deferred_list_work(&p->svms);
>> +            r, prange->svms, prange, start, last);
>>     out_unlock_prange:
>> -    if (prange != parent)
>> -        mutex_unlock(&prange->migrate_mutex);
>> -    mutex_unlock(&parent->migrate_mutex);
>> +    mutex_unlock(&prange->migrate_mutex);
>>   out_unlock_svms:
>>       mutex_unlock(&p->svms.lock);
>>   out_unref_process:
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>> index 487f26368164..9e48d10e848e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>> @@ -41,9 +41,13 @@ enum MIGRATION_COPY_DIR {
>>   };
>>     int svm_migrate_to_vram(struct svm_range *prange,  uint32_t 
>> best_loc,
>> +            unsigned long start, unsigned long last,
>>               struct mm_struct *mm, uint32_t trigger);
>> +
>>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct 
>> mm_struct *mm,
>> -                uint32_t trigger, struct page *fault_page);
>> +            unsigned long start, unsigned long last,
>> +            uint32_t trigger, struct page *fault_page);
>> +
>>   unsigned long
>>   svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long 
>> addr);
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index fcdde9f451bb..94d14104234e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -156,12 +156,11 @@ svm_is_valid_dma_mapping_addr(struct device 
>> *dev, dma_addr_t dma_addr)
>>   static int
>>   svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range 
>> *prange,
>>                 unsigned long offset, unsigned long npages,
>> -              unsigned long *hmm_pfns, uint32_t gpuidx)
>> +              unsigned long *hmm_pfns, uint32_t gpuidx, struct page 
>> **page)
>>   {
>>       enum dma_data_direction dir = DMA_BIDIRECTIONAL;
>>       dma_addr_t *addr = prange->dma_addr[gpuidx];
>>       struct device *dev = adev->dev;
>> -    struct page *page;
>>       int i, r;
>>         if (!addr) {
>> @@ -176,8 +175,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, 
>> struct svm_range *prange,
>>           if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
>>               dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
>>   -        page = hmm_pfn_to_page(hmm_pfns[i]);
>> -        if (is_zone_device_page(page)) {
>> +        if (is_zone_device_page(page[i])) {
>>               struct amdgpu_device *bo_adev = 
>> prange->svm_bo->node->adev;
>>                 addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
>> @@ -187,14 +185,14 @@ svm_range_dma_map_dev(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>               pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
>>               continue;
>>           }
>> -        addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
>> +        addr[i] = dma_map_page(dev, page[i], 0, PAGE_SIZE, dir);
>>           r = dma_mapping_error(dev, addr[i]);
>>           if (r) {
>>               dev_err(dev, "failed %d dma_map_page\n", r);
>>               return r;
>>           }
>>           pr_debug_ratelimited("dma mapping 0x%llx for page addr 
>> 0x%lx\n",
>> -                     addr[i] >> PAGE_SHIFT, page_to_pfn(page));
>> +                     addr[i] >> PAGE_SHIFT, page_to_pfn(page[i]));
>>       }
>>       return 0;
>>   }
>> @@ -202,12 +200,24 @@ svm_range_dma_map_dev(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>   static int
>>   svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>>             unsigned long offset, unsigned long npages,
>> -          unsigned long *hmm_pfns)
>> +          unsigned long *hmm_pfns, uint64_t *vram_pages)
>>   {
>>       struct kfd_process *p;
>>       uint32_t gpuidx;
>> +    struct page **page;
>>       int r;
>>   +    page = kvcalloc(npages, sizeof(*page), GFP_KERNEL);
>
> Is there a reason this needs to be 0-initialized? The loop below 
> initializes all elements.
Will use kvmalloc_array instead. This array is not needed to init during 
alloc as it will  be set afterword.
>
> I'm also not happy about having to allocate this page array here. It 
> may be justified if the repeated calls to hmm_pfn_to_page were 
> expensive compared to the memory allocation and initialization. I'm 
> not convinced that's the case, though. With CONFIG_SPARSEMEM_VMEMMAP, 
> hmm_pfn_to_page basically boils down to __pfn_to_page, which is a 
> macro that does just this:
>
> #define __pfn_to_page(pfn)    (vmemmap + (pfn))
>
> See 
> https://elixir.bootlin.com/linux/v6.5.5/source/include/asm-generic/memory_model.h#L37.
>
We get page* array here, then we do not need get page at 
svm_range_dma_map_dev for each device since pages are same for all gpu 
devices. So we save calling hmm_pfn_to_page though calling 
hmm_pfn_to_page cost is low. Here we also want get vram page number 
during svm_range_dma_map.

I think you do not want alloc a page array each time we do 
svm_range_dma_map? then can we put this struct page **page at svm_range, 
and alloc it each time create new prange(and clone/split prange)?

>
>> +    if (!page)
>> +        return -ENOMEM;
>> +
>> +    *vram_pages = 0;
>> +    for (int i = 0; i < npages; i++) {
>> +        page[i] = hmm_pfn_to_page(hmm_pfns[i]);
>> +        if (is_zone_device_page(page[i]))
>> +            (*vram_pages)++;
>> +    }
>> +
>>       p = container_of(prange->svms, struct kfd_process, svms);
>>         for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
>> @@ -221,11 +231,12 @@ svm_range_dma_map(struct svm_range *prange, 
>> unsigned long *bitmap,
>>           }
>>             r = svm_range_dma_map_dev(pdd->dev->adev, prange, offset, 
>> npages,
>> -                      hmm_pfns, gpuidx);
>> +                      hmm_pfns, gpuidx, page);
>>           if (r)
>>               break;
>>       }
>>   +    kvfree(page);
>>       return r;
>>   }
>>   @@ -347,6 +358,7 @@ svm_range *svm_range_new(struct svm_range_list 
>> *svms, uint64_t start,
>>       INIT_LIST_HEAD(&prange->child_list);
>>       atomic_set(&prange->invalid, 0);
>>       prange->validate_timestamp = 0;
>> +    prange->vram_pages = 0;
>>       mutex_init(&prange->migrate_mutex);
>>       mutex_init(&prange->lock);
>>   @@ -393,6 +405,8 @@ static void svm_range_bo_release(struct kref 
>> *kref)
>>                prange->start, prange->last);
>>           mutex_lock(&prange->lock);
>>           prange->svm_bo = NULL;
>> +        /* prange does not hold vram page now */
>> +        prange->actual_loc = 0;
>
> If you need this here, something probably went wrong elsewhere. Before 
> we release the BO, we should have migrated everything to system 
> memory, and actual_loc should already be 0. If anything, I'd add a 
> WARN_ON(prange->actual_loc) here.
>
Will replace by WARN_ON as mentioned before.
>
>> mutex_unlock(&prange->lock);
>>             spin_lock(&svm_bo->list_lock);
>> @@ -966,6 +980,11 @@ svm_range_split_nodes(struct svm_range *new, 
>> struct svm_range *old,
>>       new->svm_bo = svm_range_bo_ref(old->svm_bo);
>>       new->ttm_res = old->ttm_res;
>>   +    /* set new's vram_pages as old range's now, the acurate 
>> vram_pages
>> +     * will be updated during mapping
>> +     */
>> +    new->vram_pages = min(old->vram_pages, new->npages);
>> +
>>       spin_lock(&new->svm_bo->list_lock);
>>       list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>>       spin_unlock(&new->svm_bo->list_lock);
>> @@ -1610,6 +1629,7 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>       struct svm_validate_context *ctx;
>>       unsigned long start, end, addr;
>>       struct kfd_process *p;
>> +    uint64_t vram_pages;
>>       void *owner;
>>       int32_t idx;
>>       int r = 0;
>> @@ -1678,11 +1698,13 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>           }
>>       }
>>   +    vram_pages = 0;
>>       start = prange->start << PAGE_SHIFT;
>>       end = (prange->last + 1) << PAGE_SHIFT;
>>       for (addr = start; addr < end && !r; ) {
>>           struct hmm_range *hmm_range;
>>           struct vm_area_struct *vma;
>> +        uint64_t vram_pages_vma;
>>           unsigned long next;
>>           unsigned long offset;
>>           unsigned long npages;
>> @@ -1711,12 +1733,14 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>             offset = (addr - start) >> PAGE_SHIFT;
>>           r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>> -                      hmm_range->hmm_pfns);
>> +                      hmm_range->hmm_pfns, &vram_pages_vma);
>>           if (r) {
>>               pr_debug("failed %d to dma map range\n", r);
>>               goto unreserve_out;
>>           }
>>   +        vram_pages += vram_pages_vma;
>> +
>>           svm_range_lock(prange);
>>           if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
>>               pr_debug("hmm update the range, need validate again\n");
>> @@ -1738,8 +1762,20 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>           addr = next;
>>       }
>>   -    if (addr == end)
>> +    if (addr == end) {
>>           prange->mapped_to_gpu = true;
>> +        prange->vram_pages = vram_pages;
>> +
>> +        /* if pragne does not include any vram page and it
>
> Typo: prange
>
ok.
>
>> +         * has not released svm_bo drop its svm_bo reference
>> +         */
>> +        if (!vram_pages && prange->ttm_res) {
>> +            svm_range_vram_node_free(prange);
>> +            mutex_lock(&prange->lock);
>
> Is this lock really needed.
>
same as before, will remove mutex_lock/unlock(&prange->lock) as it seems 
overprotected.
>
>> +            prange->actual_loc = 0;
>> +            mutex_unlock(&prange->lock);
>> +        }
>> +    }
>>     unreserve_out:
>>       svm_range_unreserve_bos(ctx);
>> @@ -1996,6 +2032,7 @@ static struct svm_range *svm_range_clone(struct 
>> svm_range *old)
>>       new->actual_loc = old->actual_loc;
>>       new->granularity = old->granularity;
>>       new->mapped_to_gpu = old->mapped_to_gpu;
>> +    new->vram_pages = old->vram_pages;
>>       bitmap_copy(new->bitmap_access, old->bitmap_access, 
>> MAX_GPU_INSTANCE);
>>       bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>>   @@ -2903,6 +2940,7 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>               uint32_t vmid, uint32_t node_id,
>>               uint64_t addr, bool write_fault)
>>   {
>> +    unsigned long start, last, size;
>>       struct mm_struct *mm = NULL;
>>       struct svm_range_list *svms;
>>       struct svm_range *prange;
>> @@ -3038,32 +3076,38 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>       kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>>                          write_fault, timestamp);
>>   -    if (prange->actual_loc != best_loc) {
>> +    if (prange->actual_loc != 0 || best_loc != 0) {
>>           migration = true;
>> +        /* Align migration range start and size to granularity size */
>> +        size = 1UL << prange->granularity;
>> +        start = ALIGN_DOWN(addr, size);
>> +        last = ALIGN(addr + 1, size) - 1;
>> +
>> +        start = (start >= prange->start) ? start : prange->start;
>> +        last = (last <= prange->last) ? last : prange->last;
>
> Similar to the simplification I recommended in svm_migrate_to_ram, 
> this could be:
>
>     start = max(ALIGN_DOWN(addr, size), prange->start);
>     last = min(ALIGN(addr + 1, size) - 1, prange->last);
>
ok, overlooked last time.

Regards

Xiaogang

> Regards,
>   Felix
>
>
>> +
>>           if (best_loc) {
>> -            r = svm_migrate_to_vram(prange, best_loc, mm,
>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>> +            r = svm_migrate_to_vram(prange, best_loc, start, last,
>> +                    mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>               if (r) {
>>                   pr_debug("svm_migrate_to_vram failed (%d) at %llx, 
>> falling back to system memory\n",
>>                        r, addr);
>>                   /* Fallback to system memory if migration to
>>                    * VRAM failed
>>                    */
>> -                if (prange->actual_loc)
>> -                    r = svm_migrate_vram_to_ram(prange, mm,
>> -                       KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>> -                       NULL);
>> +                if (prange->actual_loc && prange->actual_loc != 
>> best_loc)
>> +                    r = svm_migrate_vram_to_ram(prange, mm, start, 
>> last,
>> +                        KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>                   else
>>                       r = 0;
>>               }
>>           } else {
>> -            r = svm_migrate_vram_to_ram(prange, mm,
>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>> -                    NULL);
>> +            r = svm_migrate_vram_to_ram(prange, mm, start, last,
>> +                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>           }
>>           if (r) {
>>               pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
>> -                 r, svms, prange->start, prange->last);
>> +                r, svms, start, last);
>>               goto out_unlock_range;
>>           }
>>       }
>> @@ -3417,18 +3461,24 @@ svm_range_trigger_migration(struct mm_struct 
>> *mm, struct svm_range *prange,
>>       *migrated = false;
>>       best_loc = svm_range_best_prefetch_location(prange);
>>   -    if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
>> -        best_loc == prange->actual_loc)
>> +    /* when best_loc is a gpu node and same as prange->actual_loc
>> +     * we still need do migration as prange->actual_loc !=0 does
>> +     * not mean all pages in prange are vram. hmm migrate will pick
>> +     * up right pages during migration.
>> +     */
>> +    if ((best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED) ||
>> +        (best_loc == 0 && prange->actual_loc == 0))
>>           return 0;
>>         if (!best_loc) {
>> -        r = svm_migrate_vram_to_ram(prange, mm,
>> +        r = svm_migrate_vram_to_ram(prange, mm, prange->start, 
>> prange->last,
>>                       KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>>           *migrated = !r;
>>           return r;
>>       }
>>   -    r = svm_migrate_to_vram(prange, best_loc, mm, 
>> KFD_MIGRATE_TRIGGER_PREFETCH);
>> +    r = svm_migrate_to_vram(prange, best_loc, prange->start, 
>> prange->last,
>> +                    mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>>       *migrated = !r;
>>         return r;
>> @@ -3483,7 +3533,11 @@ static void 
>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>             mutex_lock(&prange->migrate_mutex);
>>           do {
>> +            /* migrate all vram pages in this prange to sys ram
>> +             * after that prange->actual_loc should be zero
>> +             */
>>               r = svm_migrate_vram_to_ram(prange, mm,
>> +                    prange->start, prange->last,
>>                       KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
>>           } while (!r && prange->actual_loc && --retries);
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index 5fd958a97a28..8574cc5eeabd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -78,6 +78,7 @@ struct svm_work_list_item {
>>    * @update_list:link list node used to add to update_list
>>    * @mapping:    bo_va mapping structure to create and update GPU 
>> page table
>>    * @npages:     number of pages
>> + * @vram_pages: vram pages number in this svm_range
>>    * @dma_addr:   dma mapping address on each GPU for system memory 
>> physical page
>>    * @ttm_res:    vram ttm resource map
>>    * @offset:     range start offset within mm_nodes
>> @@ -88,7 +89,9 @@ struct svm_work_list_item {
>>    * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
>>    * @perferred_loc: perferred location, 0 for CPU, or GPU id
>>    * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
>> - * @actual_loc: the actual location, 0 for CPU, or GPU id
>> + * @actual_loc: this svm_range location. 0: all pages are from sys ram;
>> + *              GPU id: this svm_range may include vram pages from 
>> GPU with
>> + *              id actual_loc.
>>    * @granularity:migration granularity, log2 num pages
>>    * @invalid:    not 0 means cpu page table is invalidated
>>    * @validate_timestamp: system timestamp when range is validated
>> @@ -112,6 +115,7 @@ struct svm_range {
>>       struct list_head        list;
>>       struct list_head        update_list;
>>       uint64_t            npages;
>> +    uint64_t            vram_pages;
>>       dma_addr_t            *dma_addr[MAX_GPU_INSTANCE];
>>       struct ttm_resource        *ttm_res;
>>       uint64_t            offset;
