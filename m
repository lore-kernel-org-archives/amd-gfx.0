From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 09/15] mm: don't abuse pte_index() in hmm_vma_handle_pmd
Date: Wed, 7 Aug 2019 17:18:01 +0000
Message-ID: <20190807171755.GI1571@mellanox.com>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-10-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806160554.14046-10-hch@lst.de>
Content-Language: en-US
Content-ID: <C7103DD7868C384CA830F3D0DA65CF22@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Aug 06, 2019 at 07:05:47PM +0300, Christoph Hellwig wrote:
> pte_index is an internal arch helper in various architectures,
> without consistent semantics.  Open code that calculation of a PMD
> index based on the virtual address instead.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/hmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

There sure are a lot of different ways to express this, but this one
looks OK to me, at least the switch from the PTRS_PER_PTE expression
in the x86 imlpementation to PMD_MASK looks equivalent
=20
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
