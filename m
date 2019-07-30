From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/13] mm: remove the page_shift member from struct
 hmm_range
Date: Tue, 30 Jul 2019 15:14:30 +0200
Message-ID: <20190730131430.GC4566@lst.de>
References: <20190730055203.28467-1-hch@lst.de> <20190730055203.28467-8-hch@lst.de> <20190730125512.GF24038@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730125512.GF24038@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 12:55:17PM +0000, Jason Gunthorpe wrote:
> I suspect this was added for the ODP conversion that does use both
> page sizes. I think the ODP code for this is kind of broken, but I
> haven't delved into that..
> 
> The challenge is that the driver needs to know what page size to
> configure the hardware before it does any range stuff.
> 
> The other challenge is that the HW is configured to do only one page
> size, and if the underlying CPU page side changes it goes south.
> 
> What I would prefer is if the driver could somehow dynamically adjust
> the the page size after each dma map, but I don't know if ODP HW can
> do that.
> 
> Since this is all driving toward making ODP use this maybe we should
> keep this API? 
> 
> I'm not sure I can loose the crappy huge page support in ODP.

The problem is that I see no way how to use the current API.  To know
the huge page size you need to have the vma, and the current API
doesn't require a vma to be passed in.

That's why I suggested an api where we pass in a flag that huge pages
are ok into hmm_range_fault, and it then could pass the shift out, and
limits itself to a single vma (which it normally doesn't, that is an
additional complication).  But all this seems really awkward in terms
of an API still.  AFAIK ODP is only used by mlx5, and mlx5 unlike other
IB HCAs can use scatterlist style MRs with variable length per entry,
so even if we pass multiple pages per entry from hmm it could coalesce
them.  The best API for mlx4 would of course be to pass a biovec-style
variable length structure that hmm_fault could fill out, but that would
be a major restructure.
