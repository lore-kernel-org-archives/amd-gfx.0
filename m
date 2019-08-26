From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 1/2] mm/hmm: hmm_range_fault() NULL pointer bug
Date: Mon, 26 Aug 2019 18:09:42 +0000
Message-ID: <20190826180937.GI27031@mellanox.com>
References: <20190823221753.2514-1-rcampbell@nvidia.com>
 <20190823221753.2514-2-rcampbell@nvidia.com> <20190824223754.GA21891@lst.de>
 <e2ecc1a7-0d2f-5957-e6cb-b3c86c085d80@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e2ecc1a7-0d2f-5957-e6cb-b3c86c085d80@nvidia.com>
Content-Language: en-US
Content-ID: <13598A34FD89014892271F429ACE899D@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Campbell <rcampbell@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Aug 26, 2019 at 11:02:12AM -0700, Ralph Campbell wrote:
>=20
> On 8/24/19 3:37 PM, Christoph Hellwig wrote:
> > On Fri, Aug 23, 2019 at 03:17:52PM -0700, Ralph Campbell wrote:
> > > Although hmm_range_fault() calls find_vma() to make sure that a vma e=
xists
> > > before calling walk_page_range(), hmm_vma_walk_hole() can still be ca=
lled
> > > with walk->vma =3D=3D NULL if the start and end address are not conta=
ined
> > > within the vma range.
> >=20
> > Should we convert to walk_vma_range instead?  Or keep walk_page_range
> > but drop searching the vma ourselves?
> >=20
> > Except for that the patch looks good to me:
> >=20
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> >=20
>=20
> I think keeping the call to walk_page_range() makes sense.
> Jason is hoping to be able to snapshot a range with & without vmas
> and have the pfns[] filled with empty/valid entries as appropriate.
>=20
> I plan to repost my patch changing hmm_range_fault() to use
> walk.test_walk which will remove the call to find_vma().
> Jason had some concerns about testing it so that's why I have
> been working on some HMM self tests before resending it.

I'm really excited to see tests for hmm_range_fault()!

Did you find this bug with the tests??

Jason
