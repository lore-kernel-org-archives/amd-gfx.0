From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 hmm 00/11] Add mmu_notifier_get/put for managing mmu
 notifier registrations
Date: Wed, 21 Aug 2019 16:53:02 -0300
Message-ID: <20190821195302.GA22164@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190806231548.25242-1-jgg@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Dimitri Sivanich <sivanich@sgi.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org, Gavin Shan <shangw@linux.vnet.ibm.com>, Andrea Righi <andrea@betterlinux.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Aug 06, 2019 at 08:15:37PM -0300, Jason Gunthorpe wrote:
 
> This series is already entangled with patches in the hmm & RDMA tree and
> will require some git topic branches for the RDMA ODP stuff. I intend for
> it to go through the hmm tree.

The RDMA related patches have been applied to the RDMA tree on a
shared topic branch, so I've merged that into hmm.git and applied the
last patches from this series on top:

>   RDMA/odp: use mmu_notifier_get/put for 'struct ib_ucontext_per_mm'
>   RDMA/odp: remove ib_ucontext from ib_umem
>   mm/mmu_notifiers: remove unregister_no_release

There was some conflict churn in the RDMA ODP patches vs what was used
to the patches from this series, I fixed it up. Now I'm waiting for
some testing feedback before pushing it to linux-next

Thanks,
Jason
