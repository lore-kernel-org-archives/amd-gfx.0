Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFECC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 20:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD7A10E0F4;
	Mon, 11 Dec 2023 20:00:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A01810E0D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 20:00:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gznWYpbbVryApBoSgSA8uN7Yjj8+E6osy8S7rm5ZikTegn+p4XjzpXUSP1nYMQroE0ww6O5WOACC0mCCOHh2P4o1d9iPdn/A3w/YLYX4IALmedfChw8GY/1ZdINALZAiugD/eZzT6GSQdmpvLb+3NbEemraqyJs1ZIjwGO+N0f8QAKI9hltnn8ByYfQzfrPCfVcIoKa++/wXhDe0oahVwBkbueOUsJlLWXwlTzts+5VYVZ2+LfzavUr5eT5aVkKULjIaDOM+eDzeZ7gydSAfkowjIMeUk3RNfbIHKAtR5Ve84jR5XLDr2T814V6wuy/cNkrYZbbXiAp+WKpFbWfBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1DDufJLFda43POpNWKT6zoxRXL0zKDgI8NmHe9ePOA=;
 b=B2p52tDDFzhKe7McSeNCNHcMhfePjLXMY7Pv3A0ghdIVDmkFW5RwLjwH5OTZ758uMTnMYwYJynrbpz+2X/eWAePQ34bqpXQT5IH9NmATSVHCwdvs7VDXh65Myr7oN4KfjT4q5Vt+1F9saY0jpMuaZsyxVG7NZaSebEm9jNsf4P7frddgsW/9X69YiiWphEp9TxVeOqnq/i6MMTYCeW2pKj68M/LP2O+JgjuoGkjrrm+O0pyS7PB9Ka01AZY86nL7TutRIk4NxcIIcxlgSepplCjTMvvZmVUf8uH7tWBSnbja18iYZ7DbEghClZv6dg/TewHIxwrSj8Fdug6GH9huMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1DDufJLFda43POpNWKT6zoxRXL0zKDgI8NmHe9ePOA=;
 b=KKxk8JI0yqBzSpFswF/bVhn91J4qOQmV+4esTvO5JRlhlJsxrfqXJ4SEG6tiDBU3fxjIkHnaabKchRap+kKd2Ccey5Dn69ykwzbB4sWMX/stEWemlwHnhbmB7s5WD5OWN/GuLbVi07OYnvCL9+AA7S9b8BlZPXmsQADSPoofIik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 20:00:04 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::453c:b91b:f673:84bd]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::453c:b91b:f673:84bd%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 20:00:04 +0000
