Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E82C0044D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 01:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C0320739
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 01:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RHipklF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C0320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E76C98997E;
	Thu, 12 Mar 2020 01:36:09 +0000 (UTC)
X-Greylist: delayed 385 seconds by postgrey-1.36 at gabe;
 Thu, 12 Mar 2020 01:36:08 UTC
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C428997E;
 Thu, 12 Mar 2020 01:36:08 +0000 (UTC)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e6991db0001>; Wed, 11 Mar 2020 18:35:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 11 Mar 2020 18:36:08 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 11 Mar 2020 18:36:08 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Thu, 12 Mar 2020 01:36:04 +0000
Subject: Re: [PATCH hmm 6/8] mm/hmm: reorganize how !pte_present is handled in
 hmm_vma_handle_pte()
To: Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
 <Felix.Kuehling@amd.com>
References: <20200311183506.3997-1-jgg@ziepe.ca>
 <20200311183506.3997-7-jgg@ziepe.ca>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <a2062a3f-1f49-e2da-a7f4-aa329b8e792d@nvidia.com>
Date: Wed, 11 Mar 2020 18:36:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200311183506.3997-7-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1583976923; bh=S/I6c3XTaySz4LXbDmkaoffNTKxOz1lAzVWUIvN8gwk=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=RHipklF1EQ5Bf/lt1Ng3QveU2SQeB4qGIakiQEtuU3AQpOuaU3YgYHhgyTfv1A1Bq
 xAvGoGm1QgBEb9yhLVqQ1cAWvXPxb5L6b6SEDZNXvHd5s0Et9W61KGhVXkho1jLs10
 mtHXwo+2pBesubgamiVe1vnzCy0ahcrEi3ebMYhwnnzIX70sXhvqoUN1yimkdSIvhU
 +4lma9ygcJs4Mu7R/kXZWUHkCKZXDJGkiemTZQ9R0UJtdG6OG1i1xXZpS/MorZQ3Yp
 RmOV63K6JoBwXI3f9xzfGVMp4h8G0QU+BoPG3T+dducsb0vFsPRiIzk/UdhXJRcOer
 BFzC0O5qwmj3w==
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
Cc: Philip Yang <Philip.Yang@amd.com>, John Hubbard <jhubbard@nvidia.com>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 Jason Gunthorpe <jgg@mellanox.com>, dri-devel@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/11/20 11:35 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> The intention with this code is to determine if the caller required the
> pages to be valid, and if so, then take some action to make them valid.
> The action varies depending on the page type.
> 
> In all cases, if the caller doesn't ask for the page, then
> hmm_range_fault() should not return an error.
> 
> Revise the implementation to be clearer, and fix some bugs:
> 
>   - hmm_pte_need_fault() must always be called before testing fault or
>     write_fault otherwise the defaults of false apply and the if()'s don't
>     work. This was missed on the is_migration_entry() branch
> 
>   - -EFAULT should not be returned unless hmm_pte_need_fault() indicates
>     fault is required - ie snapshotting should not fail.
> 
>   - For !pte_present() the cpu_flags are always 0, except in the special
>     case of is_device_private_entry(), calling pte_to_hmm_pfn_flags() is
>     confusing.
> 
> Reorganize the flow so that it always follows the pattern of calling
> hmm_pte_need_fault() and then checking fault || write_fault.
> 
> Fixes: 2aee09d8c116 ("mm/hmm: change hmm_vma_fault() to allow write fault on page basis")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/hmm.c | 35 +++++++++++++++--------------------
>   1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index e10cd0adba7b37..bf676cfef3e8ee 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -282,15 +282,6 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>   	if (!pte_present(pte)) {
>   		swp_entry_t entry = pte_to_swp_entry(pte);
>   
> -		if (!non_swap_entry(entry)) {
> -			cpu_flags = pte_to_hmm_pfn_flags(range, pte);
> -			hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags,
> -					   &fault, &write_fault);
> -			if (fault || write_fault)
> -				goto fault;
> -			return 0;
> -		}
> -
>   		/*
>   		 * This is a special swap entry, ignore migration, use
>   		 * device and report anything else as error.
> @@ -310,26 +301,30 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>   			return 0;
>   		}
>   
> -		if (is_migration_entry(entry)) {
> -			if (fault || write_fault) {
> -				pte_unmap(ptep);
> -				hmm_vma_walk->last = addr;
> -				migration_entry_wait(walk->mm, pmdp, addr);
> -				return -EBUSY;
> -			}
> +		hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0, &fault,
> +				   &write_fault);
> +		if (!fault && !write_fault)
>   			return 0;
> +
> +		if (!non_swap_entry(entry))
> +			goto fault;
> +
> +		if (is_migration_entry(entry)) {
> +			pte_unmap(ptep);
> +			hmm_vma_walk->last = addr;
> +			migration_entry_wait(walk->mm, pmdp, addr);
> +			return -EBUSY;
>   		}
>   
>   		/* Report error for everything else */
>   		pte_unmap(ptep);
>   		*pfn = range->values[HMM_PFN_ERROR];
>   		return -EFAULT;
> -	} else {
> -		cpu_flags = pte_to_hmm_pfn_flags(range, pte);
> -		hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags,
> -				   &fault, &write_fault);
>   	}
>   
> +	cpu_flags = pte_to_hmm_pfn_flags(range, pte);
> +	hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags, &fault,
> +			   &write_fault);
>   	if (fault || write_fault)
>   		goto fault;
>   
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
