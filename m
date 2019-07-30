From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 03/13] nouveau: pass struct nouveau_svmm to
 nouveau_range_fault
Date: Tue, 30 Jul 2019 13:14:58 +0000
Message-ID: <20190730131454.GG24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-4-hch@lst.de> <20190730123554.GD24038@mellanox.com>
 <20190730131038.GB4566@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730131038.GB4566@lst.de>
Content-Language: en-US
Content-ID: <9EFBC7D2033F0A4F9278F6401B93A640@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 03:10:38PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 30, 2019 at 12:35:59PM +0000, Jason Gunthorpe wrote:
> > On Tue, Jul 30, 2019 at 08:51:53AM +0300, Christoph Hellwig wrote:
> > > This avoid having to abuse the vma field in struct hmm_range to unloc=
k
> > > the mmap_sem.
> >=20
> > I think the change inside hmm_range_fault got lost on rebase, it is
> > now using:
> >=20
> >                 up_read(&range->hmm->mm->mmap_sem);
> >=20
> > But, yes, lets change it to use svmm->mm and try to keep struct hmm
> > opaque to drivers
>=20
> It got lost somewhat intentionally as I didn't want the churn, but I
> forgot to update the changelog.  But if you are fine with changing it
> over I can bring it back.

I have a patch deleting hmm->mm, so using svmm seems cleaner churn
here, we could defer and I can fold this into that patch?

Jason
