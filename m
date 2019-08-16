From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct
 hmm_vma_walk
Date: Fri, 16 Aug 2019 06:44:48 +0200
Message-ID: <20190816044448.GB4093@lst.de>
References: <20190814132746.GE13756@mellanox.com> <CAPcyv4g8usp8prJ+1bMtyV1xuedp5FKErBp-N8+KzR=rJ-v0QQ@mail.gmail.com> <20190815180325.GA4920@redhat.com> <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com> <20190815194339.GC9253@redhat.com> <CAPcyv4jid8_=-8hBpn_Qm=c4S8BapL9B9RGT7e9uu303yH=Yqw@mail.gmail.com> <20190815203306.GB25517@redhat.com> <20190815204128.GI22970@mellanox.com> <20190815205132.GC25517@redhat.com> <20190816004303.GC9929@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190816004303.GC9929@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Jerome Glisse <jglisse@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Aug 16, 2019 at 12:43:07AM +0000, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2019 at 04:51:33PM -0400, Jerome Glisse wrote:
> 
> > struct page. In this case any way we can update the
> > nouveau_dmem_page() to check that page page->pgmap == the
> > expected pgmap.
> 
> I was also wondering if that is a problem.. just blindly doing a
> container_of on the page->pgmap does seem like it assumes that only
> this driver is using DEVICE_PRIVATE.
> 
> It seems like something missing in hmm_range_fault, it should be told
> what DEVICE_PRIVATE is acceptable to trigger HMM_PFN_DEVICE_PRIVATE
> and fault all others?

The whole device private handling in hmm and migrate_vma seems pretty
broken as far as I can tell, and I have some WIP patches.  Basically we
should not touch (or possibly eventually call migrate to ram eventually
in the future) device private pages not owned by the caller, where I
try to defined the caller by the dev_pagemap_ops instance.  
