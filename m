Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E87CE7A81
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 13:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA0B710E250;
	Mon, 25 Sep 2023 13:39:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47EBE10E250
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 13:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L41PXQCt84CfpShbYgSgWroPovbsKhUeDPba76Bd9EvYoN2J84OcnLXMpnG1U977Q+10EHNrj8b60LoBb7iIKo39ZQQfqPpupMsd4+Czu21PFOn7XmwW3/5JmxBY6LTjLXbcl6HeqvuhlLilIaXFbVDSYetO+wHIXGCGnyi6bxUSNMl6msTOkbh5XLNSy9OdRuNUFp1evBXSWsx/w5kwll70KhPA9sikcdSaYyby76IMNC+6L2YmpRaDNlUBPepdX7hei8cNhSnNZDVs1qXt7Mi6CBMQQrW5juI/64v/dXieAGVqCA4vARyNLJsNpUgAPi520wGe9OR3ZSBhynelXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22G0RwwF33fAh6SCyVZQKpirHqJJXxyE4yWaotkvnUw=;
 b=eoUKNHwC0QjkjMh+GJdkWXvx8TeTRczSRHjDy6SJCuTBzYGgd37JemjtI8bXBnKkFr/kqEni8Y+U0TJLbI2w9Vgn2fKulH3R525uvKa5KIYYXjfB90SnVYwNIbTTkIBwkh20nE5M1BH2VLjOEWhbcWVRD9oYy52l3xwhj0IEOnNzbxcgNx9Gr0Ir95dHPS6RtslhyarLSGSQV3MwxTszXaB07jNaXZil2SxuUuWMWfv0EIxOro5CM8iCWDGLPNJZjhITFb9kgbJycYFIAKJ5kiRZJ6oSOXUrn8o1z9KB/sv8tsO3p64EABiLkSSrark9TB/S6a3ZbQq8f7px6scSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22G0RwwF33fAh6SCyVZQKpirHqJJXxyE4yWaotkvnUw=;
 b=KJhOOM/6lHaTz0lfyzVjBDgqSkU9/R856anZyHlid4zd2fyWogFq3qlP4FxKYNzds9pM/LFNDKfnDkvghKd0gNUv+4+F+0NH2i0gZe0vG2loE9orvasXfHF1DRRMlIgzmvod65Mu/+4PUpoeHurI4NukdRCgm4biBasLbkXYB4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 13:39:29 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::5e5d:f37e:a350:6ae]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::5e5d:f37e:a350:6ae%3]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 13:39:29 +0000
Content-Type: multipart/alternative;
 boundary="------------lJlpu11gu6WJHj3slqCDQJNv"
Message-ID: <f1f4748a-fd05-339e-01a4-d1eae0541207@amd.com>
Date: Mon, 25 Sep 2023 09:39:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] drm/amdkfd: Handle errors from svm validate and map
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230913151617.18894-1-Philip.Yang@amd.com>
 <20230920154530.18588-1-Philip.Yang@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20230920154530.18588-1-Philip.Yang@amd.com>
