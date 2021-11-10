Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05819C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 03:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8168610F7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 03:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B8168610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597316E114;
	Wed, 10 Nov 2021 03:52:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48E226E114
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 03:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+7KpSo6Qe/LuL+/4LWTEiqGI3KzXBveBTB+xvnPQGfMBG21g8iLLd++BJKK+n2Yk/Q6WkZPQCd87af1CPoGwlew5Bez6Xt0CzIg6d+o2AkESBcxarDXpHsIwpQHvIdz5+619NrFdOAIzY0bHCOpPg6cRYbMFnOu3ncIelwBAh7FnyA59KBHPqHeUtbEjREqnLYWpJ3Y+AoSiRad+q8ohbdC2sCCjdn5Yq0vzsadLZIfYtALClRmJ+kH0bILiNAfhoZl5dY39KOoOLxgFqdyjXkIJc9XELLJGueSoypaf98ATFowgf2xyDx266Gtdy+8X/7MdscWTPvFa1XL8U3uBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcRkXxEetemXMMsArPJGnFG3nOGdO+lMILcjE6EuFpo=;
 b=dAwTKIDaRPyhAez1moXYX+yq9VTSGCejj2GcXHDtNmgqtbAN727Gp1wCyR3fp5uyCUCykTA1hDEVQvgtvcxQi2bgbmYyKdfX6cLrQxJi+447U8SjifIPL7Sf9IlIq6nnqHd3xdCiBB7yot1k1R1AvK2U08/abu03Rblhh/vQt3IND0Z+7bdkpRNhDxqnYCgCtmodekBPewW9RXJlo8a6wx9nplQ8AfHOIBl600y4cN+xoRuwy5zyI/pQALW64aNiXVEXx2AegbXf0lhazYyXzBeM+G7d8X7kcBOORy2Jmlw9jf/eV/D040ZKPL0uQ26VyPfn11tGjnM30rhx6239/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcRkXxEetemXMMsArPJGnFG3nOGdO+lMILcjE6EuFpo=;
 b=XuR8pRjqNNWVOP9hR/MX5j0Fktj0PYvGLBFnOr9Bjo/yH/PwTGJ5Ngjp93UAWwelrLTwDCKHYM2cARDZ12b3tp1eH4LMUbwhsa7Vx8LZk2SidTyVgkd4vsDXf9j/jjRBe3NAlXZIMSJXKajKxHNJXnbQpGOTYmz3m8dAYN5qz3E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 03:52:36 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 03:52:36 +0000
