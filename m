From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 2/2] mm/hmm: hmm_range_fault() infinite loop
Date: Tue, 27 Aug 2019 15:41:57 -0300
Message-ID: <20190827184157.GA24929@ziepe.ca>
References: <20190823221753.2514-1-rcampbell@nvidia.com>
 <20190823221753.2514-3-rcampbell@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190823221753.2514-3-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Campbell <rcampbell@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Aug 23, 2019 at 03:17:53PM -0700, Ralph Campbell wrote:

> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>  mm/hmm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 29371485fe94..4882b83aeccb 100644
> +++ b/mm/hmm.c
> @@ -292,6 +292,9 @@ static int hmm_vma_walk_hole_(unsigned long addr, unsigned long end,
>  	hmm_vma_walk->last = addr;
>  	i = (addr - range->start) >> PAGE_SHIFT;
>  
> +	if (write_fault && walk->vma && !(walk->vma->vm_flags & VM_WRITE))
> +		return -EPERM;

Can walk->vma be NULL here? hmm_vma_do_fault() touches it
unconditionally.

Jason
