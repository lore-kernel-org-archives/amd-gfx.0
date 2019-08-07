From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 hmm 10/11] drm/amdkfd: use mmu_notifier_put
Date: Wed, 7 Aug 2019 11:42:05 +0000
Message-ID: <20190807114159.GA1571@mellanox.com>
References: <20190806231548.25242-1-jgg@ziepe.ca>
	<20190806231548.25242-11-jgg@ziepe.ca>
	<d58a1a8f-f80c-edfe-4b57-6fde9c0ca180@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d58a1a8f-f80c-edfe-4b57-6fde9c0ca180-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <FEC4B53D5BFE794F897559B0282A7946-wNKe6lTLrGecE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Zhou,
	David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Dimitri Sivanich <sivanich-sJ/iWh9BUns@public.gmane.org>, Gavin Shan <shangw-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Andrea Righi <andrea-oIIqvOZpAevzfdHfmsDf5w@public.gmane.org>, "linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
	Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>Christ
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Aug 06, 2019 at 11:47:44PM +0000, Kuehling, Felix wrote:
> On 2019-08-06 19:15, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
> >
> > The sequence of mmu_notifier_unregister_no_release(),
> > mmu_notifier_call_srcu() is identical to mmu_notifier_put() with the
> > free_notifier callback.
> >
> > As this is the last user of those APIs, converting it means we can drop
> > them.
> >
> > Signed-off-by: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
> 
> Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> 
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 ++++------
> >   2 files changed, 4 insertions(+), 9 deletions(-)
> >
> > I'm really not sure what this is doing, but it is very strange to have a
> > release with no other callback. It would be good if this would change to use
> > get as well.
> KFD uses the MMU notifier to detect process termination and free all the 
> resources associated with the process. This was first added for APUs 
> where the IOMMUv2 is set up to perform address translations using the 
> CPU page table for device memory access. That's where the association of 
> KFD process resources with the lifetime of the mm_struct comes from.

When all the HW objects that could do DMA to this process are
destroyed then the mmu notififer should be torn down. The module
should remain locked until the DMA objects are destroyed.

I'm still unclear why this is needed, the IOMMU for PASID already has
notififers, and already blocks access when the mm_struct goes away,
why add a second layer of tracking?

Jason
