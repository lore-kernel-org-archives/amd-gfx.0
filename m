From: =?UTF-8?Q?Christian_K=c3=b6nig?= via amd-gfx
 <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 02/11] dma-buf: add new dma_fence_chain container v4
Date: Fri, 15 Feb 2019 18:51:10 +0100
Message-ID: <a0b27d87-50f2-56ce-1db7-5a1dc005a798@gmail.com>
References: <20181207095601.2058-1-david1.zhou@amd.com>
 <20181207095601.2058-2-david1.zhou@amd.com>
 <6c2adaf5-6871-20be-a26d-182f8ca8ab8a@intel.com>
 <e170ceed-fdb7-8b4a-93d7-e565641390b3@amd.com>
 <bbae2023-8dee-692e-9549-40779a202587@intel.com>
 <CAOFGe96HUkzHPJKYT-07X3vMvCRD-=Hba1=Ke24qt_PY2vn0YQ@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1979289415=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAOFGe96HUkzHPJKYT-07X3vMvCRD-=Hba1=Ke24qt_PY2vn0YQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>, Lionel Landwerlin <lionel.g.landwerlin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1979289415==
Content-Type: multipart/alternative;
 boundary="------------AA379EB71190AF8B37FF2AFF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------AA379EB71190AF8B37FF2AFF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.02.19 um 17:49 schrieb Jason Ekstrand:
> On Fri, Feb 15, 2019 at 9:52 AM Lionel Landwerlin via dri-devel 
> <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> wrote:
>
>     On 15/02/2019 14:32, Koenig, Christian wrote:
>     > Am 15.02.19 um 15:23 schrieb Lionel Landwerlin:
>     >> Hi Christian, David,
>     >>
>     >> For timeline semaphore we need points to signaled in order.
>     >> I'm struggling to understand how this fence-chain implementation
>     >> preserves ordering of the seqnos.
>     >>
>     >> One of the scenario I can see an issue happening is when you have a
>     >> timeline with points 1 & 2 and userspace submits for 2 different
>     >> engines :
>     >>      - first with let's say a blitter style engine on point 2
>     >>      - then a 3d style engine on point 1
>     > Yeah, and where exactly is the problem?
>     >
>     > Seqno 1 will signal when the 3d style engine finishes work.
>     >
>     > And seqno 2 will signal when both seqno 1 is signaled and the
>     blitter
>     > style engine has finished its work.
>
>
> That's an interesting interpretation of the spec.  I think it's legal 
> and I could see that behavior may be desirable in some ways.

Well we actually had this discussion multiple times now, both internally 
as well as on the mailing list. Please also see the previous mails with 
Daniel on this topic.

My initial suggestion was actually to exactly what Leonid suggested as well.

And following this I used a rather simple container for the 
implementation, e.g. just a ring buffer indexed by the sequence number. 
In this scenario userspace can specify on syncobj creation time how big 
the window for sequence numbers should be, e.g. in this implementation 
how big the ring buffer would be.

This was rejected by our guys who actually wrote a good part of the 
Vulkan specification. Daniel then has gone into the same direction 
during the public discussion.

[SNIP]
> I think what Christian is suggesting is a valid interpretation of the 
> spec though it is rather unconventional.  The Vulkan spec, as it 
> stands today, requires that the application ensure that at the time of 
> signaling, the timeline semaphore value increases.  This means that 
> all of the above possible cases are technically illegal in Vulkan and 
> so it doesn't really matter what we do as long as we don't do anyting 
> especially stupid.

And exactly that's the point. When an application does something stupid 
with its own submissions then this is not much of a problem.

But this interface is meant to be made for communication between 
processes, and here we want to be sure that nobody can do anything stupid.

> My understanding of how this works on Windows is that a wait operation 
> on 3 is a wait until x >= 3 where x is a 64-bit value and a signal 
> operation is simply a write to x. This means that, in the above cases, 
> waits on 1 will be triggered immediately when 2 is written but waits 
> on 2 may or may not happen at all depending on whether the GPU write 
> which overwrites x to 1 or the CPU (or potentially GPU in a different 
> context) read gets there first such that the reader observes 2.  If 
> you mess this up and something isn't signaled, that's your fault.

Yeah and I think that this is actually not a good idea at all. 
Implementing it like this ultimately means that you can only use polling 
on the number.

>  4. If you do get into a sticky situation, you can unblock an entire 
> timeline by using the CPU signal ioctl to set it to a high value.

Well I think that this could be problematic as well. Keep in mind that 
main use case for this is sharing timelines between processes.

In other words you don't want applications to be able to mess with it to 
much.

>
> Of all these reasons, I think 1 and 2 carry the most weight.  2, in 
> particular, is interesting if we one day want to implement the same 
> behavior with a simple 64-bit value like Windows does.  Immagine, for 
> instance, a scenario where the GPU is doing it's own scheduling or 
> command buffers are submitted ahead of the signal operation being 
> available and told to just sit on the GPU until they see x >= 3.  
> (Yes, there are issues here with residency, contention, etc.  I'm 
> asking you to use your immagination.)  Assuming you can do 64-bit 
> atomics (there are aparently issues here with PCIe that make things 
> sticky), the behavior I'm suggesting is completely implementable in 
> that way whereas the behavior Christian is suggesting is only 
> implementable if you're maintaining a CPU-side list of fences.  I 
> don't think we want to paint ourselves into that corner.

Actually we already had such an implementation with radeon. And I can 
only say that it was a totally PAIN IN THE A* to maintain.

This is one of the reason why we are not using hardware semaphores any 
more with amdgpu.

Regards,
Christian.

