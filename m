From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 13/13] mm: allow HMM_MIRROR on all architectures with MMU
Date: Tue, 30 Jul 2019 18:04:56 +0000
Message-ID: <20190730180452.GS24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-14-hch@lst.de> <20190730180346.GR24038@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730180346.GR24038@mellanox.com>
Content-Language: en-US
Content-ID: <19A5F90EDC581B4E9B7EA8DB5AE872E2@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 03:03:46PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 30, 2019 at 08:52:03AM +0300, Christoph Hellwig wrote:
> > There isn't really any architecture specific code in this page table
> > walk implementation, so drop the dependencies.
> >=20
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >  mm/Kconfig | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> Happy to see it, lets try to get this patch + the required parts of
> this series into linux-next to be really sure
>=20
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Oh, can we make this into a non-user selectable option now?=20

ie have the drivers that use the API select it?

Thanks,
Jason
