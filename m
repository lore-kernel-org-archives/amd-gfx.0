Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E21C00A8F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 23:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF85210E2A3;
	Mon, 23 Oct 2023 23:08:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A51210E2A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 23:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiKpIJBuAPnSv222So2BagqrfnbvJgZ+3gPsstegf4YH/gLTe+OCxq+Wi6rYvRaFKjNjRCIieYLIrX+9JL+qeDJ6LxKVitLqKlLtVhZ7K4l8iepNgQISTR/i+ISPyK04RE89wMRFZKL3jtY2qaZ7WqnV/OEB+i0/ABiF4auayfWi9kwD4yyIaXjWbvBIyN/YkjGQDGhM+el/pw6tO1rO9k66138MdWJkhPHbQV+Bm4mRHEBkukchz2H91jkz/JTHknPPyw8oqGZJrf39YAI4chTPyoPtHeLEQRsYBVLanBI6hW/HzG04yE9kIj71eTsY+JNIfKmReQBKawvXzYDLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNx5nerUY2N/eHEpbm1z2LwiaSB9bGgQFGkftE0K7Ow=;
 b=hqiTlow4QoyXqysBbifjqpDlkTFpRsCVF1/gJ26bio91CaDFku8PNFFNmXvtmgjGxgV/vAVJcYblt77HRNa4FSZI7q5bfRswfmA8lsu0LZbMWrixBtcARMa0AWkEKJaj4f69oM8LO0cWTJCfHdFST6VdcUEuXGQfSlOsqLtxDM0LZMjiXtFChnzi2XP8c2ibUElGLpzPjLrtvb8l3Z4UhQ8EN+lckeSrupWnr4jl3EdWH3qJUVr5hUD3YEWGRom+LFz8f6gm8C4xa+CzRK4501L0n0lkKkENPfFzfUUzSGYOk9hsQ+Q+BqnodgVrrkm8C0gJ1W4oVZpPSO732IWPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNx5nerUY2N/eHEpbm1z2LwiaSB9bGgQFGkftE0K7Ow=;
 b=vtNOL2K5Gzhgth+gCODSijngLHaFq4xnc1569mmVXHHMQWksLeNXFvhQjrvLXrYrzBwOhjHMilLia6cBANqrQWzCYvEj99zOZp4092JHkzv3j03W5rIBCMVPjP/8AHZVo/5KhtjOngJUfIwLbZ+5i7l/8FSmcIJcEsjpcIYgEsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 23:08:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31%4]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 23:08:08 +0000