>
> --Jason
>
>     >
>     > Regards,
>     > Christian.
>     >
>     >> -Lionel
>     >>
>     >> On 07/12/2018 09:55, Chunming Zhou wrote:
>     >>> From: Christian König <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>     <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>     >>>
>     >>> Lockless container implementation similar to a
>     dma_fence_array, but with
>     >>> only two elements per node and automatic garbage collection.
>     >>>
>     >>> v2: properly document dma_fence_chain_for_each, add
>     >>> dma_fence_chain_find_seqno,
>     >>>       drop prev reference during garbage collection if it's not a
>     >>> chain fence.
>     >>> v3: use head and iterator for dma_fence_chain_for_each
>     >>> v4: fix reference count in dma_fence_chain_enable_signaling
>     >>>
>     >>> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org
>     <mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>>
>     >>> ---
>     >>>    drivers/dma-buf/Makefile          |   3 +-
>     >>>    drivers/dma-buf/dma-fence-chain.c | 241
>     ++++++++++++++++++++++++++++++
>     >>>    include/linux/dma-fence-chain.h   |  81 ++++++++++
>     >>>    3 files changed, 324 insertions(+), 1 deletion(-)
>     >>>    create mode 100644 drivers/dma-buf/dma-fence-chain.c
>     >>>    create mode 100644 include/linux/dma-fence-chain.h
>     >>>
>     >>> diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
>     >>> index 0913a6ccab5a..1f006e083eb9 100644
>     >>> --- a/drivers/dma-buf/Makefile
>     >>> +++ b/drivers/dma-buf/Makefile
>     >>> @@ -1,4 +1,5 @@
>     >>> -obj-y := dma-buf.o dma-fence.o dma-fence-array.o reservation.o
>     >>> seqno-fence.o
>     >>> +obj-y := dma-buf.o dma-fence.o dma-fence-array.o
>     dma-fence-chain.o \
>     >>> +     reservation.o seqno-fence.o
>     >>>    obj-$(CONFIG_SYNC_FILE)        += sync_file.o
>     >>>    obj-$(CONFIG_SW_SYNC)        += sw_sync.o sync_debug.o
>     >>>    obj-$(CONFIG_UDMABUF)        += udmabuf.o
>     >>> diff --git a/drivers/dma-buf/dma-fence-chain.c
>     >>> b/drivers/dma-buf/dma-fence-chain.c
>     >>> new file mode 100644
>     >>> index 000000000000..0c5e3c902fa0
>     >>> --- /dev/null
>     >>> +++ b/drivers/dma-buf/dma-fence-chain.c
>     >>> @@ -0,0 +1,241 @@
>     >>> +/*
>     >>> + * fence-chain: chain fences together in a timeline
>     >>> + *
>     >>> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
>     >>> + * Authors:
>     >>> + *    Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org
>     <mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>>
>     >>> + *
>     >>> + * This program is free software; you can redistribute it and/or
>     >>> modify it
>     >>> + * under the terms of the GNU General Public License version 2 as
>     >>> published by
>     >>> + * the Free Software Foundation.
>     >>> + *
>     >>> + * This program is distributed in the hope that it will be
>     useful,
>     >>> but WITHOUT
>     >>> + * ANY WARRANTY; without even the implied warranty of
>     >>> MERCHANTABILITY or
>     >>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
>     >>> License for
>     >>> + * more details.
>     >>> + */
>     >>> +
>     >>> +#include <linux/dma-fence-chain.h>
>     >>> +
>     >>> +static bool dma_fence_chain_enable_signaling(struct dma_fence
>     *fence);
>     >>> +
>     >>> +/**
>     >>> + * dma_fence_chain_get_prev - use RCU to get a reference to the
>     >>> previous fence
>     >>> + * @chain: chain node to get the previous node from
>     >>> + *
>     >>> + * Use dma_fence_get_rcu_safe to get a reference to the previous
>     >>> fence of the
>     >>> + * chain node.
>     >>> + */
>     >>> +static struct dma_fence *dma_fence_chain_get_prev(struct
>     >>> dma_fence_chain *chain)
>     >>> +{
>     >>> +    struct dma_fence *prev;
>     >>> +
>     >>> +    rcu_read_lock();
>     >>> +    prev = dma_fence_get_rcu_safe(&chain->prev);
>     >>> +    rcu_read_unlock();
>     >>> +    return prev;
>     >>> +}
>     >>> +
>     >>> +/**
>     >>> + * dma_fence_chain_walk - chain walking function
>     >>> + * @fence: current chain node
>     >>> + *
>     >>> + * Walk the chain to the next node. Returns the next fence or
>     NULL
>     >>> if we are at
>     >>> + * the end of the chain. Garbage collects chain nodes which
>     are already
>     >>> + * signaled.
>     >>> + */
>     >>> +struct dma_fence *dma_fence_chain_walk(struct dma_fence *fence)
>     >>> +{
>     >>> +    struct dma_fence_chain *chain, *prev_chain;
>     >>> +    struct dma_fence *prev, *replacement, *tmp;
>     >>> +
>     >>> +    chain = to_dma_fence_chain(fence);
>     >>> +    if (!chain) {
>     >>> +        dma_fence_put(fence);
>     >>> +        return NULL;
>     >>> +    }
>     >>> +
>     >>> +    while ((prev = dma_fence_chain_get_prev(chain))) {
>     >>> +
>     >>> +        prev_chain = to_dma_fence_chain(prev);
>     >>> +        if (prev_chain) {
>     >>> +            if (!dma_fence_is_signaled(prev_chain->fence))
>     >>> +                break;
>     >>> +
>     >>> +            replacement = dma_fence_chain_get_prev(prev_chain);
>     >>> +        } else {
>     >>> +            if (!dma_fence_is_signaled(prev))
>     >>> +                break;
>     >>> +
>     >>> +            replacement = NULL;
>     >>> +        }
>     >>> +
>     >>> +        tmp = cmpxchg(&chain->prev, prev, replacement);
>     >>> +        if (tmp == prev)
>     >>> +            dma_fence_put(tmp);
>     >>> +        else
>     >>> +            dma_fence_put(replacement);
>     >>> +        dma_fence_put(prev);
>     >>> +    }
>     >>> +
>     >>> +    dma_fence_put(fence);
>     >>> +    return prev;
>     >>> +}
>     >>> +EXPORT_SYMBOL(dma_fence_chain_walk);
>     >>> +
>     >>> +/**
>     >>> + * dma_fence_chain_find_seqno - find fence chain node by seqno
>     >>> + * @pfence: pointer to the chain node where to start
>     >>> + * @seqno: the sequence number to search for
>     >>> + *
>     >>> + * Advance the fence pointer to the chain node which will signal
>     >>> this sequence
>     >>> + * number. If no sequence number is provided then this is a
>     no-op.
>     >>> + *
>     >>> + * Returns EINVAL if the fence is not a chain node or the
>     sequence
>     >>> number has
>     >>> + * not yet advanced far enough.
>     >>> + */
>     >>> +int dma_fence_chain_find_seqno(struct dma_fence **pfence,
>     uint64_t
>     >>> seqno)
>     >>> +{
>     >>> +    struct dma_fence_chain *chain;
>     >>> +
>     >>> +    if (!seqno)
>     >>> +        return 0;
>     >>> +
>     >>> +    chain = to_dma_fence_chain(*pfence);
>     >>> +    if (!chain || chain->base.seqno < seqno)
>     >>> +        return -EINVAL;
>     >>> +
>     >>> +    dma_fence_chain_for_each(*pfence, &chain->base) {
>     >>> +        if ((*pfence)->context != chain->base.context ||
>     >>> + to_dma_fence_chain(*pfence)->prev_seqno < seqno)
>     >>> +            break;
>     >>> +    }
>     >>> +    dma_fence_put(&chain->base);
>     >>> +
>     >>> +    return 0;
>     >>> +}
>     >>> +EXPORT_SYMBOL(dma_fence_chain_find_seqno);
>     >>> +
>     >>> +static const char *dma_fence_chain_get_driver_name(struct
>     dma_fence
>     >>> *fence)
>     >>> +{
>     >>> +        return "dma_fence_chain";
>     >>> +}
>     >>> +
>     >>> +static const char *dma_fence_chain_get_timeline_name(struct
>     >>> dma_fence *fence)
>     >>> +{
>     >>> +        return "unbound";
>     >>> +}
>     >>> +
>     >>> +static void dma_fence_chain_irq_work(struct irq_work *work)
>     >>> +{
>     >>> +    struct dma_fence_chain *chain;
>     >>> +
>     >>> +    chain = container_of(work, typeof(*chain), work);
>     >>> +
>     >>> +    /* Try to rearm the callback */
>     >>> +    if (!dma_fence_chain_enable_signaling(&chain->base))
>     >>> +        /* Ok, we are done. No more unsignaled fences left */
>     >>> +        dma_fence_signal(&chain->base);
>     >>> +    dma_fence_put(&chain->base);
>     >>> +}
>     >>> +
>     >>> +static void dma_fence_chain_cb(struct dma_fence *f, struct
>     >>> dma_fence_cb *cb)
>     >>> +{
>     >>> +    struct dma_fence_chain *chain;
>     >>> +
>     >>> +    chain = container_of(cb, typeof(*chain), cb);
>     >>> +    irq_work_queue(&chain->work);
>     >>> +    dma_fence_put(f);
>     >>> +}
>     >>> +
>     >>> +static bool dma_fence_chain_enable_signaling(struct dma_fence
>     *fence)
>     >>> +{
>     >>> +    struct dma_fence_chain *head = to_dma_fence_chain(fence);
>     >>> +
>     >>> +    dma_fence_get(&head->base);
>     >>> +    dma_fence_chain_for_each(fence, &head->base) {
>     >>> +        struct dma_fence_chain *chain =
>     to_dma_fence_chain(fence);
>     >>> +        struct dma_fence *f = chain ? chain->fence : fence;
>     >>> +
>     >>> +        dma_fence_get(f);
>     >>> +        if (!dma_fence_add_callback(f, &head->cb,
>     >>> dma_fence_chain_cb)) {
>     >>> +            dma_fence_put(fence);
>     >>> +            return true;
>     >>> +        }
>     >>> +        dma_fence_put(f);
>     >>> +    }
>     >>> +    dma_fence_put(&head->base);
>     >>> +    return false;
>     >>> +}
>     >>> +
>     >>> +static bool dma_fence_chain_signaled(struct dma_fence *fence)
>     >>> +{
>     >>> +    dma_fence_chain_for_each(fence, fence) {
>     >>> +        struct dma_fence_chain *chain =
>     to_dma_fence_chain(fence);
>     >>> +        struct dma_fence *f = chain ? chain->fence : fence;
>     >>> +
>     >>> +        if (!dma_fence_is_signaled(f)) {
>     >>> +            dma_fence_put(fence);
>     >>> +            return false;
>     >>> +        }
>     >>> +    }
>     >>> +
>     >>> +    return true;
>     >>> +}
>     >>> +
>     >>> +static void dma_fence_chain_release(struct dma_fence *fence)
>     >>> +{
>     >>> +    struct dma_fence_chain *chain = to_dma_fence_chain(fence);
>     >>> +
>     >>> +    dma_fence_put(chain->prev);
>     >>> +    dma_fence_put(chain->fence);
>     >>> +    dma_fence_free(fence);
>     >>> +}
>     >>> +
>     >>> +const struct dma_fence_ops dma_fence_chain_ops = {
>     >>> +    .get_driver_name = dma_fence_chain_get_driver_name,
>     >>> +    .get_timeline_name = dma_fence_chain_get_timeline_name,
>     >>> +    .enable_signaling = dma_fence_chain_enable_signaling,
>     >>> +    .signaled = dma_fence_chain_signaled,
>     >>> +    .release = dma_fence_chain_release,
>     >>> +};
>     >>> +EXPORT_SYMBOL(dma_fence_chain_ops);
>     >>> +
>     >>> +/**
>     >>> + * dma_fence_chain_init - initialize a fence chain
>     >>> + * @chain: the chain node to initialize
>     >>> + * @prev: the previous fence
>     >>> + * @fence: the current fence
>     >>> + *
>     >>> + * Initialize a new chain node and either start a new chain
>     or add
>     >>> the node to
>     >>> + * the existing chain of the previous fence.
>     >>> + */
>     >>> +void dma_fence_chain_init(struct dma_fence_chain *chain,
>     >>> +              struct dma_fence *prev,
>     >>> +              struct dma_fence *fence,
>     >>> +              uint64_t seqno)
>     >>> +{
>     >>> +    struct dma_fence_chain *prev_chain =
>     to_dma_fence_chain(prev);
>     >>> +    uint64_t context;
>     >>> +
>     >>> +    spin_lock_init(&chain->lock);
>     >>> +    chain->prev = prev;
>     >>> +    chain->fence = fence;
>     >>> +    chain->prev_seqno = 0;
>     >>> +    init_irq_work(&chain->work, dma_fence_chain_irq_work);
>     >>> +
>     >>> +    /* Try to reuse the context of the previous chain node. */
>     >>> +    if (prev_chain && __dma_fence_is_later(seqno, prev->seqno)) {
>     >>> +        context = prev->context;
>     >>> +        chain->prev_seqno = prev->seqno;
>     >>> +    } else {
>     >>> +        context = dma_fence_context_alloc(1);
>     >>> +        /* Make sure that we always have a valid sequence
>     number. */
>     >>> +        if (prev_chain)
>     >>> +            seqno = max(prev->seqno, seqno);
>     >>> +    }
>     >>> +
>     >>> +    dma_fence_init(&chain->base, &dma_fence_chain_ops,
>     >>> +               &chain->lock, context, seqno);
>     >>> +}
>     >>> +EXPORT_SYMBOL(dma_fence_chain_init);
>     >>> diff --git a/include/linux/dma-fence-chain.h
>     >>> b/include/linux/dma-fence-chain.h
>     >>> new file mode 100644
>     >>> index 000000000000..a5c2e8c6915c
>     >>> --- /dev/null
>     >>> +++ b/include/linux/dma-fence-chain.h
>     >>> @@ -0,0 +1,81 @@
>     >>> +/*
>     >>> + * fence-chain: chain fences together in a timeline
>     >>> + *
>     >>> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
>     >>> + * Authors:
>     >>> + *    Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org
>     <mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>>
>     >>> + *
>     >>> + * This program is free software; you can redistribute it and/or
>     >>> modify it
>     >>> + * under the terms of the GNU General Public License version 2 as
>     >>> published by
>     >>> + * the Free Software Foundation.
>     >>> + *
>     >>> + * This program is distributed in the hope that it will be
>     useful,
>     >>> but WITHOUT
>     >>> + * ANY WARRANTY; without even the implied warranty of
>     >>> MERCHANTABILITY or
>     >>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
>     >>> License for
>     >>> + * more details.
>     >>> + */
>     >>> +
>     >>> +#ifndef __LINUX_DMA_FENCE_CHAIN_H
>     >>> +#define __LINUX_DMA_FENCE_CHAIN_H
>     >>> +
>     >>> +#include <linux/dma-fence.h>
>     >>> +#include <linux/irq_work.h>
>     >>> +
>     >>> +/**
>     >>> + * struct dma_fence_chain - fence to represent an node of a
>     fence chain
>     >>> + * @base: fence base class
>     >>> + * @lock: spinlock for fence handling
>     >>> + * @prev: previous fence of the chain
>     >>> + * @prev_seqno: original previous seqno before garbage collection
>     >>> + * @fence: encapsulated fence
>     >>> + * @cb: callback structure for signaling
>     >>> + * @work: irq work item for signaling
>     >>> + */
>     >>> +struct dma_fence_chain {
>     >>> +    struct dma_fence base;
>     >>> +    spinlock_t lock;
>     >>> +    struct dma_fence *prev;
>     >>> +    u64 prev_seqno;
>     >>> +    struct dma_fence *fence;
>     >>> +    struct dma_fence_cb cb;
>     >>> +    struct irq_work work;
>     >>> +};
>     >>> +
>     >>> +extern const struct dma_fence_ops dma_fence_chain_ops;
>     >>> +
>     >>> +/**
>     >>> + * to_dma_fence_chain - cast a fence to a dma_fence_chain
>     >>> + * @fence: fence to cast to a dma_fence_array
>     >>> + *
>     >>> + * Returns NULL if the fence is not a dma_fence_chain,
>     >>> + * or the dma_fence_chain otherwise.
>     >>> + */
>     >>> +static inline struct dma_fence_chain *
>     >>> +to_dma_fence_chain(struct dma_fence *fence)
>     >>> +{
>     >>> +    if (!fence || fence->ops != &dma_fence_chain_ops)
>     >>> +        return NULL;
>     >>> +
>     >>> +    return container_of(fence, struct dma_fence_chain, base);
>     >>> +}
>     >>> +
>     >>> +/**
>     >>> + * dma_fence_chain_for_each - iterate over all fences in chain
>     >>> + * @iter: current fence
>     >>> + * @head: starting point
>     >>> + *
>     >>> + * Iterate over all fences in the chain. We keep a reference
>     to the
>     >>> current
>     >>> + * fence while inside the loop which must be dropped when
>     breaking out.
>     >>> + */
>     >>> +#define dma_fence_chain_for_each(iter, head)    \
>     >>> +    for (iter = dma_fence_get(head); iter; \
>     >>> +         iter = dma_fence_chain_walk(head))
>     >>> +
>     >>> +struct dma_fence *dma_fence_chain_walk(struct dma_fence *fence);
>     >>> +int dma_fence_chain_find_seqno(struct dma_fence **pfence,
>     uint64_t
>     >>> seqno);
>     >>> +void dma_fence_chain_init(struct dma_fence_chain *chain,
>     >>> +              struct dma_fence *prev,
>     >>> +              struct dma_fence *fence,
>     >>> +              uint64_t seqno);
>     >>> +
>     >>> +#endif /* __LINUX_DMA_FENCE_CHAIN_H */
>     >>
>
>     _______________________________________________
>     dri-devel mailing list
>     dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     https://lists.freedesktop.org/mailman/listinfo/dri-devel
>


