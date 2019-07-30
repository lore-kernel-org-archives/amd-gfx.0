From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 05/13] mm: remove the unused vma argument to
 hmm_range_dma_unmap
Date: Tue, 30 Jul 2019 12:45:22 +0000
Message-ID: <20190730124517.GE24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-6-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730055203.28467-6-hch@lst.de>
Content-Language: en-US
Content-ID: <5AEF0910AD27734B9CD8F3EB448FDE35@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 08:51:55AM +0300, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  include/linux/hmm.h | 1 -
>  mm/hmm.c            | 2 --
>  2 files changed, 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Unclear what this was intended for, but I think if we need to carry
information from the dma_map to unmap it should be done in some opaque
way.

The driver should not have to care about VMAs, beyond perhaps using
VMAs to guide what VA ranges to mirror.

Jason
