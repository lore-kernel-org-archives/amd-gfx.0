From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 10/13] mm: only define hmm_vma_walk_pud if needed
Date: Tue, 30 Jul 2019 18:02:39 +0000
Message-ID: <20190730180234.GP24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-11-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730055203.28467-11-hch@lst.de>
Content-Language: en-US
Content-ID: <8AED26FB1F585E4DA3EAA28F935E5D83@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 08:52:00AM +0300, Christoph Hellwig wrote:
> We only need the special pud_entry walker if PUD-sized hugepages and
> pte mappings are supported, else the common pagewalk code will take
> care of the iteration.  Not implementing this callback reduced the
> amount of code compiled for non-x86 platforms, and also fixes compile
> failures with other architectures when helpers like pud_pfn are not
> implemented.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/hmm.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
