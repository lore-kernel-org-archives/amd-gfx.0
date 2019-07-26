From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 6/7] mm/hmm: remove hugetlbfs check in
 hmm_vma_walk_pmd
Date: Fri, 26 Jul 2019 08:24:37 +0200
Message-ID: <20190726062437.GC22881@lst.de>
References: <20190726005650.2566-1-rcampbell@nvidia.com> <20190726005650.2566-7-rcampbell@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190726005650.2566-7-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Campbell <rcampbell@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Jul 25, 2019 at 05:56:49PM -0700, Ralph Campbell wrote:
> walk_page_range() will only call hmm_vma_walk_hugetlb_entry() for
> hugetlbfs pages and doesn't call hmm_vma_walk_pmd() in this case.
> Therefore, it is safe to remove the check for vma->vm_flags & VM_HUGETLB
> in hmm_vma_walk_pmd().
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
