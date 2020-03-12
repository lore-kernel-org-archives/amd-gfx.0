Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12961C10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 08:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB08120578
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 08:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB08120578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9481D6E09A;
	Thu, 12 Mar 2020 08:54:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B92ED6E09A;
 Thu, 12 Mar 2020 08:54:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46FC11FB;
 Thu, 12 Mar 2020 01:54:46 -0700 (PDT)
Received: from [10.57.15.252] (unknown [10.57.15.252])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 140973F67D;
 Thu, 12 Mar 2020 01:54:43 -0700 (PDT)
Subject: Re: [PATCH hmm 3/8] mm/hmm: do not call hmm_vma_walk_hole() while
 holding a spinlock
To: Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>
References: <20200311183506.3997-1-jgg@ziepe.ca>
 <20200311183506.3997-4-jgg@ziepe.ca>
From: Steven Price <steven.price@arm.com>
Message-ID: <5bd778fa-51e5-3e0c-d9bb-b38539b03c8d@arm.com>
Date: Thu, 12 Mar 2020 08:54:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311183506.3997-4-jgg@ziepe.ca>
Content-Language: en-GB
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jason Gunthorpe <jgg@mellanox.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/03/2020 18:35, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This eventually calls into handle_mm_fault() which is a sleeping function.
> Release the lock first.
> 
> hmm_vma_walk_hole() does not touch the contents of the PUD, so it does not
> need the lock.
> 
> Fixes: 3afc423632a1 ("mm: pagewalk: add p4d_entry() and pgd_entry()")
> Cc: Steven Price <steven.price@arm.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Sorry about that, thanks for fixing.

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   mm/hmm.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 9e8f68eb83287a..32dcbfd3908315 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -473,8 +473,8 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>   
>   	pud = READ_ONCE(*pudp);
>   	if (pud_none(pud)) {
> -		ret = hmm_vma_walk_hole(start, end, -1, walk);
> -		goto out_unlock;
> +		spin_unlock(ptl);
> +		return hmm_vma_walk_hole(start, end, -1, walk);
>   	}
>   
>   	if (pud_huge(pud) && pud_devmap(pud)) {
> @@ -483,8 +483,8 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>   		bool fault, write_fault;
>   
>   		if (!pud_present(pud)) {
> -			ret = hmm_vma_walk_hole(start, end, -1, walk);
> -			goto out_unlock;
> +			spin_unlock(ptl);
> +			return hmm_vma_walk_hole(start, end, -1, walk);
>   		}
>   
>   		i = (addr - range->start) >> PAGE_SHIFT;
> @@ -495,9 +495,9 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>   		hmm_range_need_fault(hmm_vma_walk, pfns, npages,
>   				     cpu_flags, &fault, &write_fault);
>   		if (fault || write_fault) {
> -			ret = hmm_vma_walk_hole_(addr, end, fault,
> -						 write_fault, walk);
> -			goto out_unlock;
> +			spin_unlock(ptl);
> +			return hmm_vma_walk_hole_(addr, end, fault, write_fault,
> +						  walk);
>   		}
>   
>   		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
