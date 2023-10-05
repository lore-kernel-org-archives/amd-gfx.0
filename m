Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E77E92707
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 15:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E2E10E41D;
	Thu,  5 Oct 2023 15:03:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE8A10E41F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 15:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj+8d6Fn7AbtSh7oJvyZyeRZ9PBAJiHgLdolV5G/f+bkq3gLAs1SeZufI6ok1vdCrF2BeashfHukU/8AdXeAF3HpclV0M1qQ7F6LLWPIsC40sWvY/yHpw1pkrxpK0B5lnIaiuVNjG/d6/AYJW3L5ZCgrsflL89/meBPjgIk98pmLmdR/kIX54bIbtjY+09Hkhs+BsBcfN2bBOQpNcB6PsXkB/0CPwnWgGGk8kZENyS/Qz7+8D8gX6QTD8Lp72c4ptnpqyeIOyJxD/5nBjnUKZuMK8/mPbowh0vufXm+6Ns8y/8/i6R5fuGtjqucY3PNmhsPrI1JogZ6Uxe5RXl9pgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90MYcwtwJaT3wq9WZQ3ZF4d3q/uHSeDH33BcIFO9JF0=;
 b=ZrOD0VlCSi/dYEk0V7snwm41rsliX52qHyWjbAbWrz+wzCdol4ug3HDM6zMLhngf69kPdJ1HtE31Eh9IlIzbH6dV1SUHi6us0th1MS660yYe6Ttv5GAdYPI/QWCuzZ/qQJzlwO3+HWgORS4jADrTo4jFzOVLG880rnNYnxdjbYjJhJo83GqAuOk3IHQFEt4S2tblTxTbXuZWTcn0WL2FBuYwnu0/YZtDr1ffDS5J7OGeuIvSctnVDaUNj9JsjN8LspvnPMeMbH52zt4Mu0cTPUszEKcEc4y0MMST2It+qfwacAa61sSrNEBzL2qzBdxX65lK/u3qLeRLGJnZMv/pyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90MYcwtwJaT3wq9WZQ3ZF4d3q/uHSeDH33BcIFO9JF0=;
 b=Mux3lC+078HTMpEWlT7NScaFq7oEPFIZkPvgO/lwAd3CQLyGZDsuyXmChzsbfBqwi3G4KgF7JEhLBrxg07f7wLbe6SW/tkMB9CSz36fJZhiKJ45LfcdRCNccY87f6XONAIUpCT09FLFGqO5Ob5RGi6YbMRucR8SWLZzFNJyyDgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.36; Thu, 5 Oct 2023 15:03:16 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 15:03:14 +0000