--------------AA379EB71190AF8B37FF2AFF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 15.02.19 um 17:49 schrieb Jason
      Ekstrand:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAOFGe96HUkzHPJKYT-07X3vMvCRD-=Hba1=Ke24qt_PY2vn0YQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Fri, Feb 15, 2019 at 9:52
            AM Lionel Landwerlin via dri-devel &lt;<a
              href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
              moz-do-not-send="true">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">On 15/02/2019 14:32,
            Koenig, Christian wrote:<br>
            &gt; Am 15.02.19 um 15:23 schrieb Lionel Landwerlin:<br>
            &gt;&gt; Hi Christian, David,<br>
            &gt;&gt;<br>
            &gt;&gt; For timeline semaphore we need points to signaled
            in order.<br>
            &gt;&gt; I'm struggling to understand how this fence-chain
            implementation<br>
            &gt;&gt; preserves ordering of the seqnos.<br>
            &gt;&gt;<br>
            &gt;&gt; One of the scenario I can see an issue happening is
            when you have a<br>
            &gt;&gt; timeline with points 1 &amp; 2 and userspace
            submits for 2 different<br>
            &gt;&gt; engines :<br>
            &gt;&gt;      - first with let's say a blitter style engine
            on point 2<br>
            &gt;&gt;      - then a 3d style engine on point 1<br>
            &gt; Yeah, and where exactly is the problem?<br>
            &gt;<br>
            &gt; Seqno 1 will signal when the 3d style engine finishes
            work.<br>
            &gt;<br>
            &gt; And seqno 2 will signal when both seqno 1 is signaled
            and the blitter<br>
            &gt; style engine has finished its work.<br>
          </blockquote>
          <div><br>
          </div>
          <div>That's an interesting interpretation of the spec.  I
            think it's legal and I could see that behavior may be
            desirable in some ways.<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Well we actually had this discussion multiple times now, both
    internally as well as on the mailing list. Please also see the
    previous mails with Daniel on this topic.<br>
    <br>
    My initial suggestion was actually to exactly what Leonid suggested
    as well.<br>
    <br>
    And following this I used a rather simple container for the
    implementation, e.g. just a ring buffer indexed by the sequence
    number. In this scenario userspace can specify on syncobj creation
    time how big the window for sequence numbers should be, e.g. in this
    implementation how big the ring buffer would be.<br>
    <br>
    This was rejected by our guys who actually wrote a good part of the
    Vulkan specification. Daniel then has gone into the same direction
    during the public discussion.<br>
    <br>
    [SNIP]<br>
    <blockquote type="cite"
