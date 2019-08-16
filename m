From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 hmm 00/11] Add mmu_notifier_get/put for managing mmu
 notifier registrations
Date: Fri, 16 Aug 2019 12:14:52 -0300
Message-ID: <20190816151452.GA8562@ziepe.ca>
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

> Jason Gunthorpe (11):
>   mm/mmu_notifiers: hoist do_mmu_notifier_register down_write to the
>     caller
>   mm/mmu_notifiers: do not speculatively allocate a mmu_notifier_mm
>   mm/mmu_notifiers: add a get/put scheme for the registration
>   misc/sgi-gru: use mmu_notifier_get/put for struct gru_mm_struct
>   hmm: use mmu_notifier_get/put for 'struct hmm'
>   drm/radeon: use mmu_notifier_get/put for struct radeon_mn
>   drm/amdkfd: fix a use after free race with mmu_notifer unregister
>   drm/amdkfd: use mmu_notifier_put

Other than these patches:

>   RDMA/odp: use mmu_notifier_get/put for 'struct ib_ucontext_per_mm'
>   RDMA/odp: remove ib_ucontext from ib_umem
>   mm/mmu_notifiers: remove unregister_no_release

This series has been applied.

I will apply the ODP patches when the series they depend on is merged
to the RDMA tree

Any further acks/remarks I will annotate, thanks in advance

Thanks to all reviewers,
Jason
