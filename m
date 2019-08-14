From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct
 hmm_vma_walk
Date: Wed, 14 Aug 2019 09:38:54 +0200
Message-ID: <20190814073854.GA27249@lst.de>
References: <20190806160554.14046-1-hch@lst.de> <20190806160554.14046-5-hch@lst.de> <20190807174548.GJ1571@mellanox.com> <CAPcyv4hPCuHBLhSJgZZEh0CbuuJNPLFDA3f-79FX5uVOO0yubA@mail.gmail.com> <20190808065933.GA29382@lst.de> <CAPcyv4hMUzw8vyXFRPe2pdwef0npbMm9tx9wiZ9MWkHGhH1V6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPcyv4hMUzw8vyXFRPe2pdwef0npbMm9tx9wiZ9MWkHGhH1V6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Aug 13, 2019 at 06:36:33PM -0700, Dan Williams wrote:
> Section alignment constraints somewhat save us here. The only example
> I can think of a PMD not containing a uniform pgmap association for
> each pte is the case when the pgmap overlaps normal dram, i.e. shares
> the same 'struct memory_section' for a given span. Otherwise, distinct
> pgmaps arrange to manage their own exclusive sections (and now
> subsections as of v5.3). Otherwise the implementation could not
> guarantee different mapping lifetimes.
> 
> That said, this seems to want a better mechanism to determine "pfn is
> ZONE_DEVICE".

So I guess this patch is fine for now, and once you provide a better
mechanism we can switch over to it?