Message-ID: <f655fcea-e709-4ec9-8edd-298c5c122b70@amd.com>
Date: Mon, 23 Oct 2023 19:08:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Use partial mapping in GPU page faults
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231020215316.247816-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20231020215316.247816-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0259.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 42021ceb-7362-4ae0-8d30-08dbd41cebb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPiDROhRJVUKm1LW+aiayNF6eOX2w+166FB2VMEy/UgJ+xosjfZraMh5rwm+Li3B3NJvx3s3kCRBd5ZNaxMtpJlvWoueKkVJwmeeRa7Gwfl4dn4WEIMM6Bvum8F5neTL91XuA17e02R71cyEuMcAm2q7lHv7SsQ/29GR3iGc+Ux+zyqOEqNjHqZ7vZTbxup9ksuNB+LcgjgOYFGq17yrZCFmvw0FNdsDnmg4n8aYL/+80o9wJ8Fw8C2DgiEtqzQjPjW3yabrRAQy9q2m1oEEs741lHLlnFNvDeb/2cEMRanCJaL2GxCFKetse4PculmLmMA3Rm0OsooPR5X7VgK1Ug4+7IlJ30enlQ2pPL9uKuoXOHFhLuqiUGfIvLfsv+FryTM1qWDXvrCr1XZ+oWXqg8RKyLTrrxSdo8iiRLUD09qk5Ps1OMdUa68rA3wvMUqw2BU+TfyKDeUUS0jkPJL8Uh9T3Q1V6TBL7+dT+wUBlY+fsM9p4UzTnYl93CHOI+Tax0HNrd2PrgVpxDoX+kkobcHH8QCI69VnbmSul5iJIr3qfjo6IDt/oF8gtHVllTecPXnQLMoKpuwRP8i0LBJ4Y63U6iikr8r8/suJjZyE48lb0BDqvA89SE1PXhIa/oBe2fUqw52R9kqVl2PA+9ZD4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31686004)(5660300002)(8936002)(41300700001)(44832011)(2616005)(26005)(6506007)(2906002)(38100700002)(53546011)(6512007)(8676002)(478600001)(4326008)(86362001)(83380400001)(66946007)(31696002)(66476007)(36756003)(4001150100001)(316002)(66556008)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0hPY3U4dEkzN1dTajBRalJ4Lzd1dU1wSGhkYk1nK1BsN0FGc3lXY1VLeDB0?=
 =?utf-8?B?ODJYdjJKZUpnUFdlM2dUa0pON1I3bEtDWGQxZUc2T2kyNTlud2JnSkdNSVFy?=
 =?utf-8?B?YWszMFBMZ3ppOFdjY2RZdC8vdUJIZzlWc2N1cEh3OFZ2MWJWVFJkLy9TNW8w?=
 =?utf-8?B?RmtmRXFwSXRGZEFHaDlHRFFaSmZTYUQ0Sk15ekxxV1pFZk0zRVdxRzVJZEty?=
 =?utf-8?B?b1BzMG56S2tvMzE4OG84cytuK21BOFBySjVYZ3JJNGN4RGdrTVBVSjNZdXBa?=
 =?utf-8?B?SHpoZnFPYWhnalk0azkzQSs2NTNRcmVkWHBMWWREKzcyZ05ua2g0dVZkb2Ez?=
 =?utf-8?B?aFFCRlVvVllwSS96YlVnREI0cnhUWW9ub0c2ZTFTeDFaU3ZPUy9wUEYzUC9H?=
 =?utf-8?B?bWdFZmFadzBPSGp0S05DTVIzN0o1MEt2d3FrTk43cTJNWE40T1RhZWp0bkZh?=
 =?utf-8?B?b25uRFdJdWtiYTJzYUcwV2cxcExodUU0NmtBbEVENFp1MnFhb3dxc1JwVGxG?=
 =?utf-8?B?ajJqVThBRzVldTJVejZxZVREcERsZHJkWGU4MzhZMzNVeWxqRXR3LzlwMjNR?=
 =?utf-8?B?YmZ4ZGVqdDR3eXM3QWVZcmYxRmhTc29Oa1A4eHZjMkltWTdRQ3NaWkFmbFRh?=
 =?utf-8?B?UjNoYnpDS0dqZHNqT3ljN2hlUmN3MDVyZ2Q0L1k4MG1RZ2RTV1JSdzljQXdz?=
 =?utf-8?B?ZHBvR21GR08veHN1MnVNSnZYZ081L3l2bEdyK2tIdllJTmcwVHAzQjMzVTk5?=
 =?utf-8?B?dWhTdG5OeithcEZ6N0d0YzdJcGdZYmhEY0ZJbnBYazl2OFJBb1VMQUIzcFVK?=
 =?utf-8?B?YkxtZW0wVXRrS0RkQkVQYzFWVzJmTmNpeFJjdjRkUjZXSTFFcTlSZHN4UlNQ?=
 =?utf-8?B?bHhMeWxZMmNYSTRsSGZMd1AyRUFMUGZEaEhzbjUvdDU2M0YyS1J2bWFrcGlR?=
 =?utf-8?B?Szh2MjdFNjBxUFpuTnhFSXBYMUhVWHBpeXQ0d0N0UVl0T1lBTWF6Nk5RQlVj?=
 =?utf-8?B?cllVQmlkWjhJditIUmdqUDkzT3lnV1hsVEQyYlZSdTFXbVpoNTdkaWVLV1FD?=
 =?utf-8?B?ckZhVDg1bGdBM1k2NExKd3pGSTNUVnkwMEZMTmxrNlExVmJLeFYyT0pwODVX?=
 =?utf-8?B?UGVjbml0L0dtaDBwZ0d2aGJMd1RHU2h4VTY5UithUUNtYks1UTdrM3cvNENU?=
 =?utf-8?B?VmVqZFBwc1c2VENwZGVRR0dMa053eElweHlLTnFRNnNLS0dsY09PS1A3b2lC?=
 =?utf-8?B?a2g2a3BmcFUzMlhRYWQ0bWRNcVMyTTU5UWZRYnVPQ1YzQUFRMTBBTTd0QWt2?=
 =?utf-8?B?YitkUGxWaEJ1VC9YcnBFL2d0WUZ1cTE0NEU2Z2ZocnBFUXJ3Tjd4eEFBVzJH?=
 =?utf-8?B?N25YUG8zc3UvYzZsaHVuQnlvTGxsdTVsMFFtVEFsaFI3QVZvaTZiV2dnMlpP?=
 =?utf-8?B?cFNWSnBUUGUvYzdhVGNQTGVRWW5LQS91ZWU1azUvMTdxK1J0SXVQSHdNUDkw?=
 =?utf-8?B?WDBCbW92OW9nQWhqQk1URnZudVJ1Y0o3aUdzZVZaM1h0QjRaV1Irc0dGUVZ3?=
 =?utf-8?B?YkY3am0rV01hbEdqb3Bsd2dldDU5ZGg3RlV1bkFVZTlnZXVLeDFTNmxlSDM1?=
 =?utf-8?B?VWFLWDJvRGR0Q1NvUjNIMFJqaVc3OE9VMVlMZDJ6TldBUGpKN0MxSEhCQ2Zx?=
 =?utf-8?B?U0l1VmdHWGpkR0JZUk5VS0J2YTE3M05RblliSUVlamZRd3NmaDNicnJBbHh0?=
 =?utf-8?B?a00zK2lBRHI3eDhscnpna3pWWXFYRmhDamxMamV1V3J0RmJzWGlUbVZtWWsy?=
 =?utf-8?B?enNVM0NKZTNXRzhrNHpxUTBPTVA5dE85K1paaUk1VURkSHVPc2FGR0YvRFp2?=
 =?utf-8?B?bEFEM2JuL3IvR2hmTStlRDJaNUxDS3RUczVIM05ML1JaaE5MREFtVDZ4U2dE?=
 =?utf-8?B?WEcyOElGeFlObldmZFRsUDVpYm0xYVJCdG13ZFFTTkRDVEFlNFpnY1NCTWxu?=
 =?utf-8?B?ZEswTWhCeW43SjdNcHgvb1Uwb0l6Nk1hQ3JReFhaWi8yR0t0QnYzazJpOWgy?=
 =?utf-8?B?c0Uwb3h2KzJjTW5tOFFJa1phRExuTzc4cEtyWmhyMjVDanFGTEpJcER4SWJo?=
 =?utf-8?Q?T4QsCIUv/+xUW+bjXuOVEQkH0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42021ceb-7362-4ae0-8d30-08dbd41cebb5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 23:08:08.3246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1uFS5HZQvqaOdeyN6PYrmtIMoem5plMOCrbYVP2Di6GCQq3/wjGso1CizDkmzvRAWXGufWJmxH2um0l7kE8Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
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

