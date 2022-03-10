Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9E8C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Mar 2022 08:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3BD210E872;
	Fri, 11 Mar 2022 08:51:36 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE6810ECAA;
 Thu, 10 Mar 2022 19:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=vKB1pv4NC1deGVtskVNXZeo270YsQHcGnw/bzvNqjhU=; b=t+fQekjDylXM5FpL11K6LbsM4U
 nCEpfSkGhWw+V7I6WlvE7/IKQW5xJVT9Wix1QBVDoLZKIC730H7It/GEFSYO86SbZidTfQ79c02Zf
 W+mH+tEYafK0ctXsSkLrVq0r2S59sK/FeZ+fPRX3t/TtOUFhhJK9horVAqmehDltTEjopvGPg59EN
 43GCJwf2Lvvd0Iue2CdHswQmns5peN3XHOKy6GedHLH2DxWLw/ZyWHtmeAk1+Tb+/NHRgfzmuQBFS
 aInAU+8T8FpK0w+KCHXOvIvfcTpYVkRjUfq0dKRkQD+Oeoj5Z3K41RKFV58IlLSgabV8Bklj3fIFt
 Ec0MfEWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nSOPi-000rME-NN; Thu, 10 Mar 2022 19:25:30 +0000
Date: Thu, 10 Mar 2022 19:25:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alex Sierra <alex.sierra@amd.com>
Subject: Re: [PATCH v1 1/3] mm: split vm_normal_pages for LRU and non-LRU
 handling
Message-ID: <YipQqqpTz8hZAbLZ@casper.infradead.org>
References: <20220310172633.9151-1-alex.sierra@amd.com>
 <20220310172633.9151-2-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310172633.9151-2-alex.sierra@amd.com>
X-Mailman-Approved-At: Fri, 11 Mar 2022 08:51:34 +0000
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
Cc: rcampbell@nvidia.com, david@redhat.com, Felix.Kuehling@amd.com,
 apopple@nvidia.com, amd-gfx@lists.freedesktop.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, jglisse@redhat.com, dri-devel@lists.freedesktop.org,
 jgg@nvidia.com, akpm@linux-foundation.org, linux-ext4@vger.kernel.org,
 hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 10, 2022 at 11:26:31AM -0600, Alex Sierra wrote:
> @@ -606,7 +606,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>   * PFNMAP mappings in order to support COWable mappings.
>   *
>   */
> -struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> +struct page *vm_normal_any_page(struct vm_area_struct *vma, unsigned long addr,
>  			    pte_t pte)
>  {
>  	unsigned long pfn = pte_pfn(pte);
> @@ -620,8 +620,6 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  			return NULL;
>  		if (is_zero_pfn(pfn))
>  			return NULL;
> -		if (pte_devmap(pte))
> -			return NULL;
>  
>  		print_bad_pte(vma, addr, pte, NULL);
>  		return NULL;

... what?

Haven't you just made it so that a devmap page always prints a bad PTE
message, and then returns NULL anyway?

Surely this should be:

		if (pte_devmap(pte))
-			return NULL;
+			return pfn_to_page(pfn);

or maybe

+			goto check_pfn;

But I don't know about that highest_memmap_pfn check.

> @@ -661,6 +659,22 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  	return pfn_to_page(pfn);
>  }
>  
> +/*
> + * vm_normal_lru_page -- This function gets the "struct page" associated
> + * with a pte only for page cache and anon page. These pages are LRU handled.
> + */
> +struct page *vm_normal_lru_page(struct vm_area_struct *vma, unsigned long addr,
> +			    pte_t pte)

It seems a shame to add a new function without proper kernel-doc.

