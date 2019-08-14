From: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v3 hmm 05/11] hmm: use mmu_notifier_get/put for 'struct
 hmm'
Date: Wed, 14 Aug 2019 14:51:02 -0700
Message-ID: <66053b82-18d8-217a-b8fd-91981f66f512@nvidia.com>
References: <20190806231548.25242-1-jgg@ziepe.ca>
 <20190806231548.25242-6-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806231548.25242-6-jgg@ziepe.ca>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Dimitri Sivanich <sivanich@sgi.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org, Gavin Shan <shangw@linux.vnet.ibm.com>, Andrea Righi <andrea@betterlinux.com>, Jason Gunthorpe <jgg@mellanox.com>
List-Id: amd-gfx.lists.freedesktop.org


On 8/6/19 4:15 PM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This is a significant simplification, it eliminates all the remaining
> 'hmm' stuff in mm_struct, eliminates krefing along the critical notifier
> paths, and takes away all the ugly locking and abuse of page_table_lock.
> 
> mmu_notifier_get() provides the single struct hmm per struct mm which
> eliminates mm->hmm.
> 
> It also directly guarantees that no mmu_notifier op callback is callable
> while concurrent free is possible, this eliminates all the krefs inside
> the mmu_notifier callbacks.
> 
> The remaining krefs in the range code were overly cautious, drivers are
> already not permitted to free the mirror while a range exists.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Looks good.
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