Message-ID: <ed80e951-742f-576b-01e6-4d9030fa6868@amd.com>
Date: Mon, 11 Dec 2023 14:00:01 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] drm/amdkfd: Use partial hmm page walk during buffer
 validation in SVM
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231206152410.123993-1-xiaogang.chen@amd.com>
 <3a9ceb31-cec0-fb51-a6db-55817e30fa95@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <3a9ceb31-cec0-fb51-a6db-55817e30fa95@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:806:d0::35) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|SA3PR12MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: e78302ad-60f6-43e7-ea3f-08dbfa83c3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/pY8RDN7s/Wyu4J1H1Ad+mFTBM8bpDL/CNK6r3Qw+d3dyEzg/GK69OO+k8nKVNiXiPK3/uzS61phlor1vA8zmkCQ7Yyz77uI40APAK6EFnxcQ77jK3/shsmlZGNIK+Ih7tsOzNfCPdC2ZQ+UHv5Bpw+6zKwBBpiGoandW35ql7PQTdQhtwDYXDd3TfJNVvqYTeQ/nKczFgoO1Q1+ju+N6IjT37eKm6n9JqfqirczMfG5FkDtR8AvkOz1LYDUI3MQNDFYn3nk8II1zz8vFQhGW6RB0X7bEqMFcBs3w9PHPaPMxyoD6iNVtURmdpvWfyqQUDgGz5RxHBFzvdJdblUkJP2lG+abIe2owxNnTwQ4HBgJwQpyGRcs/AIJ2gu8VDl3xPReWUC5F5Bk0RrmYZCD1AOTvUIoMBAYTv/17QeMeIa8H6Zod+PrK9hhmkXi7VHoYdU5qziXwoSArv+sS3km5iAAoT3GO6+faGqyHj2tWi8odkQxJPujNL/SZ5YCeI3cllMQgUd1VoT7jdo2/RbaTGu3Ca9jdeNIXfQU9VbKpU6ZqC10vaBZ2XtWwxqJ/Sx0qdmL0Om/5lp8PSTk8rYX03eBnZ0gRb95zWbWsHuuhjEn3O201bjxbxsVNkZ9rHizRWphGGGYPGR3pZGtZarrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2906002)(478600001)(86362001)(41300700001)(31686004)(66556008)(66476007)(66946007)(6486002)(30864003)(6666004)(316002)(38100700002)(8676002)(31696002)(8936002)(4326008)(53546011)(6506007)(6512007)(36756003)(5660300002)(26005)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFpLWEs5OHU5bS9zK3dQc0xDRFlNOFh2bDM0QmNMMkQzaXY3YUZWaWswNlhU?=
 =?utf-8?B?R0VpUTVYa3lRNWlVKzJheGQ3VG5SNXYwWlczeEhtWURaYVE3bFNleHVualJs?=
 =?utf-8?B?Y0huNWhwQ2pnN3AwOXFBZW5OdzRDeW1OclMvQmlDNG50VWtDWS9QRXZwVG9i?=
 =?utf-8?B?QkpyczVCMGNzdTRxeU41U0hMNXNQcEV3TTR4alBQVnhxZlJ2MHZRREt4VVM3?=
 =?utf-8?B?djA4NDk1bUpvLzBRYTV5RkVST3ZhTFpZeHp1N2R3NTlPUUJyRjBxSHVDVkJx?=
 =?utf-8?B?OHA1N0xNMlVpUEZtRTlMREVmNXhtUkxvV3c3WnBEUDRhQlNXd3BaalpkMlhz?=
 =?utf-8?B?UHhYSXFtaXhZOXlKMGlKcGRDa2pnRS9Ma3lYZmF0MEVidkk2QmJUYW5EVmpm?=
 =?utf-8?B?aEkrblN6MmVyUEYzYWJrTzNTU0QrUUNXZWtkN2dCMEhqaVVZWUdmZlNGL0JU?=
 =?utf-8?B?bWFucmVRMUNBOHB0RkpZL2dKV01kVENLSUx4cWVHa05VNXdMZXRqT3ZrSFVh?=
 =?utf-8?B?cExpQzNuYXMwdjAxTDZGc2NUZXAvSEoyYy90dXNJQ0ExMFp4NmJqcGlLK01S?=
 =?utf-8?B?Z3pqK01HTHNocDlQdHVGd0RQL3ZQb2g2Y3VaRHBFM3kzTFgyZm5kU0VJRUh3?=
 =?utf-8?B?U3h5WGw5NWVLL3RGaUdyWkZiQXF4NG1YSElidThFS1pwWDFNdTR1enpHYWNS?=
 =?utf-8?B?RHZ0dGtGRzdVM1UxNjk1cEJRL3BjK3Y5bjZrTGxQL0htNDN3Tk1ubzBVOGI4?=
 =?utf-8?B?dUZYZXVEeUdTS0VLZlUyWDhLYUZTOWQrYUlDbVNBWUt1OExmZ2pUa3psQ0lx?=
 =?utf-8?B?WE5Wbml0Y20ybEc0ZXU1ZFdlNUJrUkNLL3EzVk1NckVOTmliWG8wQUFwWkN0?=
 =?utf-8?B?ZFBqUTZ3Mm9FRzJzYWMyUUJjNFdKOUFIaVNQMWVYejNCRHhqd3BRSGhkREY0?=
 =?utf-8?B?SXlEbnVkOVI3SzVNQkhmNVhmSGlrbDRMcm9PelhTN0xLdi9RMzl2QWUzOHV6?=
 =?utf-8?B?d3Bod3BPSFUyRFJQN1crRDdaSjZUUk96MXlpcnJaU29wM2toN3RsUGdSN1Zl?=
 =?utf-8?B?eWdGOXBYVlpmbWJ4U2d6SEY1Tlhsajhyd1YrNkNyazVLditqcEhhemgrY285?=
 =?utf-8?B?Z3BhMU93Um9uVlJJaDcreUhTWElvSjNDS1dTb2pZdUlZbDVJMC8rbkptMFBa?=
 =?utf-8?B?ODRmRVhJMmxneG51MjBPWmZtM2pnZGlhZlpxWC9wWFRHU1FGa1pSbnV3cndr?=
 =?utf-8?B?NEEraGNmRjlhTXBIaEdqVG5EdytrQWhJZDJDQVl4L09SWUpvSkJwazVTaFZV?=
 =?utf-8?B?Z1ZWOFpvYmRwL2FSMlRzTU41a3Z5MThwc21KS3JoMkllQUMvRGQyWlBrd1Bm?=
 =?utf-8?B?RTVDM3JhWEIyMy9xSG5NMjlIL2RaL09ma0E4ekNMWjhrNlptNVNWR3d5bDhL?=
 =?utf-8?B?RWxKNUF4NTVzRi82SmtHUG1DekpmYmJsYSttWHdvbWpDSHc4ZXRnR0Z1Y1JT?=
 =?utf-8?B?QlorYkx6K3ppQmgrbmZoNTN0blV1aTRENURCTjdkNCsxVEt2K1lnNGtuYWFC?=
 =?utf-8?B?Z0ZxMU14KzJaWkNaZzBqdjZRaGRsZjdOOHU1ODFYUmxtei9zY1pZUlovaFU2?=
 =?utf-8?B?Rmk0azFCd2hvdmFlK0daSG95OWU4TFhESmVHV1RxYndCN29ZM0p0dzhUaDNO?=
 =?utf-8?B?UkVrRFFQN0NlWlZvVllLRklKWjBsamZ1c2JFRGo0Y08zUndJTzN2K0NaZmJu?=
 =?utf-8?B?WEdlZ0dNcHhjYldvTklxcmduc0VvQkRTSlpLMEh0bHhnb1NXWFQyeGhDR1hS?=
 =?utf-8?B?OWFuaW9CT2FveEVUcUE4QTREaUs2dTZEZXNoaVdKenhwMEZJQ0wxZUEybzNF?=
 =?utf-8?B?ZzljM3BBa05McVFGMVNlZTlGOEE5Wno2UWdLR0dGb1h4MXdtTklNOXhrMDJC?=
 =?utf-8?B?dUl1VHEzb0FFVDdFcllKc2c3UDQ0UUFrR0x5OUxHcC8yMFdPWW9PYzFNTkNy?=
 =?utf-8?B?RzdIdUk3RkVzRXZnaDZrNkhQOEZhcSs4TVlZSnE4OG05bXVSQlhaRkx4VWpn?=
 =?utf-8?B?Z1hWREVrcXpab1Rlcyt3QjBsV1lXZ3RqRkMyYzRiV1R0Zm93eXB6TGdGZXhj?=
 =?utf-8?Q?Q8dM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78302ad-60f6-43e7-ea3f-08dbfa83c3a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 20:00:03.4822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyqdTBQXgvZNomcu03CwELuiL4EATy8ET4sbt00nt1G2hi9GLPr/Ox187epxQ2f6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439
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


