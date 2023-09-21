Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F52E7D0A2
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 19:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA5010E605;
	Thu, 21 Sep 2023 19:32:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4BB510E603
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 19:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BN1LIRQfsTfCwSrmdfVQBezea+IgBhY1xaOnUK08U38BCMQkehKor2bSGPb9wfLHEdbM94G1WdRdHqqIhBjJGs+uaZ+dcjG/KpCVEmQJR6L8yFzs567LQmAeE1eQWt5kKeky3uH7v/hXoPLQ9fS59Ltq4/7vetYC9+FOhmrOV4NVjjWopy3kl40043mTTpVJ12ziKs95D8qRbEnqSipz4wR+wXHjtHLtmXOEjhJUcPFDA3e5r5cIhlO7Tx/JFKfUv2eyJZYfQvOFQf3NIPBLZsSJHios8Q/WriDbSfxVqRzEJLdQj0qX8ice9/FBxmYuaTm0BTD0b4BAJdi12mIcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6VFRuom8LO1vFP4XwlM0zUJkOnES2H2lJkYm5RV3Xk=;
 b=Jo8UfEu6vbEHP7U7DJTqJlrS/aOx8/XU985zXVCOV/vAEjECjIQNeVNCTWclAquFEAdCtSGMqW4QYFO4kNkIV2wR9he2e5gYKxkoxULl6Rv/vodqoGrEimO8Xrr290mp1hvlP0TSWrnJtcYLfleNtIqPto/PX2CHUkJPli2z3Upx6JgD3TqFyOKfph0eNC0yGBHXtXVQXqtZ+wJyWQ0NMe7sT3t3hEq1Qf0H4t3n4tkor4PFSqy1Orrp/Mibjq7Lxol5Fc1TTLa4rgz/izgC//AZMnDLBDsH8tu5FXDTICJtlvxfmya5kyUb58JSgrjtLw1H8yFkgKUQ4bdAu/PgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6VFRuom8LO1vFP4XwlM0zUJkOnES2H2lJkYm5RV3Xk=;
 b=4SJy56wzy8aXS9UwoeeBBaTu3iuTKGtmez1R09OKkfunbH7zg+nCYuaLujEcr27NjtQzz1EeaKI0oSiX/v+o1osTgOHyvSn0+gfErnXSAEUGaPYmwfcttOop2hA3JmXs9X1PvqRqHfLhmUT0oe89i3LIqzgVdck1Ylnc24ocH+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 19:32:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 19:32:53 +0000
