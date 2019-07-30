From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 01/13] amdgpu: remove -EAGAIN handling for hmm_range_fault
Date: Tue, 30 Jul 2019 12:33:02 +0000
Message-ID: <20190730123257.GB24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730055203.28467-2-hch@lst.de>
Content-Language: en-US
Content-ID: <76FBA5B0F135514A885052AAEE17CDB6@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 08:51:51AM +0300, Christoph Hellwig wrote:
> hmm_range_fault can only return -EAGAIN if called with the block
> argument set to false, so remove the special handling for it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
