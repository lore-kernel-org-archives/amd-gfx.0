From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 hmm 01/11] mm/mmu_notifiers: hoist
 do_mmu_notifier_register down_write to the caller
Date: Thu, 8 Aug 2019 12:24:52 +0200
Message-ID: <20190808102452.GA648@lst.de>
References: <20190806231548.25242-1-jgg@ziepe.ca> <20190806231548.25242-2-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190806231548.25242-2-jgg@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>, Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Dimitri Sivanich <sivanich@sgi.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org, Gavin Shan <shangw@linux.vnet.ibm.com>, Andrea Righi <andrea@betterlinux.com>, Jason Gunthorpe <jgg@mellanox.com>Christoph
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Aug 06, 2019 at 08:15:38PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This simplifies the code to not have so many one line functions and extra
> logic. __mmu_notifier_register() simply becomes the entry point to
> register the notifier, and the other one calls it under lock.
> 
> Also add a lockdep_assert to check that the callers are holding the lock
> as expected.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