On 2023-10-20 17:53, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> After partial migration to recover GPU page fault this patch does GPU vm
> space mapping for same page range that got migrated intead of mapping all
> pages of svm range in which the page fault happened.
>
> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 29 ++++++++++++++++++++--------
>   1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 54af7a2b29f8..3a71d04779b1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1619,6 +1619,7 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
>    * 5. Release page table (and SVM BO) reservation
>    */
>   static int svm_range_validate_and_map(struct mm_struct *mm,
> +				      unsigned long map_start, unsigned long map_last,
>   				      struct svm_range *prange, int32_t gpuidx,
>   				      bool intr, bool wait, bool flush_tlb)
>   {
> @@ -1699,6 +1700,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   	end = (prange->last + 1) << PAGE_SHIFT;
>   	for (addr = start; !r && addr < end; ) {
>   		struct hmm_range *hmm_range;
> +		unsigned long map_start_vma;
> +		unsigned long map_last_vma;
>   		struct vm_area_struct *vma;
>   		uint64_t vram_pages_vma;
>   		unsigned long next = 0;
> @@ -1747,9 +1750,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			r = -EAGAIN;
>   		}
>   
> -		if (!r)
> -			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> -						  ctx->bitmap, wait, flush_tlb);
> +		if (!r) {
> +			map_start_vma = max(map_start, prange->start + offset);
> +			map_last_vma = min(map_last, prange->start + offset + npages - 1);
> +			if (map_start_vma <= map_last_vma) {
> +				offset = map_start_vma - prange->start;
> +				npages = map_last_vma - map_start_vma + 1;
> +				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> +							  ctx->bitmap, wait, flush_tlb);
> +			}
> +		}
>   
>   		if (!r && next == end)
>   			prange->mapped_to_gpu = true;
> @@ -1855,8 +1865,8 @@ static void svm_range_restore_work(struct work_struct *work)
>   		 */
>   		mutex_lock(&prange->migrate_mutex);
>   
> -		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> -					       false, true, false);
> +		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
> +					       MAX_GPU_INSTANCE, false, true, false);
>   		if (r)
>   			pr_debug("failed %d to map 0x%lx to gpus\n", r,
>   				 prange->start);
> @@ -3069,6 +3079,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>   				       write_fault, timestamp);
>   
> +	start = prange->start;
> +	last = prange->last;

This means, page faults that don't migrate will map the whole range. 
Should we move the proper assignment of start and last out of the 
condition below, so it applies equally to page faults that migrate and 
those that don't?

Regards,
   Felix


>   	if (prange->actual_loc != 0 || best_loc != 0) {
>   		migration = true;
>   		/* Align migration range start and size to granularity size */
> @@ -3102,10 +3114,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		}
>   	}
>   
> -	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
> +	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
> +				       false, false);
>   	if (r)
>   		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
> -			 r, svms, prange->start, prange->last);
> +			 r, svms, start, last);
>   
>   	kfd_smi_event_page_fault_end(node, p->lead_thread->pid, addr,
>   				     migration);
> @@ -3650,7 +3663,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   
>   		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
>   
> -		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> +		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange, MAX_GPU_INSTANCE,
>   					       true, true, flush_tlb);
>   		if (r)
>   			pr_debug("failed %d to map svm range\n", r);
