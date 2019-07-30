From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/13] nouveau: pass struct nouveau_svmm to
 nouveau_range_fault
Date: Tue, 30 Jul 2019 15:10:38 +0200
Message-ID: <20190730131038.GB4566@lst.de>
References: <20190730055203.28467-1-hch@lst.de> <20190730055203.28467-4-hch@lst.de> <20190730123554.GD24038@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730123554.GD24038@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 12:35:59PM +0000, Jason Gunthorpe wrote:
> On Tue, Jul 30, 2019 at 08:51:53AM +0300, Christoph Hellwig wrote:
> > This avoid having to abuse the vma field in struct hmm_range to unlock
> > the mmap_sem.
> 
> I think the change inside hmm_range_fault got lost on rebase, it is
> now using:
> 
>                 up_read(&range->hmm->mm->mmap_sem);
> 
> But, yes, lets change it to use svmm->mm and try to keep struct hmm
> opaque to drivers

It got lost somewhat intentionally as I didn't want the churn, but I
forgot to update the changelog.  But if you are fine with changing it
over I can bring it back.
