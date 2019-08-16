From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
Date: Fri, 16 Aug 2019 12:30:41 +0000
Message-ID: <20190816123036.GD5412@mellanox.com>
References: <CAPcyv4g8usp8prJ+1bMtyV1xuedp5FKErBp-N8+KzR=rJ-v0QQ@mail.gmail.com>
 <20190815180325.GA4920@redhat.com>
 <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com>
 <20190815194339.GC9253@redhat.com>
 <CAPcyv4jid8_=-8hBpn_Qm=c4S8BapL9B9RGT7e9uu303yH=Yqw@mail.gmail.com>
 <20190815203306.GB25517@redhat.com> <20190815204128.GI22970@mellanox.com>
 <20190815205132.GC25517@redhat.com> <20190816004303.GC9929@mellanox.com>
 <20190816044448.GB4093@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816044448.GB4093@lst.de>
Content-Language: en-US
Content-ID: <33BCB3B7F7923B46ACF944F8B7CA2B32@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jerome Glisse <jglisse@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Aug 16, 2019 at 06:44:48AM +0200, Christoph Hellwig wrote:
> On Fri, Aug 16, 2019 at 12:43:07AM +0000, Jason Gunthorpe wrote:
> > On Thu, Aug 15, 2019 at 04:51:33PM -0400, Jerome Glisse wrote:
> >=20
> > > struct page. In this case any way we can update the
> > > nouveau_dmem_page() to check that page page->pgmap =3D=3D the
> > > expected pgmap.
> >=20
> > I was also wondering if that is a problem.. just blindly doing a
> > container_of on the page->pgmap does seem like it assumes that only
> > this driver is using DEVICE_PRIVATE.
> >=20
> > It seems like something missing in hmm_range_fault, it should be told
> > what DEVICE_PRIVATE is acceptable to trigger HMM_PFN_DEVICE_PRIVATE
> > and fault all others?
>=20
> The whole device private handling in hmm and migrate_vma seems pretty
> broken as far as I can tell, and I have some WIP patches.  Basically we
> should not touch (or possibly eventually call migrate to ram eventually
> in the future) device private pages not owned by the caller, where I
> try to defined the caller by the dev_pagemap_ops instance. =20

I think it needs to be more elaborate.

For instance, a system may have multiple DEVICE_PRIVATE map's owned by
the same driver - but multiple physical devices using that driver.

Each physical device's driver should only ever get DEVICE_PRIVATE
pages for it's own on-device memory. Never a DEVICE_PRIVATE for
another device's memory.

The dev_pagemap_ops would not be unique enough, right?

Probably also clusters of same-driver struct device can share a
DEVICE_PRIVATE, at least high end GPU's now have private memory
coherency busses between their devices.

Since we want to trigger migration to CPU on incompatible
DEVICE_PRIVATE pages, it seems best to sort this out in the
hmm_range_fault?

Maybe some sort of unique ID inside the page->pgmap and passed as
input?

Jason
