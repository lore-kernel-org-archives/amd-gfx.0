From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 06/13] mm: remove superflous arguments from
 hmm_range_register
Date: Tue, 30 Jul 2019 17:51:00 +0000
Message-ID: <20190730175054.GM24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-7-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730055203.28467-7-hch@lst.de>
Content-Language: en-US
Content-ID: <2ED0ADD6FF332141A54123A43AF61452@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 08:51:56AM +0300, Christoph Hellwig wrote:
> The start, end and page_shift values are all saved in the range
> structure, so we might as well use that for argument passing.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/vm/hmm.rst                |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  7 +++++--
>  drivers/gpu/drm/nouveau/nouveau_svm.c   |  5 ++---
>  include/linux/hmm.h                     |  6 +-----
>  mm/hmm.c                                | 20 +++++---------------
>  5 files changed, 14 insertions(+), 26 deletions(-)

I also don't really like how the API sets up some things in the struct
and some things via arguments, so:

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