Subject: Re: [PATCH 3/5] drm/amdkfd: restore pages race with vma remove
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <20211109230432.3947-3-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <39cec154-8fab-0912-545b-2bc6dd0260ae@amd.com>
Date: Tue, 9 Nov 2021 22:52:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211109230432.3947-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: LO4P123CA0124.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::21) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 LO4P123CA0124.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:192::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16 via Frontend Transport; Wed, 10 Nov 2021 03:52:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf360a4b-a83e-4af4-5d4d-08d9a3fd8843
X-MS-TrafficTypeDiagnostic: BL1PR12MB5380:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5380DD38500AB6D81800A0AD92939@BL1PR12MB5380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGTIWvAKZu2Se9ZJ7C5XZq6c1am2JQQOgqDrRxR5BzCVNL1CNWewz0+2hNM7INprQxBXFLFFuRURTy2dTAaVovBY02gztwO4jtQiYOsW6SqWBiY542D9AebAKarmgUO/6pTaSoFsdWOmcVCulqq8AnJlLt7v7QJt7V9nXP4uzszcopFYfsdz4o5cKvCBc/+sGMLRVay9QdeyYd53LwLEFg3tkfsPeEwaclJm/MvO5IEEiC2HHxghPDplXOXWD5QarXYX7lNzm7P3qLfkRMgaywuOZfSqQt8YNoFqLNmpc6AsbMH+LRLVNrMeJ4jB00ZDa//ntCiXbsr6xd7fI/YZOMkmnsX7YiT7NxyBVI/EMtdHHX+82tfDlxbgN4LO/DJ5kom4AdCHwPJGEGhbJZzvSKAm+Zh9c91HkuM102vKWagh0zFYzPe4x01CMH64AQ/yMP2Dk5h2OWzg80KHlJs59DiywqHV34jvQJO/DIqlK5jet9YqTTixCDPosGKe/3vaUvhf2h8VFYvtXI3qsD+b40qvAx95vGR0bm+4WxRL8U8ZATQqYxSsyEo+6A8Pp9iuwMLWYF0khpOUQxKI/siu32Wb38el649ql120XNL5kTNlzjitYbsVmASPE4AAs6emR0tXKDqKfysdG6E94kRbJfZNT7gCBdZb3BGaVO7pWZpXMLj8hvh4/NZHP/TGKjLhlnxtmU5aVDu8DLzOfdwHY55em3PEZizhQsjRlaX0SOUfsmZLHRXjdpOFcikilEvB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(38100700002)(6666004)(8676002)(36916002)(5660300002)(186003)(31686004)(66556008)(31696002)(956004)(26005)(44832011)(66946007)(508600001)(8936002)(86362001)(316002)(66476007)(36756003)(2906002)(6486002)(2616005)(16576012)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUtSaTdaSVp4VlJUVC81dHcvZ3VJam5HTjF5ek9HcXlYMCtHTWlva0gxcUJp?=
 =?utf-8?B?a3hGMjZ5NDdKeUg5RXJvcGViY3dxWlRjL1pka2llSU13VnRnSGIwRUhTN0h5?=
 =?utf-8?B?WC9iWW5BS25GMmlTdUoyQzJIWmFYa3pCSCtNNUNoUGV0NWpuY3RIOGpFRm0r?=
 =?utf-8?B?UDhhbjJ4M2lHUFdocFV4US8xLzZaTWsyaXRoc3U3WnBCSys3RlZxZlgySFV1?=
 =?utf-8?B?N3pYQTJqYmMrMjFFWk5iL0dRM0hMUUp0WEFjNlF1MjM2VEl2VlQzT0lnRkpv?=
 =?utf-8?B?V2Rlb1JvNGsyNmlDUmNzbysyTVN0TjhHY3crRnY4QXlFeTdSMDJrdkU2Z2dK?=
 =?utf-8?B?citGM3ZadWhGNGQ4U3o1N3duVWtaK0pFY1hDbWRkMi9CNVdTZE0zanR3angx?=
 =?utf-8?B?dUZ1YW40Sng5Mk9vckdIdEVpSlczZmo2VVZGaThqVGhDeVYrK2pqV3hBRjNl?=
 =?utf-8?B?bXBQQUJXYmIyZkZTam5WeFRJSS9heWcyQ0lDQzRsWTJaRytSVjRHcFg3UVVZ?=
 =?utf-8?B?VWV0VDVKWHg2bG9YTjZUdEhYUU5TSCtsK2FJUE9JQ24rQi9CcFBoMGxNZ3Fw?=
 =?utf-8?B?Z0xldTVmS0k4QWFHcVpyTzdOakg0bkNqSnlKU0RvdjA4dGpFQXIrbW9pZVhB?=
 =?utf-8?B?MnMxMUs2RXBqQlZhT0lOb0xDUjJyOWZrRGtUNm1GcGdYVk1jTUtuUzdpWDUy?=
 =?utf-8?B?UHJJRmU3ak13T3ZacUZ1aGJsMXRQTk91cnRQYnRlZGEvRnBSL1JNV2dvaFBM?=
 =?utf-8?B?Y3pHaWNvMDhIMk9yaFlWcWZvM2s2NkJPMDNueUJ5OWU3SFkrUFN6RndxNEFo?=
 =?utf-8?B?Sk0xeXlDeHlaOWUyOTVaWEZvT25RWjFIWnlzK20vakNxU3NoK3JFMkprSk05?=
 =?utf-8?B?RGFoaXg5cXdCWC85TUN2UWpSYy9JYkZmUTJ6d3hET0dpMkprNUVzUkR4RzJw?=
 =?utf-8?B?end4eXdwRzI3TElVL24ydjVtVE1QMWhWTjBNNzFlejVTU2lZV1NZdWRTQmxJ?=
 =?utf-8?B?K1N0Z29tMGtzUGVxYys3b1A0Z1Q2cWlaTktSUUVncFNpTE5kdHFxSEpBR1Z0?=
 =?utf-8?B?bkw5WnI0MktSY3FzOHhhbFhHMkx3Zy84RjEwdkoxSWVadW9PT0NzVWtRc2JQ?=
 =?utf-8?B?NVRpam5lYmhXTVltSlpTVU1jTkpHbDFKOElIRUJKTGYyTjRxSndtL3BRcmFu?=
 =?utf-8?B?cFlFZktDYnN2bWJHTWxHNUVHMElyRjRnWHdXOFNiNGxyUEhOQ24rbXlNV3RG?=
 =?utf-8?B?bkpCRytnWFdJaUtUdENQcTZzRjRFSU1wRHFNcnZFMEtDajVmTGZsMnk3K3N0?=
 =?utf-8?B?cUY3WnhVbko4ZFhadWcrWlNNWnVtN2F3MlQ1cDRlNFhYakxaN1hGaVl6ZnV2?=
 =?utf-8?B?VExKYm8xRUJsMklzcWtzRVBxZzhLM2FMRndZcHdHOHV0bVVpQVpabW5UZWk5?=
 =?utf-8?B?bzRFL2FZZlVmWTFTTzl6OHZLNWlOTVlobEJlM3RVY1lLR2pDdmZiWVk3elBO?=
 =?utf-8?B?dnJOMFJPM0FsL1dQaC85ZnRNbGxsdURyYURVVmU0V1RsVXh4ZUN4dFJxYlNz?=
 =?utf-8?B?Q2hhRmxCTmJ4M2hwSytHYnhmQ0RKQkFzdS91bFl6RDZlM0pPYTF6Nis3c2hG?=
 =?utf-8?B?N05wMGo4ZlJnbDdvQjV1MVc5V3FNbFczMUZja3FIQU5jdktRQ2xjK3RWRDJR?=
 =?utf-8?B?WVl2T2M1eEdWWVRxd2NtUmJoUS9EUUdUMXBvakQyMy9mL282MmJ1bVlnUDRN?=
 =?utf-8?B?WWNjSExuaTFXV2VoLzZDWGMxd2YwL3hseC9wM283U0h5RW1id0o5V2RMZGY3?=
 =?utf-8?B?ekdZSXBqZVd2V2UrYnNOTDhVdXhSM1AyRW5SaXhBQnlxZ2prZ3pRaW1tMlFY?=
 =?utf-8?B?Um1qT0NLUEIxeGhoRE5LcWpDMGowL0tLc1p2VS95eVJSbmhUV0ZSQzFLSHNF?=
 =?utf-8?B?OCtGT0Z2MDdGdVU1a1lqRXlQSkhVZ09FZWZtYk9YU2FQTml0Qmc1S21wNjZU?=
 =?utf-8?B?c0VmNnNMUUhkT3ZLSlBrTlUyUTdHZ1h6OGJoZHR1ZEowK0I5TXh1RWRPenRV?=
 =?utf-8?B?Ti82cE5ncGVlNStZcnpTN2JlTEUvZmIyUXArQi9zMEtkS1NUMUNrTWN2Y25h?=
 =?utf-8?B?aWtSYXlpQkpQc0Y4ZmZEVEd2UkVYVWpmZnRvR083azJWV0JsUkRTM052bmg5?=
 =?utf-8?Q?pooeWMLgQbluJIZGaGGgyEs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf360a4b-a83e-4af4-5d4d-08d9a3fd8843
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 03:52:35.8970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNPQ89bxe44TVMpwtB52y1fjlWzvrzBKaKACYLcxdrKdUTBz83t9u7/bawSAmh6Z52LaoTfGnjET9xEFvHEEwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
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

