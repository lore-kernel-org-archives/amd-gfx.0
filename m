From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 07/13] mm: remove the page_shift member from struct
 hmm_range
Date: Tue, 30 Jul 2019 17:50:16 +0000
Message-ID: <20190730175011.GL24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-8-hch@lst.de> <20190730125512.GF24038@mellanox.com>
 <20190730131430.GC4566@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730131430.GC4566@lst.de>
Content-Language: en-US
Content-ID: <C2F97CE8AB885F42907BDBA1823FEA57@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 03:14:30PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 30, 2019 at 12:55:17PM +0000, Jason Gunthorpe wrote:
> > I suspect this was added for the ODP conversion that does use both
> > page sizes. I think the ODP code for this is kind of broken, but I
> > haven't delved into that..
> >=20
> > The challenge is that the driver needs to know what page size to
> > configure the hardware before it does any range stuff.
> >=20
> > The other challenge is that the HW is configured to do only one page
> > size, and if the underlying CPU page side changes it goes south.
> >=20
> > What I would prefer is if the driver could somehow dynamically adjust
> > the the page size after each dma map, but I don't know if ODP HW can
> > do that.
> >=20
> > Since this is all driving toward making ODP use this maybe we should
> > keep this API?=20
> >=20
> > I'm not sure I can loose the crappy huge page support in ODP.
>=20
> The problem is that I see no way how to use the current API.  To know
> the huge page size you need to have the vma, and the current API
> doesn't require a vma to be passed in.

The way ODP seems to work is once in hugetlb mode the dma addresses
must give huge pages or the page fault will be failed. I think that is
a terrible design, but this is how the driver is ..

So, from this HMM perspective if the caller asked for huge pages then
the results have to be all huge pages or a hard failure.

It is not negotiated as an optimization like you are thinking.

[note, I haven't yet checked carefully how this works in ODP, every
 time I look at parts of it the thing seems crazy]

> That's why I suggested an api where we pass in a flag that huge pages
> are ok into hmm_range_fault, and it then could pass the shift out, and
> limits itself to a single vma (which it normally doesn't, that is an
> additional complication).  But all this seems really awkward in terms
> of an API still.  AFAIK ODP is only used by mlx5, and mlx5 unlike other
> IB HCAs can use scatterlist style MRs with variable length per entry,
> so even if we pass multiple pages per entry from hmm it could coalesce
> them. =20

When the driver takes faults it has to repair the MR mapping, and
fixing a page in the middle of a variable length SGL would be pretty
complicated. Even so, I don't think the SG_GAPs feature and ODP are
compatible - I'm pretty sure ODP has to be page lists not SGL..

However, what ODP can maybe do is represent a full multi-level page
table, so we could have 2M entries that map to a single DMA or to
another page table w/ 4k pages (have to check on this)

But the driver isn't set up to do that right now.

> The best API for mlx4 would of course be to pass a biovec-style
> variable length structure that hmm_fault could fill out, but that would
> be a major restructure.

It would work, but the driver has to expand that into a page list
right awayhow.

We can't even dma map the biovec with today's dma API as it needs the
ability to remap on a page granularity.

Jason