X-ClientProxiedBy: YQXP288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::38) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 499e29d1-8a67-49d9-3857-08dbbdccd7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCbB5CgP5qMPkYz6DNu0kVyIoEKJVeX+9V+sIzg6e/Z4tVqjPa6+QRMDu5zJeoBu0jj2wsAYI44QCH63cFGef89aj745ri0V/6TwZsLIYCAWXgHJPSjuRdp7lrhiRFH4DIGQ0YqI+gv5EQxSV2ecp5QICqqLBjoZYHsQ9RwWXvrdLp5g7UspomPsefLJH1J+mrT07rcXSi/MwILuv8WtulLRyJhBmPw3gUSKCMLt+srsPUnEeal8+iMBKKbpPnksRmzorM7Q8tZA2K4EmrsAxO+w+UaJQo8rnpbg1cMEWGfJb/t1D7qJ4tnYGB2Uj/z6cfupii7LN0R2h/NxDRX26y4WvqgADB/L2BC3MTiC/VkPdgX43WCsYLctZwqLyTo/0ex/Si4cel2WMP4tYFLIjHIejQEDQR+lCIFyv7cU8hXdr8Nhbug/RFezYDh+zy/JjvSI4GGs8oKuryLBr3N6RbujxCNYmU2qlnCXe9AEOdEB4fPICmzgWckD03ZvFpMRNuzCeOfmYicY678rrNmhCQWgHn/3sLHkMYt4phU/0PEQ2PyJBNAKTDGySBgQcwknzm0ulqCsDDtuaQZ2MGrfoUuUE4cnTCFHFM2rAzXcqWJCtjUoP5YkIpCIaxgf2Izlo4O3NWXny0yLNVGPqLdKvlcuqcp0icM8oCcWGS6x9ecqQ04pYyFuZ7dQWFMUSnZK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(366004)(376002)(396003)(230922051799003)(451199024)(1800799009)(186009)(31686004)(83380400001)(2906002)(5660300002)(316002)(15650500001)(41300700001)(30864003)(8676002)(8936002)(36756003)(4326008)(2616005)(66476007)(66556008)(66946007)(31696002)(6486002)(53546011)(33964004)(36916002)(6512007)(6666004)(6506007)(26005)(38100700002)(478600001)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1o5d3h3QTUvdUc5aElzcXNjWW1BbjF5TSt3VmRDNklHSlNnak5BYlhabEcr?=
 =?utf-8?B?NlAyb01kR0NCRzZHY1ZRQTZyOGErWnR6Tk1iWGFpdnp3dTl6M2N1Sm4wVzZI?=
 =?utf-8?B?cDliQmVneFJjMTcyU1VOK051dmdJUDFlUmtxaFBRRWJmZktnd1JJNVNUdzJ1?=
 =?utf-8?B?T2IySWVRcGlPWEJoNnVpT0RFSmdkeWNueExkVFdkT0lMZERRaldiUTNVYVdD?=
 =?utf-8?B?WW4rWnV4Q29BS0d3NFp3cmVoRFh1c0svbGM4dSs3cjlsMnN1R1VkSFY1dlRM?=
 =?utf-8?B?NmNGeWlER3FsQ0c4ZEdOeGY3OWJaUGx0SElRcUZhQStEUWx2dFdRbERTT0d0?=
 =?utf-8?B?TGE2TFltOXNidERnZDRVbzZCV01mUWtSN2dMVkxJWStMcE1ERS9tQVkyUDFp?=
 =?utf-8?B?ZEZ0Qy9lTExERDJWNmdETStvSk9UTlV5cGpDV1M1L2wzaElBY3llb0lKZ3N3?=
 =?utf-8?B?d3hrMG5UcW5Nb21BTG8ycXVJc0c3V2dNVE9lVmJnazVPdVZvNlA2d2ppSzBu?=
 =?utf-8?B?aDNhMTFQcjBoalFZTTU5VUErZE8zTXM2RkFFRUxtMjBZSnUzcHgwaDJnZ1hE?=
 =?utf-8?B?eUYxM0ptbTBhbUI3RFA2VE95aWJyTjVpaTN5ZlZFK2JzUkNZMmJJcXorMXc1?=
 =?utf-8?B?QjNTSWZTWEwrR1BJOExTeEZxbllZTGhESHV6Nzc5MVVXUE9FbVpjZ25rRS9z?=
 =?utf-8?B?Q3FreldSck4zOFppNWZqR1M4QXBUM1FFd1V0dEZhT0ZJdGJFS3B4Z1hpbFNp?=
 =?utf-8?B?YXhjemxTeGMzcGpwbUJoMlR3ZDBzTnpEYVJXNERxRk51RnB1UGRIdFJQT1hQ?=
 =?utf-8?B?djY2NzlVbnRUNDBnWXM2aWhPSENwMFFkNzlQNTVhY1FudU9Vb2d0bG1EL1hz?=
 =?utf-8?B?NmFPSi9pZkZtb1NQQy9GazVxTFFleHBVSU5ZMHlBaWRZNGNTQ3pzeW1YbXdY?=
 =?utf-8?B?N3Rkc1FZRGtsWDRKSWhFUVdWZ2V1TjNGcmZROGszaEFaNzA5MzZEalJzaEI5?=
 =?utf-8?B?MjdxMDJPYVVsc3llR1pWZDN1VmVSNnlaZko2dkNuK2hNUG9ENUNYTlY5Qklp?=
 =?utf-8?B?YzFmQkdubDAvbHBpOGZETS90WitmQXgreFlOcERPMzVHc0tnSmgwRkoyUklB?=
 =?utf-8?B?b01GQ2ExNWlZbEY5dWhhREZFUkt1RHFqNkhYOTFtYzdDTEJtRUJzK0NSejQ4?=
 =?utf-8?B?L2FNbHhZa2ZmWStCUkl6NjBzS3FRQmx4UVhBWk01STlCYURnaWtVRFZIOUZy?=
 =?utf-8?B?UHN0aUNHRmdQYXg2NnZoZEllZTlGYkNmOXQwUGxRUW9YdmR4anBFQWVNREt6?=
 =?utf-8?B?SUx4RGJFSTArcUhoM0VHeHBHWWF6UitzSXpFUlp3YTgwZGhaNGIxdG9zYUE2?=
 =?utf-8?B?dVE0L0NkN0VwditweG1xd05xMlZOSzVuT3FsWmcrUjBDbjAxTTZaNVV4elFq?=
 =?utf-8?B?aU5OTzI2V1hCY3cyRzU1VWEyTXU0VFZINXBBS3VBSDl2d0tHK1BOZkR6cmQ4?=
 =?utf-8?B?QkRwa1R6aGsyS000MzJPaHBIb283NERLKzdMSml3b0FOMDZkTi9yRHI0UE1z?=
 =?utf-8?B?S1h1N2lYMW9EZXV3ejlxMHdvNU1PaElYc1hMNDVpMi8xUkszQ3I3bE5QaFNv?=
 =?utf-8?B?VVhsNUlQZDIxWEx1UXo1NVZha1Y3c2lzMk83WXE2bTRNYkVVVVJtcUFxWUFC?=
 =?utf-8?B?K0MzR3M0T3g4dXFNWGRMTTJaV2l6elZpWjRRMmFycmtwSmxnL3JWRjZDTWVK?=
 =?utf-8?B?SndDVVVuWEZMRGRZQkE5R1pzNG5ZYU1HK29FaldyTkJkU2dubGlHK25Ob0Uv?=
 =?utf-8?B?bWdyM0F1ZDU0QXdxVjlkUVRpVFpmRGFxSkF6dC82QldQUVJZcXFLak5LRUIw?=
 =?utf-8?B?UEFSd2FWRjZoWHo3RnloVkZWWE12WHVNMldTWHlxK0pYUFRQcVlTMityZEcx?=
 =?utf-8?B?K1orRXBKemk0V21Ob2o3VEhnTmpGS3VkVW5maW5CQmlDdXRsKzlXZXZOSGh5?=
 =?utf-8?B?VFlQQmpidThRaDlZeXhycmlZL2VLbWo1bUdoYStxa0JoZ01GNGlOREt2UTVn?=
 =?utf-8?B?ZUI3M0J1NXJvMlk4SDR0MTVSalIyK04vWW44WFNMZG5hd2xYelh3Nm9Velg3?=
 =?utf-8?Q?GSgTUrfDuKJGlqy7mLihhL36I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499e29d1-8a67-49d9-3857-08dbbdccd7a7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 13:39:29.3790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT7l5YVb7+5IkT8xPo1qbRBgo5QhYLvEdE2SbfcK4XefxL6oV3njBuM5+yB1M9Uw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
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
Cc: alex.sierra@amd.com, Felix.Kuehling@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------lJlpu11gu6WJHj3slqCDQJNv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Tested-by:JamesZhu<James.Zhu@amd.com>forthis patch