On 12/11/2023 8:42 AM, Philip Yang wrote:
>
>
> On 2023-12-06 10:24, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> v2:
>> -not need calculate vram page number for new registered svm range, only
>> do it for split vram pages.
>>
>> v3:
>> -use dma address to calculate vram page number of split svm range;
>> use migrate_vma from hmm to calculate page number that migrate to vram.
>>
>> SVM uses hmm page walk to valid buffer before map to gpu vm. After have partial
>> migration/mapping do validation on same vm range as migration/map do instead of
>> whole svm range that can be very large. This change is expected to improve svm
>> code performance.
>
> This looks better, but it is redundant to loop through prange->npages 
> to find vram pages after splitting.
>
To cal split vram page number of prange we always has to loop through 
prange->npages to check each page by its dma addr.

I can put that into svm_range_split_pages when (old->actual_loc && 
old->ttm_res) is true to cal vram page number, still need loop through 
new->npages. Basically we do not save cpu cycle, so not sure where it is 
redundant.

Regards

Xiaogang

> Could add new function svm_range_split_vram_pages to split dma_addr 
> array and count vram_pages in the same prange->npages loop...
>
> svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
> {
>
> .............
>
>     if (old->actual_loc && old->ttm_res) {
>         r = svm_range_split_nodes(new, old, start, last);
>         if (r)
>             return r;
>
>         r = svm_range_split_vram_pages(....);
>
>     } else {
>
>          r = svm_range_split_pages(new, old, start, last);
>     }
>
> Regards,
>
> Philip
>
>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 35 ++++--------
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 72 ++++++++++++------------
>>   2 files changed, 48 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index b854cbf06dce..34376184c37c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -260,19 +260,6 @@ static void svm_migrate_put_sys_page(unsigned long addr)
>>   	put_page(page);
>>   }
>>   
>> -static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
>> -{
>> -	unsigned long cpages = 0;
>> -	unsigned long i;
>> -
>> -	for (i = 0; i < migrate->npages; i++) {
>> -		if (migrate->src[i] & MIGRATE_PFN_VALID &&
>> -		    migrate->src[i] & MIGRATE_PFN_MIGRATE)
>> -			cpages++;
>> -	}
>> -	return cpages;
>> -}
>> -
>>   static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
>>   {
>>   	unsigned long upages = 0;
>> @@ -402,6 +389,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>>   	struct dma_fence *mfence = NULL;
>>   	struct migrate_vma migrate = { 0 };
>>   	unsigned long cpages = 0;
>> +	unsigned long mpages = 0;
>>   	dma_addr_t *scratch;
>>   	void *buf;
>>   	int r = -ENOMEM;
>> @@ -450,12 +438,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>>   	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
>>   	migrate_vma_pages(&migrate);
>>   
>> -	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>> -		svm_migrate_successful_pages(&migrate), cpages, migrate.npages);
>> -
>>   	svm_migrate_copy_done(adev, mfence);
>>   	migrate_vma_finalize(&migrate);
>>   
>> +	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
>> +	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>> +	        mpages, cpages, migrate.npages);
>> +
>>   	kfd_smi_event_migration_end(node, p->lead_thread->pid,
>>   				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
>>   				    0, node->id, trigger);
>> @@ -465,12 +454,12 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>>   out_free:
>>   	kvfree(buf);
>>   out:
>> -	if (!r && cpages) {
>> +	if (!r && mpages) {
>>   		pdd = svm_range_get_pdd_by_node(prange, node);
>>   		if (pdd)
>> -			WRITE_ONCE(pdd->page_in, pdd->page_in + cpages);
>> +			WRITE_ONCE(pdd->page_in, pdd->page_in + mpages);
>>   
>> -		return cpages;
>> +		return mpages;
>>   	}
>>   	return r;
>>   }
>> @@ -498,7 +487,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>>   	struct vm_area_struct *vma;
>>   	uint64_t ttm_res_offset;
>>   	struct kfd_node *node;
>> -	unsigned long cpages = 0;
>> +	unsigned long mpages = 0;
>>   	long r = 0;
>>   
>>   	if (start_mgr < prange->start || last_mgr > prange->last) {
>> @@ -540,15 +529,15 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>>   			pr_debug("failed %ld to migrate\n", r);
>>   			break;
>>   		} else {
>> -			cpages += r;
>> +			mpages += r;
>>   		}
>>   		ttm_res_offset += next - addr;
>>   		addr = next;
>>   	}
>>   
>> -	if (cpages) {
>> +	if (mpages) {
>>   		prange->actual_loc = best_loc;
>> -		prange->vram_pages = prange->vram_pages + cpages;
>> +		prange->vram_pages = prange->vram_pages + mpages;
>>   	} else if (!prange->actual_loc) {
>>   		/* if no page migrated and all pages from prange are at
>>   		 * sys ram drop svm_bo got from svm_range_vram_node_new
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 2834fb351818..8d012ca82cd6 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -158,13 +158,12 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
>>   static int
>>   svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   		      unsigned long offset, unsigned long npages,
>> -		      unsigned long *hmm_pfns, uint32_t gpuidx, uint64_t *vram_pages)
>> +		      unsigned long *hmm_pfns, uint32_t gpuidx)
>>   {
>>   	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
>>   	dma_addr_t *addr = prange->dma_addr[gpuidx];
>>   	struct device *dev = adev->dev;
>>   	struct page *page;
>> -	uint64_t vram_pages_dev;
>>   	int i, r;
>>   
>>   	if (!addr) {
>> @@ -174,7 +173,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   		prange->dma_addr[gpuidx] = addr;
>>   	}
>>   
>> -	vram_pages_dev = 0;
>>   	addr += offset;
>>   	for (i = 0; i < npages; i++) {
>>   		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
>> @@ -184,7 +182,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   		if (is_zone_device_page(page)) {
>>   			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
>>   
>> -			vram_pages_dev++;
>>   			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
>>   				   bo_adev->vm_manager.vram_base_offset -
>>   				   bo_adev->kfd.pgmap.range.start;
>> @@ -201,14 +198,14 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   		pr_debug_ratelimited("dma mapping 0x%llx for page addr 0x%lx\n",
>>   				     addr[i] >> PAGE_SHIFT, page_to_pfn(page));
>>   	}
>> -	*vram_pages = vram_pages_dev;
>> +
>>   	return 0;
>>   }
>>   
>>   static int
>>   svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>>   		  unsigned long offset, unsigned long npages,
>> -		  unsigned long *hmm_pfns, uint64_t *vram_pages)
>> +		  unsigned long *hmm_pfns)
>>   {
>>   	struct kfd_process *p;
>>   	uint32_t gpuidx;
>> @@ -227,7 +224,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>>   		}
>>   
>>   		r = svm_range_dma_map_dev(pdd->dev->adev, prange, offset, npages,
>> -					  hmm_pfns, gpuidx, vram_pages);
>> +					  hmm_pfns, gpuidx);
>>   		if (r)
>>   			break;
>>   	}
>> @@ -982,11 +979,6 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
>>   	new->svm_bo = svm_range_bo_ref(old->svm_bo);
>>   	new->ttm_res = old->ttm_res;
>>   
>> -	/* set new's vram_pages as old range's now, the acurate vram_pages
>> -	 * will be updated during mapping
>> -	 */
>> -	new->vram_pages = min(old->vram_pages, new->npages);
>> -
>>   	spin_lock(&new->svm_bo->list_lock);
>>   	list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>>   	spin_unlock(&new->svm_bo->list_lock);
>> @@ -1049,6 +1041,28 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>>   	return 0;
>>   }
>>   
>> +static int
>> +svm_range_vram_pages(struct svm_range *prange)
>> +{
>> +	int i, j;
>> +	dma_addr_t *addr;
>> +	uint64_t vram_pages = 0;
>> +
>> +	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
>> +		vram_pages = 0;
>> +		if (!prange->dma_addr[i])
>> +			continue;
>> +
>> +		addr = prange->dma_addr[i];
>> +		for (j = 0; j < prange->npages; j++) {
>> +			if (addr[j]&SVM_RANGE_VRAM_DOMAIN)
>> +				vram_pages++;
>> +		}
>> +	}
>> +
>> +	return vram_pages;
>> +}
>> +
>>   /**
>>    * svm_range_split - split a range in 2 ranges
>>    *
>> @@ -1100,6 +1114,10 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
>>   			 r, old_start, old_last, start, last);
>>   		svm_range_free(*new, false);
>>   		*new = NULL;
>> +	} else if (prange->actual_loc && prange->ttm_res && *new) {
>> +		/* calculate *new vram_pages and reduce from prange vram_pages */
>> +		(*new)->vram_pages = svm_range_vram_pages(*new);
>> +		prange->vram_pages -= (*new)->vram_pages;
>>   	}
>>   
>>   	return r;
>> @@ -1109,7 +1127,7 @@ static int
>>   svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
>>   		     struct list_head *insert_list, struct list_head *remap_list)
>>   {
>> -	struct svm_range *tail;
>> +	struct svm_range *tail = NULL;
>>   	int r = svm_range_split(prange, prange->start, new_last, &tail);
>>   
>>   	if (!r) {
>> @@ -1124,7 +1142,7 @@ static int
>>   svm_range_split_head(struct svm_range *prange, uint64_t new_start,
>>   		     struct list_head *insert_list, struct list_head *remap_list)
>>   {
>> -	struct svm_range *head;
>> +	struct svm_range *head = NULL;
>>   	int r = svm_range_split(prange, new_start, prange->last, &head);
>>   
>>   	if (!r) {
>> @@ -1573,7 +1591,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   	struct svm_validate_context *ctx;
>>   	unsigned long start, end, addr;
>>   	struct kfd_process *p;
>> -	uint64_t vram_pages;
>>   	void *owner;
>>   	int32_t idx;
>>   	int r = 0;
>> @@ -1642,15 +1659,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		}
>>   	}
>>   
>> -	vram_pages = 0;
>> -	start = prange->start << PAGE_SHIFT;
>> -	end = (prange->last + 1) << PAGE_SHIFT;
>> +	start = map_start << PAGE_SHIFT;
>> +	end = (map_last + 1) << PAGE_SHIFT;
>>   	for (addr = start; !r && addr < end; ) {
>>   		struct hmm_range *hmm_range;
>>   		unsigned long map_start_vma;
>>   		unsigned long map_last_vma;
>>   		struct vm_area_struct *vma;
>> -		uint64_t vram_pages_vma;
>>   		unsigned long next = 0;
>>   		unsigned long offset;
>>   		unsigned long npages;
>> @@ -1677,13 +1692,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		}
>>   
>>   		if (!r) {
>> -			offset = (addr - start) >> PAGE_SHIFT;
>> +			offset = (addr - (prange->start << PAGE_SHIFT)) >> PAGE_SHIFT;
>>   			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>> -					      hmm_range->hmm_pfns, &vram_pages_vma);
>> +					      hmm_range->hmm_pfns);
>>   			if (r)
>>   				pr_debug("failed %d to dma map range\n", r);
>> -			else
>> -				vram_pages += vram_pages_vma;
>>   		}
>>   
>>   		svm_range_lock(prange);
>> @@ -1716,19 +1729,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		addr = next;
>>   	}
>>   
>> -	if (addr == end) {
>> -		prange->vram_pages = vram_pages;
>> -
>> -		/* if prange does not include any vram page and it
>> -		 * has not released svm_bo drop its svm_bo reference
>> -		 * and set its actaul_loc to sys ram
>> -		 */
>> -		if (!vram_pages && prange->ttm_res) {
>> -			prange->actual_loc = 0;
>> -			svm_range_vram_node_free(prange);
>> -		}
>> -	}
>> -
>>   	svm_range_unreserve_bos(ctx);
>>   	if (!r)
>>   		prange->validate_timestamp = ktime_get_boottime();
