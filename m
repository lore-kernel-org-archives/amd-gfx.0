From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 13/13] mm: allow HMM_MIRROR on all architectures with MMU
Date: Tue, 30 Jul 2019 18:03:51 +0000
Message-ID: <20190730180346.GR24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-14-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730055203.28467-14-hch@lst.de>
Content-Language: en-US
Content-ID: <99F74B5B1EA70C41A24AB791174D4BBD@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 08:52:03AM +0300, Christoph Hellwig wrote:
> There isn't really any architecture specific code in this page table
> walk implementation, so drop the dependencies.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  mm/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Happy to see it, lets try to get this patch + the required parts of
this series into linux-next to be really sure

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Thanks,
Jason