James zhu
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
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
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
--------------lJlpu11gu6WJHj3slqCDQJNv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
Tested-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a><span style=" color:#c0c0c0;"> </span><span style=" color:#ff9d04;">for</span><span style=" color:#c0c0c0;"> </span>this patch</p>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style></p>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">James zhu<br>
    </div>
    <div class="moz-cite-prefix">On 2023-09-20 11:45, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20230920154530.18588-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">If new range is splited to multiple pranges with max_svm_range_pages
alignment and added to update_list, svm validate and map should keep
going after error to make sure prange-&gt;mapped_to_gpu flag is up to date
for the whole range.

svm validate and map update set prange-&gt;mapped_to_gpu after mapping to
GPUs successfully, otherwise clear prange-&gt;mapped_to_gpu flag (for
update mapping case) instead of setting error flag, we can remove
the redundant error flag to simpliy code.

Refactor to remove goto and update prange-&gt;mapped_to_gpu flag inside
svm_range_lock, to guarant we always evict queues or unmap from GPUs if
there are invalid ranges.

After svm validate and map return error -EAGIN, the caller retry will
update the mapping for the whole range again.

Fixes: c22b04407097 (&quot;drm/amdkfd: flag added to handle errors from svm validate and map&quot;)
Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 80 +++++++++++++---------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
 2 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fb55cf80d74e..0b6a70171320 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -827,7 +827,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
 		}
 	}
 