Message-ID: <f4bd2a03-638e-2921-c223-d4e57f0500ec@amd.com>
Date: Thu, 21 Sep 2023 15:32:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] drm/amdkfd: Handle errors from svm validate and map
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230913151617.18894-1-Philip.Yang@amd.com>
 <20230920154530.18588-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230920154530.18588-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 69296bea-8fbf-4bd3-7f8e-08dbbad98cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRbLIhHWscy0xAnA1/xp7uu2TcwHhcZv6EJB1cGtindJ35kRhDhlMX9qci0bnl7Kv/56L/X5Vu8jeUIvvw5GTmUwXVTBNWc1bzbD616qMtbVJHBiTunDHz5W02c1XQ+GFk9lFcBDrnXUMsKZupM5FlhuNp5FTAW5M4HvksiwZIWT800Z1aBngCP3v0WtLuVob8bCKIdmwsTYMGcw/hfcEyLCXl4u1T3pumyppTtXsvoaI+BMjrDq70U1Kg0x8chG/KIV8dzO8JpT+il2Hu/upxt9u2WjJ/Wx+7+6lBmqDZ7NESED3OLDck931W9azfYLrk7ACN7vFAviDxBR1rdo0atB+MYexp58FFc9NcGBhFnFwVpSiwwVk6m1/ThstzzfeuUtSPbBvQEHv6eqmMpyB0huv1ahEoakqKRrMwpd9iQ7/mFeVQJpbfs3g12RJGjFJ5hdE9+CCCd/sNhJZhx81QF+eKKvDzsej4nN1STkc7+yFnVdSgGrNdtBeE2CH2fSBtjPDRVVA3jxmDQ20PWINnJl2P/IYsIJAABJt1zPG7hbr1Qxdxs5zcd9PXHF28jHd1kOhNrlZbVYCrfZX99jNrMwqW0emtR7cXfTcPsGIuNvjFSy1fowIn/fhbpzgNS5YP4ftRwKL8R2NBVfRUECtZus9x7LPgbGFKWfvfUi9ZaQnGHG8LXk3dlOrdlDnQ1D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199024)(186009)(1800799009)(6486002)(53546011)(6506007)(6512007)(83380400001)(478600001)(5660300002)(26005)(2906002)(2616005)(8936002)(66556008)(44832011)(66476007)(4326008)(41300700001)(8676002)(66946007)(86362001)(15650500001)(31696002)(316002)(36756003)(38100700002)(31686004)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0xibnU2c1k1RThQT0tSL0hpK1VpdDhSRkt1NFRWakJZYXdsRUYyRHdvRUZm?=
 =?utf-8?B?Mzk0N0Y3bDV6WlpGM0k1M2MwZW5UNWJTdVk4Y0dyN3lZN1hJaWl5SzRYZ3RT?=
 =?utf-8?B?U2hxWkVzNnZSdFhLVzJpRXdBMWl4M21TaE9xOUYreGJYS1N1SzN2T3JzeXpr?=
 =?utf-8?B?a0NKWGlISTNlS2QvZUxUWERBVjQ5enNscUhOa094ckp4Y0h5ZXZmdEVBclhj?=
 =?utf-8?B?NllzK0xKNzRhdFhwOU5yTkdpdCs2U3hpRU8vV2VRSGpkZDExL0ppUzJvL3JI?=
 =?utf-8?B?SzdsR0QvL1lpa0tKOTA4MkhJbzhMSjl6U0lzUGU3YlZHdzBoYU8veGlFK1U1?=
 =?utf-8?B?a2hwSHlqZkxZOUt2TnNZT3dqcld3YW83T3dRTmtoK2grYXppOFYwQ2p1SFpE?=
 =?utf-8?B?b28zSUdRMi96RnBhcU96di9vSm5aalY2bHNQSndlWitJWXp5UkhiRk9EM1FR?=
 =?utf-8?B?NXlBRHFEaEppT2FiRmZUM2JSUXJkN25BeDVIazRwRmh3akhCQUtRc04zMElC?=
 =?utf-8?B?K1ZEUE9HTzlVY2RSYlBscVRzWWxta3NrWFQ3UW1BUnBIbTNjWlRQSjVxb0xH?=
 =?utf-8?B?MkRyU0hENVhzTTBFWndQTDgvdW1mNGdrVGZmbDVTZmpBZkVHeE1QZEViMDFv?=
 =?utf-8?B?dlIyQkc4VnlIWGpkd1hIV3BkMUhNa2YxVFJDb1FHbjNzd2lLZ1ZOUzliK2k3?=
 =?utf-8?B?YWs5LzQ1SHpvK2RnQzVFeHArRjNtZ2pxbzEyaEFJTHEzOGw0Y0tFbkZUeHFr?=
 =?utf-8?B?eFdNbTJDVk5ab3lmTEZuRTI5dE93bTVEUFRhOGxyYTFJakJDeHpLeStGL1Zk?=
 =?utf-8?B?RkZTOHBTNy9wU2VZRUh5VURTMmpkZmx6M09SNklabWVMZ1hvRmZQWXIzaWxU?=
 =?utf-8?B?a1lEeGd4S3pJdm15bzFrejc3d3IwT1FCa1VWZWxGVEw1UlhWeS9QNHl3REx1?=
 =?utf-8?B?ZFIrQWNFY3N3ek9pWVgxWm1PQmdNL3NERElRaFBVd0FaRTdXNHVkb2VzRE9v?=
 =?utf-8?B?TzkxNlEwTlNtbzBHZFJkU0djaVJrSnFtVzhUVXJvbklaMVV6ZHJoQzFVU2Fi?=
 =?utf-8?B?KzhyT25ETFI1bTZuTjVTU21kK01oa0QyZ1V4SUJoMmdFa1A3VXlTNHIrcW1S?=
 =?utf-8?B?bXVPQ1krdXpkZUpLcFdYL2NteVVzdGZoYUFqb3REMlYxRlN3Ly9nZ01BYTNT?=
 =?utf-8?B?TGt4eVp2ZjhScTczVlpCbmxqcElOM3ZlV2ZqOTd2c1FGSmhoUjNlL05WK2c4?=
 =?utf-8?B?UG8vKzdxNVduL2VhS3dXVkdNRHNhVlhVZklIL0kyWUVQNHZqaVIvTi9XUWNL?=
 =?utf-8?B?YUJCTElZcFJDOC9DSmpTSVpvR3l6QVFhZ0hRTG1zeWZLTzR0OCtWREx1VDlz?=
 =?utf-8?B?dGp0aWk1bXZhaWRkTTU0dmRxS3A2eW15M05ZSG5xd0pRVlJMZ0NyeUJuandv?=
 =?utf-8?B?eWRadW40R21HVGpsODFJUS9GVmRPVG11WG9JeTBncG96dUhTRFF6L1JpWlN2?=
 =?utf-8?B?aWlaVks4eURHRTRUbWFqZ0lzdGdoVGo4TTdGZ0l5Z3BpTlExbUs0K0FBQ0dM?=
 =?utf-8?B?NTVXbzZFTmtpZkNEbi9qNlhVc24zcHQ0cEpNU1FGUDBPU0pGRFNVZGJsSjFl?=
 =?utf-8?B?U1dLNkJPYkFnWW4xbzZBZVJkOWc3UCtVMWFJWnUwcW5zTUVVUXY0NUFMSHFo?=
 =?utf-8?B?b2VJR1FmZUJ5OGYyOU9rUTAxeS9idWg4U29Vc2s5UkZqdThzdmlzM1kzWk12?=
 =?utf-8?B?MDhiUks0NVF3QWRzYnlFNzZpdVdPdWY4WGpsczRqUmhIK1p0NFBDVDh3UkhP?=
 =?utf-8?B?aElpZWZJNEQxcFBYVS9PSSsxNkMyU29vTE01RlAwMHMvWkp3OGpYcks4RTdn?=
 =?utf-8?B?TU9VOHVnUzZFeW5tKzRWZWE2OG9oUlBpOEdHdjIrTGxzNFNyNFNoWXkzOHV2?=
 =?utf-8?B?SllXajYyVkxZSGRxQUcyOGZwd3JKQWZnZ3ErZWVaKzZmdWY1Tm9hM3QwLzVO?=
 =?utf-8?B?Z1hyTGxuMWxYZ0hzYkh4ZGlWdE43RllKVlR4TkliSlhhSE41MmdHMENxU0RC?=
 =?utf-8?B?Y2laVlFlOHEyQy9WRExJOCtXMWdMS3NPN05mSml0RWQrS3g1VXJtckhnRmhX?=
 =?utf-8?Q?5Lj8askLdft1Vufdv4DyKY9x/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69296bea-8fbf-4bd3-7f8e-08dbbad98cb9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 19:32:53.6445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Mqpp9a3Zc6olel8AZw1G+ZBVzA/LWsRk27B81563PyGxN9KWIXdDuBl5mmwf3j4OUA3cHVmIZS2USKJIB+pGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
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
Cc: alex.sierra@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-20 11:45, Philip Yang wrote:
> If new range is splited to multiple pranges with max_svm_range_pages
> alignment and added to update_list, svm validate and map should keep
> going after error to make sure prange->mapped_to_gpu flag is up to date
> for the whole range.
>
> svm validate and map update set prange->mapped_to_gpu after mapping to
> GPUs successfully, otherwise clear prange->mapped_to_gpu flag (for
> update mapping case) instead of setting error flag, we can remove
> the redundant error flag to simpliy code.
>
> Refactor to remove goto and update prange->mapped_to_gpu flag inside
> svm_range_lock, to guarant we always evict queues or unmap from GPUs if
> there are invalid ranges.
>
> After svm validate and map return error -EAGIN, the caller retry will
> update the mapping for the whole range again.
>
> Fixes: c22b04407097 ("drm/amdkfd: flag added to handle errors from svm validate and map")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 80 +++++++++++++---------------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
>   2 files changed, 38 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index fb55cf80d74e..0b6a70171320 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -827,7 +827,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
>   		}
>   	}
>   
> -	return !prange->is_error_flag;
> +	return true;
>   }
>   
>   /**
> @@ -1680,7 +1680,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   	start = prange->start << PAGE_SHIFT;
>   	end = (prange->last + 1) << PAGE_SHIFT;
> -	for (addr = start; addr < end && !r; ) {
> +	for (addr = start; !r && addr < end; ) {
>   		struct hmm_range *hmm_range;
>   		struct vm_area_struct *vma;
>   		unsigned long next;
> @@ -1689,62 +1689,57 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		bool readonly;
>   
>   		vma = vma_lookup(mm, addr);
> -		if (!vma) {
> +		if (vma) {
> +			readonly = !(vma->vm_flags & VM_WRITE);
> +
> +			next = min(vma->vm_end, end);
> +			npages = (next - addr) >> PAGE_SHIFT;
> +			WRITE_ONCE(p->svms.faulting_task, current);
> +			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> +						       readonly, owner, NULL,
> +						       &hmm_range);
> +			WRITE_ONCE(p->svms.faulting_task, NULL);
> +			if (r) {
> +				pr_debug("failed %d to get svm range pages\n", r);
> +				if (r == -EBUSY)
> +					r = -EAGAIN;
> +			}
> +		} else {
>   			r = -EFAULT;
> -			goto unreserve_out;
> -		}
> -		readonly = !(vma->vm_flags & VM_WRITE);
> -
> -		next = min(vma->vm_end, end);
> -		npages = (next - addr) >> PAGE_SHIFT;
> -		WRITE_ONCE(p->svms.faulting_task, current);
> -		r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> -					       readonly, owner, NULL,
> -					       &hmm_range);
> -		WRITE_ONCE(p->svms.faulting_task, NULL);
> -		if (r) {
> -			pr_debug("failed %d to get svm range pages\n", r);
> -			if (r == -EBUSY)
> -				r = -EAGAIN;
> -			goto unreserve_out;
>   		}
>   
> -		offset = (addr - start) >> PAGE_SHIFT;
> -		r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
> -				      hmm_range->hmm_pfns);
> -		if (r) {
> -			pr_debug("failed %d to dma map range\n", r);
> -			goto unreserve_out;
> +		if (!r) {
> +			offset = (addr - start) >> PAGE_SHIFT;
> +			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
> +					      hmm_range->hmm_pfns);
> +			if (r)
> +				pr_debug("failed %d to dma map range\n", r);
>   		}
>   
>   		svm_range_lock(prange);
> -		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
> +		if (!r && amdgpu_hmm_range_get_pages_done(hmm_range)) {
>   			pr_debug("hmm update the range, need validate again\n");
>   			r = -EAGAIN;
> -			goto unlock_out;
>   		}
> -		if (!list_empty(&prange->child_list)) {
> +
> +		if (!r && !list_empty(&prange->child_list)) {
>   			pr_debug("range split by unmap in parallel, validate again\n");
>   			r = -EAGAIN;
> -			goto unlock_out;
>   		}
>   
> -		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> -					  ctx->bitmap, wait, flush_tlb);
> +		if (!r)
> +			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> +						  ctx->bitmap, wait, flush_tlb);
> +
> +		if (!r && next == end)
> +			prange->mapped_to_gpu = true;
>   
> -unlock_out:
>   		svm_range_unlock(prange);
>   
>   		addr = next;
>   	}
>   
> -	if (addr == end)
> -		prange->mapped_to_gpu = true;
> -
> -unreserve_out:
>   	svm_range_unreserve_bos(ctx);
> -
> -	prange->is_error_flag = !!r;
>   	if (!r)
>   		prange->validate_timestamp = ktime_get_boottime();
>   
> @@ -2113,7 +2108,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   		next = interval_tree_iter_next(node, start, last);
>   		next_start = min(node->last, last) + 1;
>   
> -		if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
> +		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
> +		    prange->mapped_to_gpu) {
>   			/* nothing to do */
>   		} else if (node->start < start || node->last > last) {
>   			/* node intersects the update range and its attributes
> @@ -3526,7 +3522,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	struct svm_range *next;
>   	bool update_mapping = false;
>   	bool flush_tlb;
> -	int r = 0;
> +	int r, ret = 0;
>   
>   	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
>   		 p->pasid, &p->svms, start, start + size - 1, size);
> @@ -3614,7 +3610,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   out_unlock_range:
>   		mutex_unlock(&prange->migrate_mutex);
>   		if (r)
> -			break;
> +			ret = r;
>   	}
>   
>   	dynamic_svm_range_dump(svms);
> @@ -3627,7 +3623,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
>   		 &p->svms, start, start + size - 1, r);
>   
> -	return r;
> +	return ret ? ret : r;
>   }
>   
>   static int
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 5fd958a97a28..c528df1d0ba2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -133,7 +133,6 @@ struct svm_range {
>   	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>   	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
>   	bool				mapped_to_gpu;
> -	bool				is_error_flag;
>   };
>   
>   static inline void svm_range_lock(struct svm_range *prange)