Message-ID: <3bd90561-ca31-9d16-7339-afeeb11a3190@amd.com>
Date: Thu, 5 Oct 2023 10:03:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] drm/amdkfd: Use partial migrations in GPU page faults
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231003233108.16892-1-xiaogang.chen@amd.com>
 <5ab131d8-4285-32cd-8fc2-5137522a2f03@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <5ab131d8-4285-32cd-8fc2-5137522a2f03@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0176.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::12) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf24dd9-4aaf-44bf-0b25-08dbc5b43316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6bSwY5h0kcFxi2HFl8Sq38ou0m2BWi4K2GAXhLkFRY5H8R/3m2l5ZCbU33ZwqBliTQCf9ZzZfX3paQ6k12S6ZiAVBvdqlyJd/rxu+4ZYn6skM6SYKhvUyw7pZkW0tC9WVBTu7agKfh5zHjxExiIRcko7ij1oH5cdNc49NHf1QY3osG2KnxQQvgoBZxo23bjUNewav2rj6gsc4fT5jR4wuONhzGli1a3X3H4Mzp75k7XDU3qkCXdwvpNYdvvheCFe1qiMdbDR5B+RGBQLpkjzDk6cQJDKcaqMMbs+2tH98iYw2iC6IUVMtRLcq4mJrPGq9ff2tSRN0TpTMYuxS9j0/hXMT4Is38ZADBQEiS5XqkSY78nuM/fif2hLx7yyAmK77H+QSX79AG96SxmYH5iUkfdWJgYpZpcXwaD+e8mxvMgJhUh9Gjm67tJxIE4rW50x3Kby8ulD/uuU0bOGXxM+dKqwdg44zA9NlvsORT5JctH7VpihCYOJ6ITkyW7bKlUkUzrapYEDkhE8FNikC9F1Ql+Wz5hqT72xLxfBty6gia/mfhmXJAIkph/oXOJ/aqt5W9N/KBeyJRI1UdBvR+RYJk9vxMe6mB3EG8opx+EPSruYfvVPzbTdD5Bgj4lHMjEDpbqtl4EasUBXqByx2LnLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(31686004)(5660300002)(8676002)(30864003)(2906002)(4326008)(8936002)(41300700001)(66556008)(2616005)(53546011)(316002)(66476007)(66946007)(26005)(6506007)(6666004)(36756003)(6512007)(38100700002)(83380400001)(86362001)(31696002)(478600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWpzZ3FWaGtGanBZaExZRzFCYTBYV3RZUVVHNHRQajBkNW12MkRzQVc4YnNC?=
 =?utf-8?B?QW5tOTFPajBFTk0zNERPOTVacnQ2MzhPeFJSdWY5M1U2V3pjNDVmb0hSS3Rl?=
 =?utf-8?B?UG5UZ1pCZmpwWnEzSzBHZUdKclR6eWFLY0ZSL0J2M2dSSlREaTZPS3Zjbkdl?=
 =?utf-8?B?SnFFaktWRUZubmVxVDZRcE5vemUwdFB4ZGNKakhEbGJUM3JFYXdPZ1dVb0pS?=
 =?utf-8?B?cjZldDltQ1VVY2Z5K3pMM3htdGFXSm9LYzFPdGR5cVFJakJ0djR4QmdPeUVP?=
 =?utf-8?B?Z2NGNHFHbDhIKzJLMjdhN2NUVDBRaFpicnhNdE9xV1FLTDZxNXkzREswSjFL?=
 =?utf-8?B?ams3UmM2Q1RUakZwL2NzMFQva3BCdDF0UXlNdDlhd0FpRGtGRStxM0FvT2NM?=
 =?utf-8?B?N0ZvcVpEdWkxMWxKR3Fja2d3VWczSkZsZW9EbWdYR0ZheEdTdWNSWHZrYlc0?=
 =?utf-8?B?emhEWXFmWUhLbzNicDAxMHdGOWw2TlVlUDJscWs3OEx1ZFZZR0o0M2ZtM1NK?=
 =?utf-8?B?RHgxNXhuRmNKNE52bHl1MlJTSEdERmRiMXNuN25DekE1TjEzQXBxYVN6ajRr?=
 =?utf-8?B?djdxOUFSWDRkTmxGTlY4Q0oxMjZsZGc3QzE3Sm5haTRKc1l1SWp3KzVUejd2?=
 =?utf-8?B?eU1VZVR4R2kxZkRpR0ZUNnNoRVA4eVVGR1Jzd1ZPQURNdjM4eUFyODFwZjNQ?=
 =?utf-8?B?Q1g3L3ZCRFZORDdSRVFsUHlGcXNwdWthNU1uTjZ4ZTArcEZJb00wdUo1bFFZ?=
 =?utf-8?B?VTVaMGdLRGEzT3NEOVFaRDBsZjJidStSU3VMN0JNcE9WS2pPM3dDOXh0Tm9v?=
 =?utf-8?B?bVRNTThka0E3bG4zRSsxTEU4UVVqL1A0T2MwRndGY0F6TDRlZ0tZTHNtTWpo?=
 =?utf-8?B?SHhETVFaYXRCVjJiUzh4cDZTc1F1MkRkWkNxN1dEUEFkYkhHQ29WUm9CbEhN?=
 =?utf-8?B?VE96dktjWURWZUZ6eG16RHRCY1hoMUNuY2NFaXRlRE9ESTBWRWhxdnRmZ3Bp?=
 =?utf-8?B?UE5aRTZJMTI4dWxTYXJ5UTA2amoybE01V3hDK0M4T1Q2blpYbDh1QTh1N1BB?=
 =?utf-8?B?b3pjSEJaZlJBTis3T0lrQjh6dXBham51S3RBbFdoQTdjZnlhZXdlZWZHZDF4?=
 =?utf-8?B?U01teGExWDVYUTVhYnNBV1ZCaFBYcXhmNTRZTXdNVmNkckpMZ1g3em5zZEFL?=
 =?utf-8?B?YzFmYjdlaXJDa1VqRll0SlRaNFJVcXZWNUJtVlgwSU5NMllDaUtDdDBRZ0pU?=
 =?utf-8?B?N1FqQVMyRlNEVTN6K3g4RzQyVk5vekExU3d4WEJBWFA0TXlIZE81TGhCaERy?=
 =?utf-8?B?UGVPWmplUXowV1pyNit0blVBOU5Vc01sY0JMWWNjamtHNHpWT0RoTlAyUWVj?=
 =?utf-8?B?RTFTQitBcktxbzNGZ0FsV2NIVkxKQ0wwTFlDSWpQUFNZdnhZQktBOUVzMDZ3?=
 =?utf-8?B?Tlc1dkhkWjc2ejErRkZLb0gvMHRLYVZ4Wk9teHVhTGMzZjNSZ1BpV2hTSktE?=
 =?utf-8?B?aDNuWnR3ZE5IajhCQVcrWmRCaW5wVTE0aVdGTWpzU2hZaEFGYmRhc1ljUVpu?=
 =?utf-8?B?TE9zOE5JK3RKQmxXNmhFQzhGRFVGUlI1WEtpYytaeng4c1B5VzJmaEw5eG9x?=
 =?utf-8?B?aUNVMDhoNk9OMk1UN2ZvQ3JncUEwcEJWRUM3bWJucGE3MldHTUpPNXlKQjYy?=
 =?utf-8?B?REdxRzEzM1VJbG5NSGxIelhrUnJMRk5GVUNtZlZKQ09xU1hWenNXRWlPQlFv?=
 =?utf-8?B?YXBTbHg0Q2hONHFORUpRSnY3Q3pIMCtteExKUk8wVVdKQU9jQU5FQ2krQlk3?=
 =?utf-8?B?WjhoR2lFT1hHc1lsL3NmT01Kc1h0bithY1FFSlZLclo4b2RyNFRzM2FDUTNH?=
 =?utf-8?B?UUVEZ2Z6UUVyemJZalVZNE14S1QwU0NJUnJJczZZQ0xlL1ZxQ3FzYUc0V1BZ?=
 =?utf-8?B?bk8xMHVac0hITkp3NFhOM2tXUS82N1h4eGp1TjJIYi8zbUQ3WFl0MTVhQ0dM?=
 =?utf-8?B?UXlkRG5XcDJ4c0tlb3p1a1Z3WUYxbzA1dHJOYlJHMW5QdEp1bUFqaGFyTjNx?=
 =?utf-8?B?Yk1XTlFMNzlhRlR2RlNxNU5GU3lRb2ZKV1MzaEh6cmFBYkEvUzZxNWp0Nlc0?=
 =?utf-8?Q?KQ9g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf24dd9-4aaf-44bf-0b25-08dbc5b43316
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 15:03:14.7216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GJuQ4OPZLpJjbTthNf9xsFyIVW1keMxIyGVZHWY2PhaU6H/CVaXo8QI1fYcr2x+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
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


On 10/5/2023 8:25 AM, Philip Yang wrote:
>
> Sorry for the late reply, just notice 2 other issues:
>
> 1. function svm_range_split_by_granularity can be removed now.
>
yes, the code has been sent to gerrit and merged. Will do it next time.
>
> 2. svm_range_restore_pages should map partial range to GPUs after 
> partial migration.
>
I think partial mapping is next step after partial migration is done. I 
have been thinking partial mapping. Will submit a new patch to address it.

Regards

Xiaogang

> Regards,
>
> Philip
>
> On 2023-10-03 19:31, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> This patch implements partial migration in gpu page fault according to migration
>> granularity(default 2MB) and not split svm range in cpu page fault handling.
>> A svm range may include pages from both system ram and vram of one gpu now.
>> These chagnes are expected to improve migration performance and reduce mmu
>> callback and TLB flush workloads.
>>
>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 156 +++++++++++++----------
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |   6 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  83 +++++++++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   6 +-
>>   4 files changed, 162 insertions(+), 89 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index 6c25dab051d5..6a059e4aff86 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -442,10 +442,10 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>>   		goto out_free;
>>   	}
>>   	if (cpages != npages)
>> -		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
>> +		pr_debug("partial migration, 0x%lx/0x%llx pages collected\n",
>>   			 cpages, npages);
>>   	else
>> -		pr_debug("0x%lx pages migrated\n", cpages);
>> +		pr_debug("0x%lx pages collected\n", cpages);
>>   
>>   	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
>>   	migrate_vma_pages(&migrate);
>> @@ -479,6 +479,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>>    * svm_migrate_ram_to_vram - migrate svm range from system to device
>>    * @prange: range structure
>>    * @best_loc: the device to migrate to
>> + * @start_mgr: start page to migrate
>> + * @last_mgr: last page to migrate
>>    * @mm: the process mm structure
>>    * @trigger: reason of migration
>>    *
>> @@ -489,6 +491,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>>    */
>>   static int
>>   svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>> +			unsigned long start_mgr, unsigned long last_mgr,
>>   			struct mm_struct *mm, uint32_t trigger)
>>   {
>>   	unsigned long addr, start, end;
>> @@ -498,23 +501,30 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>>   	unsigned long cpages = 0;
>>   	long r = 0;
>>   
>> -	if (prange->actual_loc == best_loc) {
>> -		pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
>> -			 prange->svms, prange->start, prange->last, best_loc);
>> +	if (!best_loc) {
>> +		pr_debug("svms 0x%p [0x%lx 0x%lx] migrate to sys ram\n",
>> +			prange->svms, start_mgr, last_mgr);
>>   		return 0;
>>   	}
>>   
>> +	if (start_mgr < prange->start || last_mgr > prange->last) {
>> +		pr_debug("range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
>> +				 start_mgr, last_mgr, prange->start, prange->last);
>> +		return -EFAULT;
>> +	}
>> +
>>   	node = svm_range_get_node_by_id(prange, best_loc);
>>   	if (!node) {
>>   		pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
>>   		return -ENODEV;
>>   	}
>>   
>> -	pr_debug("svms 0x%p [0x%lx 0x%lx] to gpu 0x%x\n", prange->svms,
>> -		 prange->start, prange->last, best_loc);
>> +	pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
>> +		prange->svms, start_mgr, last_mgr, prange->start, prange->last,
>> +		best_loc);
>>   
>> -	start = prange->start << PAGE_SHIFT;
>> -	end = (prange->last + 1) << PAGE_SHIFT;
>> +	start = start_mgr << PAGE_SHIFT;
>> +	end = (last_mgr + 1) << PAGE_SHIFT;
>>   
>>   	r = svm_range_vram_node_new(node, prange, true);
>>   	if (r) {
>> @@ -544,8 +554,11 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>>   
>>   	if (cpages) {
>>   		prange->actual_loc = best_loc;
>> -		svm_range_dma_unmap(prange);
>> -	} else {
>> +		prange->vram_pages = prange->vram_pages + cpages;
>> +	} else if (!prange->actual_loc) {
>> +		/* if no page migrated and all pages from prange are at
>> +		 * sys ram drop svm_bo got from svm_range_vram_node_new
>> +		 */
>>   		svm_range_vram_node_free(prange);
>>   	}
>>   
>> @@ -663,19 +676,19 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>>    * Context: Process context, caller hold mmap read lock, prange->migrate_mutex
>>    *
>>    * Return:
>> - *   0 - success with all pages migrated
>>    *   negative values - indicate error
>> - *   positive values - partial migration, number of pages not migrated
>> + *   positive values or zero - number of pages got migrated
>>    */
>>   static long
>>   svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>> -		       struct vm_area_struct *vma, uint64_t start, uint64_t end,
>> -		       uint32_t trigger, struct page *fault_page)
>> +			struct vm_area_struct *vma, uint64_t start, uint64_t end,
>> +			uint32_t trigger, struct page *fault_page)
>>   {
>>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
>>   	unsigned long upages = npages;
>>   	unsigned long cpages = 0;
>> +	unsigned long mpages = 0;
>>   	struct amdgpu_device *adev = node->adev;
>>   	struct kfd_process_device *pdd;
>>   	struct dma_fence *mfence = NULL;
>> @@ -725,10 +738,10 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>>   		goto out_free;
>>   	}
>>   	if (cpages != npages)
>> -		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
>> +		pr_debug("partial migration, 0x%lx/0x%llx pages collected\n",
>>   			 cpages, npages);
>>   	else
>> -		pr_debug("0x%lx pages migrated\n", cpages);
>> +		pr_debug("0x%lx pages collected\n", cpages);
>>   
>>   	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
>>   				    scratch, npages);
>> @@ -751,17 +764,21 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>>   	kvfree(buf);
>>   out:
>>   	if (!r && cpages) {
>> +		mpages = cpages - upages;
>>   		pdd = svm_range_get_pdd_by_node(prange, node);
>>   		if (pdd)
>> -			WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
>> +			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
>>   	}
>> -	return r ? r : upages;
>> +
>> +	return r ? r : mpages;
>>   }
>>   
>>   /**
>>    * svm_migrate_vram_to_ram - migrate svm range from device to system
>>    * @prange: range structure
>>    * @mm: process mm, use current->mm if NULL
>> + * @start_mgr: start page need be migrated to sys ram
>> + * @last_mgr: last page need be migrated to sys ram
>>    * @trigger: reason of migration
>>    * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is CPU page fault callback
>>    *
>> @@ -771,33 +788,41 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>>    * 0 - OK, otherwise error code
>>    */
>>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>> -			    uint32_t trigger, struct page *fault_page)
>> +			unsigned long start_mgr, unsigned long last_mgr,
>> +			uint32_t trigger, struct page *fault_page)
>>   {
>>   	struct kfd_node *node;
>>   	struct vm_area_struct *vma;
>>   	unsigned long addr;
>>   	unsigned long start;
>>   	unsigned long end;
>> -	unsigned long upages = 0;
>> +	unsigned long mpages = 0;
>>   	long r = 0;
>>   
>> +	/* this pragne has no any vram page to migrate to sys ram */
>>   	if (!prange->actual_loc) {
>>   		pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
>>   			 prange->start, prange->last);
>>   		return 0;
>>   	}
>>   
>> +	if (start_mgr < prange->start || last_mgr > prange->last) {
>> +		pr_debug("range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
>> +				 start_mgr, last_mgr, prange->start, prange->last);
>> +		return -EFAULT;
>> +	}
>> +
>>   	node = svm_range_get_node_by_id(prange, prange->actual_loc);
>>   	if (!node) {
>>   		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
>>   		return -ENODEV;
>>   	}
>>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
>> -		 prange->svms, prange, prange->start, prange->last,
>> +		 prange->svms, prange, start_mgr, last_mgr,
>>   		 prange->actual_loc);
>>   
>> -	start = prange->start << PAGE_SHIFT;
>> -	end = (prange->last + 1) << PAGE_SHIFT;
>> +	start = start_mgr << PAGE_SHIFT;
>> +	end = (last_mgr + 1) << PAGE_SHIFT;
>>   
>>   	for (addr = start; addr < end;) {
>>   		unsigned long next;
>> @@ -816,14 +841,21 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>>   			pr_debug("failed %ld to migrate prange %p\n", r, prange);
>>   			break;
>>   		} else {
>> -			upages += r;
>> +			mpages += r;
>>   		}
>>   		addr = next;
>>   	}
>>   
>> -	if (r >= 0 && !upages) {
>> -		svm_range_vram_node_free(prange);
>> -		prange->actual_loc = 0;
>> +	if (r >= 0) {
>> +		prange->vram_pages -= mpages;
>> +
>> +		/* prange does not have vram page set its actual_loc to system
>> +		 * and drop its svm_bo ref
>> +		 */
>> +		if (prange->vram_pages == 0 && prange->ttm_res) {
>> +			prange->actual_loc = 0;
>> +			svm_range_vram_node_free(prange);
>> +		}
>>   	}
>>   
>>   	return r < 0 ? r : 0;
>> @@ -833,17 +865,23 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>>    * svm_migrate_vram_to_vram - migrate svm range from device to device
>>    * @prange: range structure
>>    * @best_loc: the device to migrate to
>> + * @start: start page need be migrated to sys ram
>> + * @last: last page need be migrated to sys ram
>>    * @mm: process mm, use current->mm if NULL
>>    * @trigger: reason of migration
>>    *
>>    * Context: Process context, caller hold mmap read lock, svms lock, prange lock
>>    *
>> + * migrate all vram pages in prange to sys ram, then migrate
>> + * [start, last] pages from sys ram to gpu node best_loc.
>> + *
>>    * Return:
>>    * 0 - OK, otherwise error code
>>    */
>>   static int
>>   svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>> -			 struct mm_struct *mm, uint32_t trigger)
>> +			unsigned long start, unsigned long last,
>> +			struct mm_struct *mm, uint32_t trigger)
>>   {
>>   	int r, retries = 3;
>>   
>> @@ -855,7 +893,8 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>>   	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
>>   
>>   	do {
>> -		r = svm_migrate_vram_to_ram(prange, mm, trigger, NULL);
>> +		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
>> +								trigger, NULL);
>>   		if (r)
>>   			return r;
>>   	} while (prange->actual_loc && --retries);
>> @@ -863,17 +902,21 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>>   	if (prange->actual_loc)
>>   		return -EDEADLK;
>>   
>> -	return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
>> +	return svm_migrate_ram_to_vram(prange, best_loc, start, last, mm, trigger);
>>   }
>>   
>>   int
>>   svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
>> -		    struct mm_struct *mm, uint32_t trigger)
>> +			unsigned long start, unsigned long last,
>> +			struct mm_struct *mm, uint32_t trigger)
>>   {
>> -	if  (!prange->actual_loc)
>> -		return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
>> +	if  (!prange->actual_loc || prange->actual_loc == best_loc)
>> +		return svm_migrate_ram_to_vram(prange, best_loc, start, last,
>> +						mm, trigger);
>> +
>>   	else
>> -		return svm_migrate_vram_to_vram(prange, best_loc, mm, trigger);
>> +		return svm_migrate_vram_to_vram(prange, best_loc, start, last,
>> +						mm, trigger);
>>   
>>   }
>>   
>> @@ -889,10 +932,9 @@ svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
>>    */
>>   static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>>   {
>> +	unsigned long start, last, size;
>>   	unsigned long addr = vmf->address;
>>   	struct svm_range_bo *svm_bo;
>> -	enum svm_work_list_ops op;
>> -	struct svm_range *parent;
>>   	struct svm_range *prange;
>>   	struct kfd_process *p;
>>   	struct mm_struct *mm;
>> @@ -929,51 +971,31 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>>   
>>   	mutex_lock(&p->svms.lock);
>>   
>> -	prange = svm_range_from_addr(&p->svms, addr, &parent);
>> +	prange = svm_range_from_addr(&p->svms, addr, NULL);
>>   	if (!prange) {
>>   		pr_debug("failed get range svms 0x%p addr 0x%lx\n", &p->svms, addr);
>>   		r = -EFAULT;
>>   		goto out_unlock_svms;
>>   	}
>>   
>> -	mutex_lock(&parent->migrate_mutex);
>> -	if (prange != parent)
>> -		mutex_lock_nested(&prange->migrate_mutex, 1);
>> +	mutex_lock(&prange->migrate_mutex);
>>   
>>   	if (!prange->actual_loc)
>>   		goto out_unlock_prange;
>>   
>> -	svm_range_lock(parent);
>> -	if (prange != parent)
>> -		mutex_lock_nested(&prange->lock, 1);
>> -	r = svm_range_split_by_granularity(p, mm, addr, parent, prange);
>> -	if (prange != parent)
>> -		mutex_unlock(&prange->lock);
>> -	svm_range_unlock(parent);
>> -	if (r) {
>> -		pr_debug("failed %d to split range by granularity\n", r);
>> -		goto out_unlock_prange;
>> -	}
>> +	/* Align migration range start and size to granularity size */
>> +	size = 1UL << prange->granularity;
>> +	start = max(ALIGN_DOWN(addr, size), prange->start);
>> +	last = min(ALIGN(addr + 1, size) - 1, prange->last);
>>   
>> -	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm,
>> -				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
>> -				    vmf->page);
>> +	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm, start, last,
>> +						KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page);
>>   	if (r)
>>   		pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 0x%lx]\n",
>> -			 r, prange->svms, prange, prange->start, prange->last);
>> -
>> -	/* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
>> -	if (p->xnack_enabled && parent == prange)
>> -		op = SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP;
>> -	else
>> -		op = SVM_OP_UPDATE_RANGE_NOTIFIER;
>> -	svm_range_add_list_work(&p->svms, parent, mm, op);
>> -	schedule_deferred_list_work(&p->svms);
>> +			r, prange->svms, prange, start, last);
>>   
>>   out_unlock_prange:
>> -	if (prange != parent)
>> -		mutex_unlock(&prange->migrate_mutex);
>> -	mutex_unlock(&parent->migrate_mutex);
>> +	mutex_unlock(&prange->migrate_mutex);
>>   out_unlock_svms:
>>   	mutex_unlock(&p->svms.lock);
>>   out_unref_process:
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>> index 487f26368164..9e48d10e848e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>> @@ -41,9 +41,13 @@ enum MIGRATION_COPY_DIR {
>>   };
>>   
>>   int svm_migrate_to_vram(struct svm_range *prange,  uint32_t best_loc,
>> +			unsigned long start, unsigned long last,
>>   			struct mm_struct *mm, uint32_t trigger);
>> +
>>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>> -			    uint32_t trigger, struct page *fault_page);
>> +			unsigned long start, unsigned long last,
>> +			uint32_t trigger, struct page *fault_page);
>> +
>>   unsigned long
>>   svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 649f9685e1ec..5a15866b52ee 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -156,7 +156,7 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
>>   static int
>>   svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   		      unsigned long offset, unsigned long npages,
>> -		      unsigned long *hmm_pfns, uint32_t gpuidx)
>> +		      unsigned long *hmm_pfns, uint32_t gpuidx, uint64_t *vram_pages)
>>   {
>>   	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
>>   	dma_addr_t *addr = prange->dma_addr[gpuidx];
>> @@ -171,6 +171,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   		prange->dma_addr[gpuidx] = addr;
>>   	}
>>   
>> +	*vram_pages = 0;
>>   	addr += offset;
>>   	for (i = 0; i < npages; i++) {
>>   		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
>> @@ -180,6 +181,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   		if (is_zone_device_page(page)) {
>>   			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
>>   
>> +			(*vram_pages)++;
>>   			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
>>   				   bo_adev->vm_manager.vram_base_offset -
>>   				   bo_adev->kfd.pgmap.range.start;
>> @@ -202,7 +204,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   static int
>>   svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>>   		  unsigned long offset, unsigned long npages,
>> -		  unsigned long *hmm_pfns)
>> +		  unsigned long *hmm_pfns, uint64_t *vram_pages)
>>   {
>>   	struct kfd_process *p;
>>   	uint32_t gpuidx;
>> @@ -221,7 +223,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>>   		}
>>   
>>   		r = svm_range_dma_map_dev(pdd->dev->adev, prange, offset, npages,
>> -					  hmm_pfns, gpuidx);
>> +					  hmm_pfns, gpuidx, vram_pages);
>>   		if (r)
>>   			break;
>>   	}
>> @@ -347,6 +349,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>>   	INIT_LIST_HEAD(&prange->child_list);
>>   	atomic_set(&prange->invalid, 0);
>>   	prange->validate_timestamp = 0;
>> +	prange->vram_pages = 0;
>>   	mutex_init(&prange->migrate_mutex);
>>   	mutex_init(&prange->lock);
>>   
>> @@ -393,6 +396,8 @@ static void svm_range_bo_release(struct kref *kref)
>>   			 prange->start, prange->last);
>>   		mutex_lock(&prange->lock);
>>   		prange->svm_bo = NULL;
>> +		/* prange should not hold vram page now */
>> +		WARN_ON(prange->actual_loc);
>>   		mutex_unlock(&prange->lock);
>>   
>>   		spin_lock(&svm_bo->list_lock);
>> @@ -973,6 +978,11 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
>>   	new->svm_bo = svm_range_bo_ref(old->svm_bo);
>>   	new->ttm_res = old->ttm_res;
>>   
>> +	/* set new's vram_pages as old range's now, the acurate vram_pages
>> +	 * will be updated during mapping
>> +	 */
>> +	new->vram_pages = min(old->vram_pages, new->npages);
>> +
>>   	spin_lock(&new->svm_bo->list_lock);
>>   	list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>>   	spin_unlock(&new->svm_bo->list_lock);
>> @@ -1617,6 +1627,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   	struct svm_validate_context *ctx;
>>   	unsigned long start, end, addr;
>>   	struct kfd_process *p;
>> +	uint64_t vram_pages;
>>   	void *owner;
>>   	int32_t idx;
>>   	int r = 0;
>> @@ -1685,11 +1696,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		}
>>   	}
>>   
>> +	vram_pages = 0;
>>   	start = prange->start << PAGE_SHIFT;
>>   	end = (prange->last + 1) << PAGE_SHIFT;
>>   	for (addr = start; !r && addr < end; ) {
>>   		struct hmm_range *hmm_range;
>>   		struct vm_area_struct *vma;
>> +		uint64_t vram_pages_vma;
>>   		unsigned long next = 0;
>>   		unsigned long offset;
>>   		unsigned long npages;
>> @@ -1718,9 +1731,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		if (!r) {
>>   			offset = (addr - start) >> PAGE_SHIFT;
>>   			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>> -					      hmm_range->hmm_pfns);
>> +					      hmm_range->hmm_pfns, &vram_pages_vma);
>>   			if (r)
>>   				pr_debug("failed %d to dma map range\n", r);
>> +			else
>> +				vram_pages += vram_pages_vma;
>>   		}
>>   
>>   		svm_range_lock(prange);
>> @@ -1746,6 +1761,19 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		addr = next;
>>   	}
>>   
>> +	if (addr == end) {
>> +		prange->vram_pages = vram_pages;
>> +
>> +		/* if prange does not include any vram page and it
>> +		 * has not released svm_bo drop its svm_bo reference
>> +		 * and set its actaul_loc to sys ram
>> +		 */
>> +		if (!vram_pages && prange->ttm_res) {
>> +			prange->actual_loc = 0;
>> +			svm_range_vram_node_free(prange);
>> +		}
>> +	}
>> +
>>   	svm_range_unreserve_bos(ctx);
>>   	if (!r)
>>   		prange->validate_timestamp = ktime_get_boottime();
>> @@ -1998,6 +2026,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>>   	new->actual_loc = old->actual_loc;
>>   	new->granularity = old->granularity;
>>   	new->mapped_to_gpu = old->mapped_to_gpu;
>> +	new->vram_pages = old->vram_pages;
>>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>>   
>> @@ -2116,7 +2145,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>   		next_start = min(node->last, last) + 1;
>>   
>>   		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
>> -		    prange->mapped_to_gpu) {
>> +			prange->mapped_to_gpu) {
>>   			/* nothing to do */
>>   		} else if (node->start < start || node->last > last) {
>>   			/* node intersects the update range and its attributes
>> @@ -2906,6 +2935,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>>   			uint32_t vmid, uint32_t node_id,
>>   			uint64_t addr, bool write_fault)
>>   {
>> +	unsigned long start, last, size;
>>   	struct mm_struct *mm = NULL;
>>   	struct svm_range_list *svms;
>>   	struct svm_range *prange;
>> @@ -3041,32 +3071,35 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>>   	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>>   				       write_fault, timestamp);
>>   
>> -	if (prange->actual_loc != best_loc) {
>> +	if (prange->actual_loc != 0 || best_loc != 0) {
>>   		migration = true;
>> +		/* Align migration range start and size to granularity size */
>> +		size = 1UL << prange->granularity;
>> +		start = max_t(unsigned long, ALIGN_DOWN(addr, size), prange->start);
>> +		last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange->last);
>> +
>>   		if (best_loc) {
>> -			r = svm_migrate_to_vram(prange, best_loc, mm,
>> -					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>> +			r = svm_migrate_to_vram(prange, best_loc, start, last,
>> +					mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>   			if (r) {
>>   				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
>>   					 r, addr);
>>   				/* Fallback to system memory if migration to
>>   				 * VRAM failed
>>   				 */
>> -				if (prange->actual_loc)
>> -					r = svm_migrate_vram_to_ram(prange, mm,
>> -					   KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>> -					   NULL);
>> +				if (prange->actual_loc && prange->actual_loc != best_loc)
>> +					r = svm_migrate_vram_to_ram(prange, mm, start, last,
>> +						KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>   				else
>>   					r = 0;
>>   			}
>>   		} else {
>> -			r = svm_migrate_vram_to_ram(prange, mm,
>> -					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>> -					NULL);
>> +			r = svm_migrate_vram_to_ram(prange, mm, start, last,
>> +					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>   		}
>>   		if (r) {
>>   			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
>> -				 r, svms, prange->start, prange->last);
>> +				r, svms, start, last);
>>   			goto out_unlock_range;
>>   		}
>>   	}
>> @@ -3420,18 +3453,24 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
>>   	*migrated = false;
>>   	best_loc = svm_range_best_prefetch_location(prange);
>>   
>> -	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
>> -	    best_loc == prange->actual_loc)
>> +	/* when best_loc is a gpu node and same as prange->actual_loc
>> +	 * we still need do migration as prange->actual_loc !=0 does
>> +	 * not mean all pages in prange are vram. hmm migrate will pick
>> +	 * up right pages during migration.
>> +	 */
>> +	if ((best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED) ||
>> +		(best_loc == 0 && prange->actual_loc == 0))
>>   		return 0;
>>   
>>   	if (!best_loc) {
>> -		r = svm_migrate_vram_to_ram(prange, mm,
>> +		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
>>   					KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>>   		*migrated = !r;
>>   		return r;
>>   	}
>>   
>> -	r = svm_migrate_to_vram(prange, best_loc, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>> +	r = svm_migrate_to_vram(prange, best_loc, prange->start, prange->last,
>> +					mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>>   	*migrated = !r;
>>   
>>   	return r;
>> @@ -3486,7 +3525,11 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>>   
>>   		mutex_lock(&prange->migrate_mutex);
>>   		do {
>> +			/* migrate all vram pages in this prange to sys ram
>> +			 * after that prange->actual_loc should be zero
>> +			 */
>>   			r = svm_migrate_vram_to_ram(prange, mm,
>> +					prange->start, prange->last,
>>   					KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
>>   		} while (!r && prange->actual_loc && --retries);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index c528df1d0ba2..be11ba0c4289 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -78,6 +78,7 @@ struct svm_work_list_item {
>>    * @update_list:link list node used to add to update_list
>>    * @mapping:    bo_va mapping structure to create and update GPU page table
>>    * @npages:     number of pages
>> + * @vram_pages: vram pages number in this svm_range
>>    * @dma_addr:   dma mapping address on each GPU for system memory physical page
>>    * @ttm_res:    vram ttm resource map
>>    * @offset:     range start offset within mm_nodes
>> @@ -88,7 +89,9 @@ struct svm_work_list_item {
>>    * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
>>    * @perferred_loc: perferred location, 0 for CPU, or GPU id
>>    * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
>> - * @actual_loc: the actual location, 0 for CPU, or GPU id
>> + * @actual_loc: this svm_range location. 0: all pages are from sys ram;
>> + *              GPU id: this svm_range may include vram pages from GPU with
>> + *              id actual_loc.
>>    * @granularity:migration granularity, log2 num pages
>>    * @invalid:    not 0 means cpu page table is invalidated
>>    * @validate_timestamp: system timestamp when range is validated
>> @@ -112,6 +115,7 @@ struct svm_range {
>>   	struct list_head		list;
>>   	struct list_head		update_list;
>>   	uint64_t			npages;
>> +	uint64_t			vram_pages;
>>   	dma_addr_t			*dma_addr[MAX_GPU_INSTANCE];
>>   	struct ttm_resource		*ttm_res;
>>   	uint64_t			offset;
