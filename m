From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/13] mm: cleanup the hmm_vma_handle_pmd stub
Date: Thu, 1 Aug 2019 09:01:51 +0200
Message-ID: <20190801070151.GB15404@lst.de>
References: <20190730055203.28467-1-hch@lst.de> <20190730055203.28467-12-hch@lst.de> <20190730175309.GN24038@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730175309.GN24038@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 05:53:14PM +0000, Jason Gunthorpe wrote:
> > -	/* If THP is not enabled then we should never reach this 
> 
> This old comment says we should never get here
> 
> > +}
> > +#else /* CONFIG_TRANSPARENT_HUGEPAGE */
> > +static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
> > +		unsigned long end, uint64_t *pfns, pmd_t pmd)
> > +{
> >  	return -EINVAL;
> 
> So could we just do
>    #define hmm_vma_handle_pmd NULL
> 
> ?
> 
> At the very least this seems like a WARN_ON too?

Despite the name of the function hmm_vma_handle_pmd is not a callback
for the pagewalk, but actually called from hmm_vma_handle_pmd.

What we could try is just and empty non-inline prototype without an
actual implementation, which means if the compiler doesn't optimize
the calls away we'll get a link error.
