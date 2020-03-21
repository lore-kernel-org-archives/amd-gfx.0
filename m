Return-Path: <SRS0=lmwh=5G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407F2C4332E
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2020 10:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20760206F9
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2020 10:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20760206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE4746E311;
	Sat, 21 Mar 2020 10:44:53 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47D1B6E2DD;
 Sat, 21 Mar 2020 08:37:29 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id CBF5668AFE; Sat, 21 Mar 2020 09:37:26 +0100 (CET)
Date: Sat, 21 Mar 2020 09:37:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH hmm 2/6] mm/hmm: return the fault type from
 hmm_pte_need_fault()
Message-ID: <20200321083726.GB28695@lst.de>
References: <20200320164905.21722-1-jgg@ziepe.ca>
 <20200320164905.21722-3-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200320164905.21722-3-jgg@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Sat, 21 Mar 2020 10:44:44 +0000
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
Cc: Philip Yang <Philip.Yang@amd.com>, Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 20, 2020 at 01:49:01PM -0300, Jason Gunthorpe wrote:
> +enum {
> +	NEED_FAULT = 1 << 0,
> +	NEED_WRITE_FAULT = 1 << 1,
> +};

Maybe add a HMM_ prefix?

>  	for (i = 0; i < npages; ++i) {
> +		required_fault |=
> +			hmm_pte_need_fault(hmm_vma_walk, pfns[i], cpu_flags);
> +		if (required_fault == (NEED_FAULT | NEED_WRITE_FAULT))
> +			return required_fault;

No need for the inner braces.

> @@ -532,17 +515,15 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
>  	 */
>  	if ((vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP)) ||
>  	    !(vma->vm_flags & VM_READ)) {
> -		bool fault, write_fault;
> -

No that there is no need for local variables I'd invert the test and
return early:

	if ((vma->vm_flags & VM_READ) &&
	    !(vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP))
		return 0;

>  		/*
>  		 * Check to see if a fault is requested for any page in the
>  		 * range.
>  		 */
> -		hmm_range_need_fault(hmm_vma_walk, range->pfns +
> -					((start - range->start) >> PAGE_SHIFT),
> -					(end - start) >> PAGE_SHIFT,
> -					0, &fault, &write_fault);
> -		if (fault || write_fault)
> +		if (hmm_range_need_fault(hmm_vma_walk,
> +					 range->pfns +
> +						 ((start - range->start) >>
> +						  PAGE_SHIFT),
> +					 (end - start) >> PAGE_SHIFT, 0))

Which should help to make this a little more readable..
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
