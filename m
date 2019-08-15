From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 hmm 03/11] mm/mmu_notifiers: add a get/put scheme for
 the registration
Date: Wed, 14 Aug 2019 21:13:19 -0300
Message-ID: <20190815001319.GF11200@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
 <20190806231548.25242-4-jgg@ziepe.ca>
 <0a23adb8-b827-cd90-503e-bfa84166c67e@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0a23adb8-b827-cd90-503e-bfa84166c67e@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Campbell <rcampbell@nvidia.com>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>, Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Dimitri Sivanich <sivanich@sgi.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org, Gavin Shan <shangw@linux.vnet.ibm.com>, Andrea Righi <andrea@betterlinux.com>, Christoph Hellwig <hch@infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Aug 14, 2019 at 02:20:31PM -0700, Ralph Campbell wrote:
> 
> On 8/6/19 4:15 PM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > Many places in the kernel have a flow where userspace will create some
> > object and that object will need to connect to the subsystem's
> > mmu_notifier subscription for the duration of its lifetime.
> > 
> > In this case the subsystem is usually tracking multiple mm_structs and it
> > is difficult to keep track of what struct mmu_notifier's have been
> > allocated for what mm's.
> > 
> > Since this has been open coded in a variety of exciting ways, provide core
> > functionality to do this safely.
> > 
> > This approach uses the strct mmu_notifier_ops * as a key to determine if
> 
> s/strct/struct

Yes, thanks for all of this, I like having comments, but I'm a
terrible proofreader :(

Jason