cite="mid:CAOFGe96HUkzHPJKYT-07X3vMvCRD-=Hba1=Ke24qt_PY2vn0YQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_quote">
          <div>I think what Christian is suggesting is a valid
            interpretation of the spec though it is rather
            unconventional.  The Vulkan spec, as it stands today,
            requires that the application ensure that at the time of
            signaling, the timeline semaphore value increases.  This
            means that all of the above possible cases are technically
            illegal in Vulkan and so it doesn't really matter what we do
            as long as we don't do anyting especially stupid.</div>
        </div>
      </div>
    </blockquote>
    <br>
    And exactly that's the point. When an application does something
    stupid with its own submissions then this is not much of a problem.<br>
    <br>
    But this interface is meant to be made for communication between
    processes, and here we want to be sure that nobody can do anything
    stupid.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAOFGe96HUkzHPJKYT-07X3vMvCRD-=Hba1=Ke24qt_PY2vn0YQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_quote">
          <div>My understanding of how this works on Windows is that a
            wait operation on 3 is a wait until x &gt;= 3 where x is a
            64-bit value and a signal operation is simply a write to x. 
            This means that, in the above cases, waits on 1 will be
            triggered immediately when 2 is written but waits on 2 may
            or may not happen at all depending on whether the GPU write
            which overwrites x to 1 or the CPU (or potentially GPU in a
            different context) read gets there first such that the
            reader observes 2.  If you mess this up and something isn't
            signaled, that's your fault.</div>
        </div>
      </div>
    </blockquote>
    <br>
    Yeah and I think that this is actually not a good idea at all.
    Implementing it like this ultimately means that you can only use
    polling on the number.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAOFGe96HUkzHPJKYT-07X3vMvCRD-=Hba1=Ke24qt_PY2vn0YQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_quote">
          <div> 4. If you do get into a sticky situation, you can
            unblock an entire timeline by using the CPU signal ioctl to
            set it to a high value. <br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Well I think that this could be problematic as well. Keep in mind
    that main use case for this is sharing timelines between processes.<br>
    <br>
    In other words you don't want applications to be able to mess with
    it to much.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAOFGe96HUkzHPJKYT-07X3vMvCRD-=Hba1=Ke24qt_PY2vn0YQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <div>Of all these reasons, I think 1 and 2 carry the most
            weight.  2, in particular, is interesting if we one day want
            to implement the same behavior with a simple 64-bit value
            like Windows does.  Immagine, for instance, a scenario where
            the GPU is doing it's own scheduling or command buffers are
            submitted ahead of the signal operation being available and
            told to just sit on the GPU until they see x &gt;= 3.  (Yes,
            there are issues here with residency, contention, etc.  I'm
            asking you to use your immagination.)  Assuming you can do
            64-bit atomics (there are aparently issues here with PCIe
            that make things sticky), the behavior I'm suggesting is
            completely implementable in that way whereas the behavior
            Christian is suggesting is only implementable if you're
            maintaining a CPU-side list of fences.  I don't think we
            want to paint ourselves into that corner.</div>
        </div>
      </div>
    </blockquote>
    <br>
    Actually we already had such an implementation with radeon. And I
    can only say that it was a totally PAIN IN THE A* to maintain.<br>
    <br>
    This is one of the reason why we are not using hardware semaphores
    any more with amdgpu.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAOFGe96HUkzHPJKYT-07X3vMvCRD-=Hba1=Ke24qt_PY2vn0YQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <div>--Jason<br>
          </div>
          <div> </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            &gt;<br>
            &gt; Regards,<br>
            &gt; Christian.<br>
            &gt;<br>
            &gt;&gt; -Lionel<br>
            &gt;&gt;<br>
            &gt;&gt; On 07/12/2018 09:55, Chunming Zhou wrote:<br>
            &gt;&gt;&gt; From: Christian König &lt;<a
              href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
              target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; Lockless container implementation similar to a
            dma_fence_array, but with<br>
            &gt;&gt;&gt; only two elements per node and automatic
            garbage collection.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; v2: properly document dma_fence_chain_for_each,
            add<br>
            &gt;&gt;&gt; dma_fence_chain_find_seqno,<br>
            &gt;&gt;&gt;       drop prev reference during garbage
            collection if it's not a<br>
            &gt;&gt;&gt; chain fence.<br>
            &gt;&gt;&gt; v3: use head and iterator for
            dma_fence_chain_for_each<br>
            &gt;&gt;&gt; v4: fix reference count in
            dma_fence_chain_enable_signaling<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; Signed-off-by: Christian König &lt;<a
              href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target="_blank"
              moz-do-not-send="true">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
            &gt;&gt;&gt; ---<br>
            &gt;&gt;&gt;    drivers/dma-buf/Makefile          |   3 +-<br>
            &gt;&gt;&gt;    drivers/dma-buf/dma-fence-chain.c | 241
            ++++++++++++++++++++++++++++++<br>
            &gt;&gt;&gt;    include/linux/dma-fence-chain.h   |  81
            ++++++++++<br>
            &gt;&gt;&gt;    3 files changed, 324 insertions(+), 1
            deletion(-)<br>
            &gt;&gt;&gt;    create mode 100644
            drivers/dma-buf/dma-fence-chain.c<br>
            &gt;&gt;&gt;    create mode 100644
            include/linux/dma-fence-chain.h<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; diff --git a/drivers/dma-buf/Makefile
            b/drivers/dma-buf/Makefile<br>
            &gt;&gt;&gt; index 0913a6ccab5a..1f006e083eb9 100644<br>
            &gt;&gt;&gt; --- a/drivers/dma-buf/Makefile<br>
            &gt;&gt;&gt; +++ b/drivers/dma-buf/Makefile<br>
            &gt;&gt;&gt; @@ -1,4 +1,5 @@<br>
            &gt;&gt;&gt; -obj-y := dma-buf.o dma-fence.o
            dma-fence-array.o reservation.o<br>
            &gt;&gt;&gt; seqno-fence.o<br>
            &gt;&gt;&gt; +obj-y := dma-buf.o dma-fence.o
            dma-fence-array.o dma-fence-chain.o \<br>
            &gt;&gt;&gt; +     reservation.o seqno-fence.o<br>
            &gt;&gt;&gt;    obj-$(CONFIG_SYNC_FILE)        +=
            sync_file.o<br>
            &gt;&gt;&gt;    obj-$(CONFIG_SW_SYNC)        += sw_sync.o
            sync_debug.o<br>
            &gt;&gt;&gt;    obj-$(CONFIG_UDMABUF)        += udmabuf.o<br>
            &gt;&gt;&gt; diff --git a/drivers/dma-buf/dma-fence-chain.c<br>
            &gt;&gt;&gt; b/drivers/dma-buf/dma-fence-chain.c<br>
            &gt;&gt;&gt; new file mode 100644<br>
            &gt;&gt;&gt; index 000000000000..0c5e3c902fa0<br>
            &gt;&gt;&gt; --- /dev/null<br>
            &gt;&gt;&gt; +++ b/drivers/dma-buf/dma-fence-chain.c<br>
            &gt;&gt;&gt; @@ -0,0 +1,241 @@<br>
            &gt;&gt;&gt; +/*<br>
            &gt;&gt;&gt; + * fence-chain: chain fences together in a
            timeline<br>
            &gt;&gt;&gt; + *<br>
            &gt;&gt;&gt; + * Copyright (C) 2018 Advanced Micro Devices,
            Inc.<br>
            &gt;&gt;&gt; + * Authors:<br>
            &gt;&gt;&gt; + *    Christian König &lt;<a
              href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target="_blank"
              moz-do-not-send="true">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
            &gt;&gt;&gt; + *<br>
            &gt;&gt;&gt; + * This program is free software; you can
            redistribute it and/or<br>
            &gt;&gt;&gt; modify it<br>
            &gt;&gt;&gt; + * under the terms of the GNU General Public
            License version 2 as<br>
            &gt;&gt;&gt; published by<br>
            &gt;&gt;&gt; + * the Free Software Foundation.<br>
            &gt;&gt;&gt; + *<br>
            &gt;&gt;&gt; + * This program is distributed in the hope
            that it will be useful,<br>
            &gt;&gt;&gt; but WITHOUT<br>
            &gt;&gt;&gt; + * ANY WARRANTY; without even the implied
            warranty of<br>
            &gt;&gt;&gt; MERCHANTABILITY or<br>
            &gt;&gt;&gt; + * FITNESS FOR A PARTICULAR PURPOSE.  See the
            GNU General Public<br>
            &gt;&gt;&gt; License for<br>
            &gt;&gt;&gt; + * more details.<br>
            &gt;&gt;&gt; + */<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +#include &lt;linux/dma-fence-chain.h&gt;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +static bool
            dma_fence_chain_enable_signaling(struct dma_fence *fence);<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +/**<br>
            &gt;&gt;&gt; + * dma_fence_chain_get_prev - use RCU to get a
            reference to the<br>
            &gt;&gt;&gt; previous fence<br>
            &gt;&gt;&gt; + * @chain: chain node to get the previous node
            from<br>
            &gt;&gt;&gt; + *<br>
            &gt;&gt;&gt; + * Use dma_fence_get_rcu_safe to get a
            reference to the previous<br>
            &gt;&gt;&gt; fence of the<br>
            &gt;&gt;&gt; + * chain node.<br>
            &gt;&gt;&gt; + */<br>
            &gt;&gt;&gt; +static struct dma_fence
            *dma_fence_chain_get_prev(struct<br>
            &gt;&gt;&gt; dma_fence_chain *chain)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +    struct dma_fence *prev;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    rcu_read_lock();<br>
            &gt;&gt;&gt; +    prev =
            dma_fence_get_rcu_safe(&amp;chain-&gt;prev);<br>
            &gt;&gt;&gt; +    rcu_read_unlock();<br>
            &gt;&gt;&gt; +    return prev;<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +/**<br>
            &gt;&gt;&gt; + * dma_fence_chain_walk - chain walking
            function<br>
            &gt;&gt;&gt; + * @fence: current chain node<br>
            &gt;&gt;&gt; + *<br>
            &gt;&gt;&gt; + * Walk the chain to the next node. Returns
            the next fence or NULL<br>
            &gt;&gt;&gt; if we are at<br>
            &gt;&gt;&gt; + * the end of the chain. Garbage collects
            chain nodes which are already<br>
            &gt;&gt;&gt; + * signaled.<br>
            &gt;&gt;&gt; + */<br>
            &gt;&gt;&gt; +struct dma_fence *dma_fence_chain_walk(struct
            dma_fence *fence)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +    struct dma_fence_chain *chain,
            *prev_chain;<br>
            &gt;&gt;&gt; +    struct dma_fence *prev, *replacement,
            *tmp;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    chain = to_dma_fence_chain(fence);<br>
            &gt;&gt;&gt; +    if (!chain) {<br>
            &gt;&gt;&gt; +        dma_fence_put(fence);<br>
            &gt;&gt;&gt; +        return NULL;<br>
            &gt;&gt;&gt; +    }<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    while ((prev =
            dma_fence_chain_get_prev(chain))) {<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +        prev_chain = to_dma_fence_chain(prev);<br>
            &gt;&gt;&gt; +        if (prev_chain) {<br>
            &gt;&gt;&gt; +            if
            (!dma_fence_is_signaled(prev_chain-&gt;fence))<br>
            &gt;&gt;&gt; +                break;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +            replacement =
            dma_fence_chain_get_prev(prev_chain);<br>
            &gt;&gt;&gt; +        } else {<br>
            &gt;&gt;&gt; +            if (!dma_fence_is_signaled(prev))<br>
            &gt;&gt;&gt; +                break;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +            replacement = NULL;<br>
            &gt;&gt;&gt; +        }<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +        tmp = cmpxchg(&amp;chain-&gt;prev,
            prev, replacement);<br>
            &gt;&gt;&gt; +        if (tmp == prev)<br>
            &gt;&gt;&gt; +            dma_fence_put(tmp);<br>
            &gt;&gt;&gt; +        else<br>
            &gt;&gt;&gt; +            dma_fence_put(replacement);<br>
            &gt;&gt;&gt; +        dma_fence_put(prev);<br>
            &gt;&gt;&gt; +    }<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    dma_fence_put(fence);<br>
            &gt;&gt;&gt; +    return prev;<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +EXPORT_SYMBOL(dma_fence_chain_walk);<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +/**<br>
            &gt;&gt;&gt; + * dma_fence_chain_find_seqno - find fence
            chain node by seqno<br>
            &gt;&gt;&gt; + * @pfence: pointer to the chain node where to
            start<br>
            &gt;&gt;&gt; + * @seqno: the sequence number to search for<br>
            &gt;&gt;&gt; + *<br>
            &gt;&gt;&gt; + * Advance the fence pointer to the chain node
            which will signal<br>
            &gt;&gt;&gt; this sequence<br>
            &gt;&gt;&gt; + * number. If no sequence number is provided
            then this is a no-op.<br>
            &gt;&gt;&gt; + *<br>
            &gt;&gt;&gt; + * Returns EINVAL if the fence is not a chain
            node or the sequence<br>
            &gt;&gt;&gt; number has<br>
            &gt;&gt;&gt; + * not yet advanced far enough.<br>
            &gt;&gt;&gt; + */<br>
            &gt;&gt;&gt; +int dma_fence_chain_find_seqno(struct
            dma_fence **pfence, uint64_t<br>
            &gt;&gt;&gt; seqno)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +    struct dma_fence_chain *chain;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    if (!seqno)<br>
            &gt;&gt;&gt; +        return 0;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    chain = to_dma_fence_chain(*pfence);<br>
            &gt;&gt;&gt; +    if (!chain || chain-&gt;base.seqno &lt;
            seqno)<br>
            &gt;&gt;&gt; +        return -EINVAL;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    dma_fence_chain_for_each(*pfence,
            &amp;chain-&gt;base) {<br>
            &gt;&gt;&gt; +        if ((*pfence)-&gt;context !=
            chain-&gt;base.context ||<br>
            &gt;&gt;&gt; +           
            to_dma_fence_chain(*pfence)-&gt;prev_seqno &lt; seqno)<br>
            &gt;&gt;&gt; +            break;<br>
            &gt;&gt;&gt; +    }<br>
            &gt;&gt;&gt; +    dma_fence_put(&amp;chain-&gt;base);<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    return 0;<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +EXPORT_SYMBOL(dma_fence_chain_find_seqno);<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +static const char
            *dma_fence_chain_get_driver_name(struct dma_fence<br>
            &gt;&gt;&gt; *fence)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +        return "dma_fence_chain";<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +static const char
            *dma_fence_chain_get_timeline_name(struct<br>
            &gt;&gt;&gt; dma_fence *fence)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +        return "unbound";<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +static void dma_fence_chain_irq_work(struct
            irq_work *work)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +    struct dma_fence_chain *chain;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    chain = container_of(work, typeof(*chain),
            work);<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    /* Try to rearm the callback */<br>
            &gt;&gt;&gt; +    if
            (!dma_fence_chain_enable_signaling(&amp;chain-&gt;base))<br>
            &gt;&gt;&gt; +        /* Ok, we are done. No more unsignaled
            fences left */<br>
            &gt;&gt;&gt; +        dma_fence_signal(&amp;chain-&gt;base);<br>
            &gt;&gt;&gt; +    dma_fence_put(&amp;chain-&gt;base);<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +static void dma_fence_chain_cb(struct
            dma_fence *f, struct<br>
            &gt;&gt;&gt; dma_fence_cb *cb)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +    struct dma_fence_chain *chain;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    chain = container_of(cb, typeof(*chain),
            cb);<br>
            &gt;&gt;&gt; +    irq_work_queue(&amp;chain-&gt;work);<br>
            &gt;&gt;&gt; +    dma_fence_put(f);<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +static bool
            dma_fence_chain_enable_signaling(struct dma_fence *fence)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +    struct dma_fence_chain *head =
            to_dma_fence_chain(fence);<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    dma_fence_get(&amp;head-&gt;base);<br>
            &gt;&gt;&gt; +    dma_fence_chain_for_each(fence,
            &amp;head-&gt;base) {<br>
            &gt;&gt;&gt; +        struct dma_fence_chain *chain =
            to_dma_fence_chain(fence);<br>
            &gt;&gt;&gt; +        struct dma_fence *f = chain ?
            chain-&gt;fence : fence;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +        dma_fence_get(f);<br>
            &gt;&gt;&gt; +        if (!dma_fence_add_callback(f,
            &amp;head-&gt;cb,<br>
            &gt;&gt;&gt; dma_fence_chain_cb)) {<br>
            &gt;&gt;&gt; +            dma_fence_put(fence);<br>
            &gt;&gt;&gt; +            return true;<br>
            &gt;&gt;&gt; +        }<br>
            &gt;&gt;&gt; +        dma_fence_put(f);<br>
            &gt;&gt;&gt; +    }<br>
            &gt;&gt;&gt; +    dma_fence_put(&amp;head-&gt;base);<br>
            &gt;&gt;&gt; +    return false;<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +static bool dma_fence_chain_signaled(struct
            dma_fence *fence)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +    dma_fence_chain_for_each(fence, fence) {<br>
            &gt;&gt;&gt; +        struct dma_fence_chain *chain =
            to_dma_fence_chain(fence);<br>
            &gt;&gt;&gt; +        struct dma_fence *f = chain ?
            chain-&gt;fence : fence;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +        if (!dma_fence_is_signaled(f)) {<br>
            &gt;&gt;&gt; +            dma_fence_put(fence);<br>
            &gt;&gt;&gt; +            return false;<br>
            &gt;&gt;&gt; +        }<br>
            &gt;&gt;&gt; +    }<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    return true;<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +static void dma_fence_chain_release(struct
            dma_fence *fence)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +    struct dma_fence_chain *chain =
            to_dma_fence_chain(fence);<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    dma_fence_put(chain-&gt;prev);<br>
            &gt;&gt;&gt; +    dma_fence_put(chain-&gt;fence);<br>
            &gt;&gt;&gt; +    dma_fence_free(fence);<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +const struct dma_fence_ops dma_fence_chain_ops
            = {<br>
            &gt;&gt;&gt; +    .get_driver_name =
            dma_fence_chain_get_driver_name,<br>
            &gt;&gt;&gt; +    .get_timeline_name =
            dma_fence_chain_get_timeline_name,<br>
            &gt;&gt;&gt; +    .enable_signaling =
            dma_fence_chain_enable_signaling,<br>
            &gt;&gt;&gt; +    .signaled = dma_fence_chain_signaled,<br>
            &gt;&gt;&gt; +    .release = dma_fence_chain_release,<br>
            &gt;&gt;&gt; +};<br>
            &gt;&gt;&gt; +EXPORT_SYMBOL(dma_fence_chain_ops);<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +/**<br>
            &gt;&gt;&gt; + * dma_fence_chain_init - initialize a fence
            chain<br>
            &gt;&gt;&gt; + * @chain: the chain node to initialize<br>
            &gt;&gt;&gt; + * @prev: the previous fence<br>
            &gt;&gt;&gt; + * @fence: the current fence<br>
            &gt;&gt;&gt; + *<br>
            &gt;&gt;&gt; + * Initialize a new chain node and either
            start a new chain or add<br>
            &gt;&gt;&gt; the node to<br>
            &gt;&gt;&gt; + * the existing chain of the previous fence.<br>
            &gt;&gt;&gt; + */<br>
            &gt;&gt;&gt; +void dma_fence_chain_init(struct
            dma_fence_chain *chain,<br>
            &gt;&gt;&gt; +              struct dma_fence *prev,<br>
            &gt;&gt;&gt; +              struct dma_fence *fence,<br>
            &gt;&gt;&gt; +              uint64_t seqno)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +    struct dma_fence_chain *prev_chain =
            to_dma_fence_chain(prev);<br>
            &gt;&gt;&gt; +    uint64_t context;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    spin_lock_init(&amp;chain-&gt;lock);<br>
            &gt;&gt;&gt; +    chain-&gt;prev = prev;<br>
            &gt;&gt;&gt; +    chain-&gt;fence = fence;<br>
            &gt;&gt;&gt; +    chain-&gt;prev_seqno = 0;<br>
            &gt;&gt;&gt; +    init_irq_work(&amp;chain-&gt;work,
            dma_fence_chain_irq_work);<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    /* Try to reuse the context of the
            previous chain node. */<br>
            &gt;&gt;&gt; +    if (prev_chain &amp;&amp;
            __dma_fence_is_later(seqno, prev-&gt;seqno)) {<br>
            &gt;&gt;&gt; +        context = prev-&gt;context;<br>
            &gt;&gt;&gt; +        chain-&gt;prev_seqno = prev-&gt;seqno;<br>
            &gt;&gt;&gt; +    } else {<br>
            &gt;&gt;&gt; +        context = dma_fence_context_alloc(1);<br>
            &gt;&gt;&gt; +        /* Make sure that we always have a
            valid sequence number. */<br>
            &gt;&gt;&gt; +        if (prev_chain)<br>
            &gt;&gt;&gt; +            seqno = max(prev-&gt;seqno,
            seqno);<br>
            &gt;&gt;&gt; +    }<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    dma_fence_init(&amp;chain-&gt;base,
            &amp;dma_fence_chain_ops,<br>
            &gt;&gt;&gt; +               &amp;chain-&gt;lock, context,
            seqno);<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +EXPORT_SYMBOL(dma_fence_chain_init);<br>
            &gt;&gt;&gt; diff --git a/include/linux/dma-fence-chain.h<br>
            &gt;&gt;&gt; b/include/linux/dma-fence-chain.h<br>
            &gt;&gt;&gt; new file mode 100644<br>
            &gt;&gt;&gt; index 000000000000..a5c2e8c6915c<br>
            &gt;&gt;&gt; --- /dev/null<br>
            &gt;&gt;&gt; +++ b/include/linux/dma-fence-chain.h<br>
            &gt;&gt;&gt; @@ -0,0 +1,81 @@<br>
            &gt;&gt;&gt; +/*<br>
            &gt;&gt;&gt; + * fence-chain: chain fences together in a
            timeline<br>
            &gt;&gt;&gt; + *<br>
            &gt;&gt;&gt; + * Copyright (C) 2018 Advanced Micro Devices,
            Inc.<br>
            &gt;&gt;&gt; + * Authors:<br>
            &gt;&gt;&gt; + *    Christian König &lt;<a
              href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target="_blank"
              moz-do-not-send="true">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
            &gt;&gt;&gt; + *<br>
            &gt;&gt;&gt; + * This program is free software; you can
            redistribute it and/or<br>
            &gt;&gt;&gt; modify it<br>
            &gt;&gt;&gt; + * under the terms of the GNU General Public
            License version 2 as<br>
            &gt;&gt;&gt; published by<br>
            &gt;&gt;&gt; + * the Free Software Foundation.<br>
            &gt;&gt;&gt; + *<br>
            &gt;&gt;&gt; + * This program is distributed in the hope
            that it will be useful,<br>
            &gt;&gt;&gt; but WITHOUT<br>
            &gt;&gt;&gt; + * ANY WARRANTY; without even the implied
            warranty of<br>
            &gt;&gt;&gt; MERCHANTABILITY or<br>
            &gt;&gt;&gt; + * FITNESS FOR A PARTICULAR PURPOSE.  See the
            GNU General Public<br>
            &gt;&gt;&gt; License for<br>
            &gt;&gt;&gt; + * more details.<br>
            &gt;&gt;&gt; + */<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +#ifndef __LINUX_DMA_FENCE_CHAIN_H<br>
            &gt;&gt;&gt; +#define __LINUX_DMA_FENCE_CHAIN_H<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +#include &lt;linux/dma-fence.h&gt;<br>
            &gt;&gt;&gt; +#include &lt;linux/irq_work.h&gt;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +/**<br>
            &gt;&gt;&gt; + * struct dma_fence_chain - fence to represent
            an node of a fence chain<br>
            &gt;&gt;&gt; + * @base: fence base class<br>
            &gt;&gt;&gt; + * @lock: spinlock for fence handling<br>
            &gt;&gt;&gt; + * @prev: previous fence of the chain<br>
            &gt;&gt;&gt; + * @prev_seqno: original previous seqno before
            garbage collection<br>
            &gt;&gt;&gt; + * @fence: encapsulated fence<br>
            &gt;&gt;&gt; + * @cb: callback structure for signaling<br>
            &gt;&gt;&gt; + * @work: irq work item for signaling<br>
            &gt;&gt;&gt; + */<br>
            &gt;&gt;&gt; +struct dma_fence_chain {<br>
            &gt;&gt;&gt; +    struct dma_fence base;<br>
            &gt;&gt;&gt; +    spinlock_t lock;<br>
            &gt;&gt;&gt; +    struct dma_fence *prev;<br>
            &gt;&gt;&gt; +    u64 prev_seqno;<br>
            &gt;&gt;&gt; +    struct dma_fence *fence;<br>
            &gt;&gt;&gt; +    struct dma_fence_cb cb;<br>
            &gt;&gt;&gt; +    struct irq_work work;<br>
            &gt;&gt;&gt; +};<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +extern const struct dma_fence_ops
            dma_fence_chain_ops;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +/**<br>
            &gt;&gt;&gt; + * to_dma_fence_chain - cast a fence to a
            dma_fence_chain<br>
            &gt;&gt;&gt; + * @fence: fence to cast to a dma_fence_array<br>
            &gt;&gt;&gt; + *<br>
            &gt;&gt;&gt; + * Returns NULL if the fence is not a
            dma_fence_chain,<br>
            &gt;&gt;&gt; + * or the dma_fence_chain otherwise.<br>
            &gt;&gt;&gt; + */<br>
            &gt;&gt;&gt; +static inline struct dma_fence_chain *<br>
            &gt;&gt;&gt; +to_dma_fence_chain(struct dma_fence *fence)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +    if (!fence || fence-&gt;ops !=
            &amp;dma_fence_chain_ops)<br>
            &gt;&gt;&gt; +        return NULL;<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +    return container_of(fence, struct
            dma_fence_chain, base);<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +/**<br>
            &gt;&gt;&gt; + * dma_fence_chain_for_each - iterate over all
            fences in chain<br>
            &gt;&gt;&gt; + * @iter: current fence<br>
            &gt;&gt;&gt; + * @head: starting point<br>
            &gt;&gt;&gt; + *<br>
            &gt;&gt;&gt; + * Iterate over all fences in the chain. We
            keep a reference to the<br>
            &gt;&gt;&gt; current<br>
            &gt;&gt;&gt; + * fence while inside the loop which must be
            dropped when breaking out.<br>
            &gt;&gt;&gt; + */<br>
            &gt;&gt;&gt; +#define dma_fence_chain_for_each(iter,
            head)    \<br>
            &gt;&gt;&gt; +    for (iter = dma_fence_get(head); iter; \<br>
            &gt;&gt;&gt; +         iter = dma_fence_chain_walk(head))<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +struct dma_fence *dma_fence_chain_walk(struct
            dma_fence *fence);<br>
            &gt;&gt;&gt; +int dma_fence_chain_find_seqno(struct
            dma_fence **pfence, uint64_t<br>
            &gt;&gt;&gt; seqno);<br>
            &gt;&gt;&gt; +void dma_fence_chain_init(struct
            dma_fence_chain *chain,<br>
            &gt;&gt;&gt; +              struct dma_fence *prev,<br>
            &gt;&gt;&gt; +              struct dma_fence *fence,<br>
            &gt;&gt;&gt; +              uint64_t seqno);<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt;&gt; +#endif /* __LINUX_DMA_FENCE_CHAIN_H */<br>
            &gt;&gt;<br>
            <br>
            _______________________________________________<br>
            dri-devel mailing list<br>
            <a href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
              target="_blank" moz-do-not-send="true">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <a
              href="https://lists.freedesktop.org/mailman/listinfo/dri-devel"
              rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a></blockquote>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------AA379EB71190AF8B37FF2AFF--

--===============1979289415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1979289415==--
