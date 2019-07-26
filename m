From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 0/7] mm/hmm: more HMM clean up
Date: Fri, 26 Jul 2019 12:45:32 -0300
Message-ID: <20190726154532.GA29678@ziepe.ca>
References: <20190726005650.2566-1-rcampbell@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190726005650.2566-1-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Campbell <rcampbell@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Jul 25, 2019 at 05:56:43PM -0700, Ralph Campbell wrote:
> Here are seven more patches for things I found to clean up.
> This was based on top of Christoph's seven patches:
> "hmm_range_fault related fixes and legacy API removal v3".
> I assume this will go into Jason's tree since there will likely be
> more HMM changes in this cycle.
>
> Changes from v1 to v2:
> 
> Added AMD GPU to hmm_update removal.
> Added 2 patches from Christoph.
> Added 2 patches as a result of Jason's suggestions.
> 
> Christoph Hellwig (2):
>   mm/hmm: replace the block argument to hmm_range_fault with a flags
>     value
>   mm: merge hmm_range_snapshot into hmm_range_fault
> 
> Ralph Campbell (5):
>   mm/hmm: replace hmm_update with mmu_notifier_range
>   mm/hmm: a few more C style and comment clean ups
>   mm/hmm: remove hugetlbfs check in hmm_vma_walk_pmd
>   mm/hmm: remove hmm_range vma

For all of these:

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

I've applied this to hmm.git, excluding:

>   mm/hmm: make full use of walk_page_range()

Pending further discussion.

Based on last cycle I've decided to move good patches into linux-next
earlier and rely on some rebase if needed. This is to help Andrew's
workflow.

So, if there are more tags/etc please continue to send them, I will
sort it..

Thanks,
Jason