-	return !prange-&gt;is_error_flag;
+	return true;
 }
 
 /**
@@ -1680,7 +1680,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 	start = prange-&gt;start &lt;&lt; PAGE_SHIFT;
 	end = (prange-&gt;last + 1) &lt;&lt; PAGE_SHIFT;
-	for (addr = start; addr &lt; end &amp;&amp; !r; ) {
+	for (addr = start; !r &amp;&amp; addr &lt; end; ) {
 		struct hmm_range *hmm_range;
 		struct vm_area_struct *vma;
 		unsigned long next;
@@ -1689,62 +1689,57 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		bool readonly;
 
 		vma = vma_lookup(mm, addr);
-		if (!vma) {
+		if (vma) {
+			readonly = !(vma-&gt;vm_flags &amp; VM_WRITE);
+
+			next = min(vma-&gt;vm_end, end);
+			npages = (next - addr) &gt;&gt; PAGE_SHIFT;
+			WRITE_ONCE(p-&gt;svms.faulting_task, current);
+			r = amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, addr, npages,
+						       readonly, owner, NULL,
+						       &amp;hmm_range);
+			WRITE_ONCE(p-&gt;svms.faulting_task, NULL);
+			if (r) {
+				pr_debug(&quot;failed %d to get svm range pages\n&quot;, r);
+				if (r == -EBUSY)
+					r = -EAGAIN;
+			}
+		} else {
 			r = -EFAULT;
-			goto unreserve_out;
-		}
-		readonly = !(vma-&gt;vm_flags &amp; VM_WRITE);
-
-		next = min(vma-&gt;vm_end, end);
-		npages = (next - addr) &gt;&gt; PAGE_SHIFT;
-		WRITE_ONCE(p-&gt;svms.faulting_task, current);
-		r = amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, addr, npages,
-					       readonly, owner, NULL,
-					       &amp;hmm_range);
-		WRITE_ONCE(p-&gt;svms.faulting_task, NULL);
-		if (r) {
-			pr_debug(&quot;failed %d to get svm range pages\n&quot;, r);
-			if (r == -EBUSY)
-				r = -EAGAIN;
-			goto unreserve_out;
 		}
 
-		offset = (addr - start) &gt;&gt; PAGE_SHIFT;
-		r = svm_range_dma_map(prange, ctx-&gt;bitmap, offset, npages,
-				      hmm_range-&gt;hmm_pfns);
-		if (r) {
-			pr_debug(&quot;failed %d to dma map range\n&quot;, r);
-			goto unreserve_out;
+		if (!r) {
+			offset = (addr - start) &gt;&gt; PAGE_SHIFT;
+			r = svm_range_dma_map(prange, ctx-&gt;bitmap, offset, npages,
+					      hmm_range-&gt;hmm_pfns);
+			if (r)
+				pr_debug(&quot;failed %d to dma map range\n&quot;, r);
 		}
 
 		svm_range_lock(prange);
-		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
+		if (!r &amp;&amp; amdgpu_hmm_range_get_pages_done(hmm_range)) {
 			pr_debug(&quot;hmm update the range, need validate again\n&quot;);
 			r = -EAGAIN;
-			goto unlock_out;
 		}
-		if (!list_empty(&amp;prange-&gt;child_list)) {
+
+		if (!r &amp;&amp; !list_empty(&amp;prange-&gt;child_list)) {
 			pr_debug(&quot;range split by unmap in parallel, validate again\n&quot;);
 			r = -EAGAIN;
-			goto unlock_out;
 		}
 
-		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-					  ctx-&gt;bitmap, wait, flush_tlb);
+		if (!r)
+			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
+						  ctx-&gt;bitmap, wait, flush_tlb);
+
+		if (!r &amp;&amp; next == end)
+			prange-&gt;mapped_to_gpu = true;
 
-unlock_out:
 		svm_range_unlock(prange);
 
 		addr = next;
 	}
 
-	if (addr == end)
-		prange-&gt;mapped_to_gpu = true;
-
-unreserve_out:
 	svm_range_unreserve_bos(ctx);
-
-	prange-&gt;is_error_flag = !!r;
 	if (!r)
 		prange-&gt;validate_timestamp = ktime_get_boottime();
 
@@ -2113,7 +2108,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next = interval_tree_iter_next(node, start, last);
 		next_start = min(node-&gt;last, last) + 1;
 
-		if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
+		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &amp;&amp;
+		    prange-&gt;mapped_to_gpu) {
 			/* nothing to do */
 		} else if (node-&gt;start &lt; start || node-&gt;last &gt; last) {
 			/* node intersects the update range and its attributes
@@ -3526,7 +3522,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	struct svm_range *next;
 	bool update_mapping = false;
 	bool flush_tlb;
-	int r = 0;
+	int r, ret = 0;
 
 	pr_debug(&quot;pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n&quot;,
 		 p-&gt;pasid, &amp;p-&gt;svms, start, start + size - 1, size);
@@ -3614,7 +3610,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 out_unlock_range:
 		mutex_unlock(&amp;prange-&gt;migrate_mutex);
 		if (r)
-			break;
+			ret = r;
 	}
 
 	dynamic_svm_range_dump(svms);
@@ -3627,7 +3623,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	pr_debug(&quot;pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n&quot;, p-&gt;pasid,
 		 &amp;p-&gt;svms, start, start + size - 1, r);
 
-	return r;
+	return ret ? ret : r;
 }
 
 static int
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 5fd958a97a28..c528df1d0ba2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -133,7 +133,6 @@ struct svm_range {
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
 	bool				mapped_to_gpu;
-	bool				is_error_flag;
 };
 
 static inline void svm_range_lock(struct svm_range *prange)
</pre>
    </blockquote>
  </body>
</html>

--------------lJlpu11gu6WJHj3slqCDQJNv--
