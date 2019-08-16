From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
Date: Fri, 16 Aug 2019 12:24:25 +0000
Message-ID: <20190816122414.GC5412@mellanox.com>
References: <CAPcyv4g8usp8prJ+1bMtyV1xuedp5FKErBp-N8+KzR=rJ-v0QQ@mail.gmail.com>
 <20190815180325.GA4920@redhat.com>
 <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com>
 <20190815194339.GC9253@redhat.com>
 <CAPcyv4jid8_=-8hBpn_Qm=c4S8BapL9B9RGT7e9uu303yH=Yqw@mail.gmail.com>
 <20190815203306.GB25517@redhat.com> <20190815204128.GI22970@mellanox.com>
 <CAPcyv4j_Mxbw+T+yXTMdkrMoS_uxg+TXXgTM_EPBJ8XfXKxytA@mail.gmail.com>
 <20190816004053.GB9929@mellanox.com>
 <CAPcyv4gMPVmY59aQAT64jQf9qXrACKOuV=DfVs4sNySCXJhkdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4gMPVmY59aQAT64jQf9qXrACKOuV=DfVs4sNySCXJhkdA@mail.gmail.com>
Content-Language: en-US
Content-ID: <43A39A5E1EC938439754F1B9A3ACBE6E@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@lst.de>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Aug 15, 2019 at 08:54:46PM -0700, Dan Williams wrote:

> > However, this means we cannot do any processing of ZONE_DEVICE pages
> > outside the driver lock, so eg, doing any DMA map that might rely on
> > MEMORY_DEVICE_PCI_P2PDMA has to be done in the driver lock, which is
> > a bit unfortunate.
>=20
> Wouldn't P2PDMA use page pins? Not needing to hold a lock over
> ZONE_DEVICE page operations was one of the motivations for plumbing
> get_dev_pagemap() with a percpu-ref.

hmm_range_fault() doesn't use page pins at all, so if a ZONE_DEVICE
page comes out of it then it needs to use another locking pattern.

If I follow it all right:

We can do a get_dev_pagemap inside the page_walk and touch the pgmap,
or we can do the 'device mutex && retry' pattern and touch the pgmap
in the driver, under that lock.

However in all cases the current get_dev_pagemap()'s in the page walk
are not necessary, and we can delete them.

?

Jason
