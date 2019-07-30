From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 07/13] mm: remove the page_shift member from struct
 hmm_range
Date: Tue, 30 Jul 2019 12:55:17 +0000
Message-ID: <20190730125512.GF24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-8-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730055203.28467-8-hch@lst.de>
Content-Language: en-US
Content-ID: <B20876FFD0ED7E4A83072CECCE1E8BF0@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 08:51:57AM +0300, Christoph Hellwig wrote:
> All users pass PAGE_SIZE here, and if we wanted to support single
> entries for huge pages we should really just add a HMM_FAULT_HUGEPAGE
> flag instead that uses the huge page size instead of having the
> caller calculate that size once, just for the hmm code to verify it.

I suspect this was added for the ODP conversion that does use both
page sizes. I think the ODP code for this is kind of broken, but I
haven't delved into that..

The challenge is that the driver needs to know what page size to
configure the hardware before it does any range stuff.

The other challenge is that the HW is configured to do only one page
size, and if the underlying CPU page side changes it goes south.

What I would prefer is if the driver could somehow dynamically adjust
the the page size after each dma map, but I don't know if ODP HW can
do that.

Since this is all driving toward making ODP use this maybe we should
keep this API?=20

I'm not sure I can loose the crappy huge page support in ODP.

Jason