On 2021-11-09 6:04 p.m., Philip Yang wrote:
> Before restore pages takes mmap read or write lock, vma maybe removed.
> Check if vma exists before creating unregistered range or verifying
> range access permission, and return 0 if vma is removed to avoid restore
> pages return failure to report GPU vm fault to application.

Your patch basically means, we never return a VM fault to an application 
that accesses invalid addresses. The application will just spin on that 
address forever. This basically breaks the debugger. I think you need to 
refine that.

While draining faults (svms->drain_pagefaults is set), I think we can 
return success if no VMA is found. During that time we are expecting 
"straggler" faults. But once the draining is done, any fault interrupts 
we get should be from bad application accesses and should result in a VM 
fault for the application.

Also, much of your patch seems to be refactoring to avoid a duplicate 
VMA lookup. I'd split that into a separate patch for clarity.

Regards,
   Felix

>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 64 ++++++++++++++++------------
>   1 file changed, 37 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 64f642935600..8f77d5746b2c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2336,20 +2336,13 @@ svm_range_best_restore_location(struct svm_range *prange,
>   }
>   
>   static int
> -svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
> -			       unsigned long *start, unsigned long *last,
> -			       bool *is_heap_stack)
> +svm_range_get_range_boundaries(struct kfd_process *p, struct vm_area_struct *vma,
> +			       int64_t addr, unsigned long *start,
> +			       unsigned long *last, bool *is_heap_stack)
>   {
> -	struct vm_area_struct *vma;
>   	struct interval_tree_node *node;
>   	unsigned long start_limit, end_limit;
>   
> -	vma = find_vma(p->mm, addr << PAGE_SHIFT);
> -	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
> -		pr_debug("VMA does not exist in address [0x%llx]\n", addr);
> -		return -EFAULT;
> -	}
> -
>   	*is_heap_stack = (vma->vm_start <= vma->vm_mm->brk &&
>   			  vma->vm_end >= vma->vm_mm->start_brk) ||
>   			 (vma->vm_start <= vma->vm_mm->start_stack &&
> @@ -2444,9 +2437,10 @@ svm_range_check_vm_userptr(struct kfd_process *p, uint64_t start, uint64_t last,
>   
>   static struct
>   svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
> -						struct kfd_process *p,
> -						struct mm_struct *mm,
> -						int64_t addr)
> +					       struct kfd_process *p,
> +					       struct mm_struct *mm,
> +					       struct vm_area_struct *vma,
> +					       int64_t addr)
>   {
>   	struct svm_range *prange = NULL;
>   	unsigned long start, last;
> @@ -2456,7 +2450,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>   	uint64_t bo_l = 0;
>   	int r;
>   
> -	if (svm_range_get_range_boundaries(p, addr, &start, &last,
> +	if (svm_range_get_range_boundaries(p, vma, addr, &start, &last,
>   					   &is_heap_stack))
>   		return NULL;
>   
> @@ -2558,21 +2552,22 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
>   		WRITE_ONCE(pdd->faults, pdd->faults + 1);
>   }
>   
> -static bool
> -svm_fault_allowed(struct mm_struct *mm, uint64_t addr, bool write_fault)
> +static int
> +svm_fault_allowed(struct mm_struct *mm, struct vm_area_struct *vma,
> +		  uint64_t addr, bool write_fault)
>   {
>   	unsigned long requested = VM_READ;
> -	struct vm_area_struct *vma;
>   
>   	if (write_fault)
>   		requested |= VM_WRITE;
>   
> -	vma = find_vma(mm, addr << PAGE_SHIFT);
> -	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
> -		pr_debug("address 0x%llx VMA is removed\n", addr);
> -		return true;
> +	if (!vma) {
> +		vma = find_vma(mm, addr << PAGE_SHIFT);
> +		if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
> +			pr_debug("address 0x%llx VMA is removed\n", addr);
> +			return -EFAULT;
> +		}
>   	}
> -
>   	pr_debug("requested 0x%lx, vma permission flags 0x%lx\n", requested,
>   		vma->vm_flags);
>   	return (vma->vm_flags & requested) == requested;
> @@ -2590,6 +2585,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	int32_t best_loc;
>   	int32_t gpuidx = MAX_GPU_INSTANCE;
>   	bool write_locked = false;
> +	struct vm_area_struct *vma = NULL;
>   	int r = 0;
>   
>   	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
> @@ -2636,7 +2632,15 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   			write_locked = true;
>   			goto retry_write_locked;
>   		}
> -		prange = svm_range_create_unregistered_range(adev, p, mm, addr);
> +
> +		vma = find_vma(p->mm, addr << PAGE_SHIFT);
> +		if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
> +			pr_debug("VMA not found address [0x%llx]\n", addr);
> +			mmap_write_downgrade(mm);
> +			r = 0;
> +			goto out_unlock_svms;
> +		}
> +		prange = svm_range_create_unregistered_range(adev, p, mm, vma, addr);
>   		if (!prange) {
>   			pr_debug("failed to create unregistered range svms 0x%p address [0x%llx]\n",
>   				 svms, addr);
> @@ -2663,10 +2667,16 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		goto out_unlock_range;
>   	}
>   
> -	if (!svm_fault_allowed(mm, addr, write_fault)) {
> -		pr_debug("fault addr 0x%llx no %s permission\n", addr,
> -			write_fault ? "write" : "read");
> -		r = -EPERM;
> +	r = svm_fault_allowed(mm, vma, addr, write_fault);
> +	if (r <= 0) {
> +		if (!r) {
> +			pr_debug("fault addr 0x%llx no %s permission\n", addr,
> +				write_fault ? "write" : "read");
> +			r = -EPERM;
> +		} else  {
> +			pr_debug("fault addr 0x%llx is unmapping\n", addr);
> +			r = 0;
> +		}
>   		goto out_unlock_range;
>   	}
>   
