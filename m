From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 hmm 11/11] mm/mmu_notifiers: remove
 unregister_no_release
Date: Thu, 8 Aug 2019 12:29:51 +0200
Message-ID: <20190808102951.GE648@lst.de>
References: <20190806231548.25242-1-jgg@ziepe.ca> <20190806231548.25242-12-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190806231548.25242-12-jgg@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>, Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Dimitri Sivanich <sivanich@sgi.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org, Gavin Shan <shangw@linux.vnet.ibm.com>, Andrea Righi <andrea@betterlinux.com>, Jason Gunthorpe <jgg@mellanox.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Aug 06, 2019 at 08:15:48PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> mmu_notifier_unregister_no_release() and mmu_notifier_call_srcu() no
> longer have any users, they have all been converted to use
> mmu_notifier_put().
> 
> So delete this difficult to use interface.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
