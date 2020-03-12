Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB24C0044D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 01:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA7C20753
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 01:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fSpB6u5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA7C20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F7AB89A5C;
	Thu, 12 Mar 2020 01:38:11 +0000 (UTC)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C8CD89A5C;
 Thu, 12 Mar 2020 01:38:10 +0000 (UTC)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e6992540000>; Wed, 11 Mar 2020 18:37:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 11 Mar 2020 18:38:09 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 11 Mar 2020 18:38:09 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Thu, 12 Mar 2020 01:38:07 +0000
Subject: Re: [PATCH hmm 8/8] mm/hmm: add missing call to hmm_pte_need_fault in
 HMM_PFN_SPECIAL handling
To: Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
 <Felix.Kuehling@amd.com>
References: <20200311183506.3997-1-jgg@ziepe.ca>
 <20200311183506.3997-9-jgg@ziepe.ca>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <2feb1061-09b9-766d-3d0d-be17debedde8@nvidia.com>
Date: Wed, 11 Mar 2020 18:38:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200311183506.3997-9-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1583977044; bh=TeIeAHJ8Ep5pjoo7cziGM/eX3EFeJGJdqZCXIdNjLkY=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=fSpB6u5RJxL5Ws6WRwyo0MDxd1wwB/p/tYs2GJJQ86w5OykymtKp01xcWGqBxKFyB
 EcwFhSJWy/Z3CzpI5sdXwxyqBy0Nmoqju318rE7SqcjIURSHLN8w5r//rf0Ut7qf+l
 hjUs/PEeQi2X01Dg2ygewCc/6EEGpOVlHnTxKQwzQviYIEkowxD/y3DPyQCwWVZBn4
 UuACQ2qhLoRf3aDxtQgZJS3mAj+Ul4Yd4tsx4LvogUBd0LC/hvtqtVEt6abck2uSix
 CTHhQit97LsJ0KJTuKnGbKPzZZwmZZ8kSdnLCn2f1AYCSSMwYdbJFj5Vni5zJ/XHny
 NRfZ8z0fhTNvA==
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
> Currently if a special PTE is encountered hmm_range_fault() immediately
> returns EFAULT and sets the HMM_PFN_SPECIAL error output (which nothing
> uses).
> 
> EFAULT should only be returned after testing with hmm_pte_need_fault().
> 
> Also pte_devmap() and pte_special() are exclusive, and there is no need to
> check IS_ENABLED, pte_special() is stubbed out to return false on
> unsupported architectures.
> 
> Fixes: 992de9a8b751 ("mm/hmm: allow to mirror vma of a file on a DAX backed filesystem")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/hmm.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index f61fddf2ef6505..ca33d086bdc190 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -335,16 +335,21 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>   			pte_unmap(ptep);
>   			return -EBUSY;
>   		}
> -	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) {
> -		if (!is_zero_pfn(pte_pfn(pte))) {
> +	}
> +
> +	/*
> +	 * Since each architecture defines a struct page for the zero page, just
> +	 * fall through and treat it like a normal page.
> +	 */
> +	if (pte_special(pte) && !is_zero_pfn(pte_pfn(pte))) {
> +		hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0, &fault,
> +				   &write_fault);
> +		if (fault || write_fault) {
>   			pte_unmap(ptep);
> -			*pfn = range->values[HMM_PFN_SPECIAL];
>   			return -EFAULT;
>   		}
> -		/*
> -		 * Since each architecture defines a struct page for the zero
> -		 * page, just fall through and treat it like a normal page.
> -		 */
> +		*pfn = range->values[HMM_PFN_SPECIAL];
> +		return 0;
>   	}
>   
>   	*pfn = hmm_device_entry_from_pfn(range, pte_pfn(pte)) | cpu_flags;
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
