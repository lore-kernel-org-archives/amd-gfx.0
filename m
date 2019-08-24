From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm/hmm: hmm_range_fault() infinite loop
Date: Sun, 25 Aug 2019 00:39:07 +0200
Message-ID: <20190824223907.GB21891@lst.de>
References: <20190823221753.2514-1-rcampbell@nvidia.com> <20190823221753.2514-3-rcampbell@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190823221753.2514-3-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Campbell <rcampbell@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Aug 23, 2019 at 03:17:53PM -0700, Ralph Campbell wrote:
> Normally, callers to handle_mm_fault() are supposed to check the
> vma->vm_flags first. hmm_range_fault() checks for VM_READ but doesn't
> check for VM_WRITE if the caller requests a page to be faulted in
> with write permission (via the hmm_range.pfns[] value).
> If the vma is write protected, this can result in an infinite loop:
>   hmm_range_fault()
>     walk_page_range()
>       ...
>       hmm_vma_walk_hole()
>         hmm_vma_walk_hole_()
>           hmm_vma_do_fault()
>             handle_mm_fault(FAULT_FLAG_WRITE)
>             /* returns VM_FAULT_WRITE */
>           /* returns -EBUSY */
>         /* returns -EBUSY */
>       /* returns -EBUSY */
>     /* loops on -EBUSY and range->valid */
> Prevent this by checking for vma->vm_flags & VM_WRITE before calling
> handle_mm_fault().
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
