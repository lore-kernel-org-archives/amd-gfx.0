From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] mm/hmm: make full use of walk_page_range()
Date: Thu, 12 Sep 2019 10:26:13 +0200
Message-ID: <20190912082613.GA14368@lst.de>
References: <20190911222829.28874-1-rcampbell@nvidia.com> <20190911222829.28874-2-rcampbell@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190911222829.28874-2-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Campbell <rcampbell@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: amd-gfx.lists.freedesktop.org

> +static int hmm_pfns_fill(unsigned long addr,
> +			 unsigned long end,
> +			 struct hmm_range *range,
> +			 enum hmm_pfn_value_e value)

Nit: can we use the space a little more efficient, e.g.:

static int hmm_pfns_fill(unsigned long addr, unsigned long end,
		struct hmm_range *range, enum hmm_pfn_value_e value)

> +static int hmm_vma_walk_test(unsigned long start,
> +			     unsigned long end,
> +			     struct mm_walk *walk)

Same here.

> +	if (!(vma->vm_flags & VM_READ)) {
> +		(void) hmm_pfns_fill(start, end, range, HMM_PFN_NONE);

There should be no need for the void cast here.
