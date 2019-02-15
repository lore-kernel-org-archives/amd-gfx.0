From: Jason Ekstrand <jason@jlekstrand.net>
Subject: Re: [PATCH 02/11] dma-buf: add new dma_fence_chain container v4
Date: Fri, 15 Feb 2019 10:49:32 -0600
Message-ID: <CAOFGe96HUkzHPJKYT-07X3vMvCRD-=Hba1=Ke24qt_PY2vn0YQ@mail.gmail.com>
References: <20181207095601.2058-1-david1.zhou@amd.com>
 <20181207095601.2058-2-david1.zhou@amd.com>
 <6c2adaf5-6871-20be-a26d-182f8ca8ab8a@intel.com>
 <e170ceed-fdb7-8b4a-93d7-e565641390b3@amd.com>
 <bbae2023-8dee-692e-9549-40779a202587@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0666902528=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <bbae2023-8dee-692e-9549-40779a202587@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0666902528==
Content-Type: multipart/alternative; boundary="000000000000eaee730581f18fdd"

--000000000000eaee730581f18fdd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 9:52 AM Lionel Landwerlin via dri-devel <
dri-devel@lists.freedesktop.org> wrote:

> On 15/02/2019 14:32, Koenig, Christian wrote:
> > Am 15.02.19 um 15:23 schrieb Lionel Landwerlin:
> >> Hi Christian, David,
> >>
> >> For timeline semaphore we need points to signaled in order.
> >> I'm struggling to understand how this fence-chain implementation
> >> preserves ordering of the seqnos.
> >>
> >> One of the scenario I can see an issue happening is when you have a
> >> timeline with points 1 & 2 and userspace submits for 2 different
> >> engines :
> >>      - first with let's say a blitter style engine on point 2
> >>      - then a 3d style engine on point 1
> > Yeah, and where exactly is the problem?
> >
> > Seqno 1 will signal when the 3d style engine finishes work.
> >
> > And seqno 2 will signal when both seqno 1 is signaled and the blitter
> > style engine has finished its work.
>

That's an interesting interpretation of the spec.  I think it's legal and I
could see that behavior may be desirable in some ways.


> That's not really how I understood the spec, but I might be wrong.
>
> What makes me thing 1 should be signaled as soon as 2 is signaled
> (regardless of whether the fence attached on point 1 is been signaled),
> is that the spec defines wait & signal operations in term of the value
> of the timeline.
>
>
> -Lionel
>
> >
> >> Another scenario would be signaling a timeline with points 1 & 2 with
> >> those points in reverse order in the submission array.
> > That is actually illegal in the spec, but actually handled gracefully a=
s
> > well.
> >
> > E.g. when you add seqno 1 to the syncobj container it will only signal
> > when 2 is signaled as well.
>

I think what Christian is suggesting is a valid interpretation of the spec
though it is rather unconventional.  The Vulkan spec, as it stands today,
requires that the application ensure that at the time of signaling, the
timeline semaphore value increases.  This means that all of the above
possible cases are technically illegal in Vulkan and so it doesn't really
matter what we do as long as we don't do anyting especially stupid.

My understanding of how this works on Windows is that a wait operation on 3
is a wait until x >=3D 3 where x is a 64-bit value and a signal operation i=
s
simply a write to x.  This means that, in the above cases, waits on 1 will
be triggered immediately when 2 is written but waits on 2 may or may not
happen at all depending on whether the GPU write which overwrites x to 1 or
the CPU (or potentially GPU in a different context) read gets there first
such that the reader observes 2.  If you mess this up and something isn't
signaled, that's your fault.

Instead of specifying things to be exactly the Windows behavior, Vulkan
says that you must only ever increase the value and anything else is
illegal and therefore leads to undefined behavior.  The usual consequences
of undefined behavior apply: anything can happen up to and including
process termination.  In other words, how we handle those cases is
completely up to us as long as we do something sane that doesn't result in
kernel crashes or anything like that.  We do have to handle it in some way
because we can't outright prevent those cases from happening.  The question
then becomes what's the best way for the behavior to degrade.

In my opinion, the smoothest degredation is if you take the windows model
and replace the 64-bit write to x with a 64-bit atomic MAX operation.  In
other words, signaling 2 automatically unblocks 1 and any attempt to signal
a value lower than the current value is a no-op.  It has a few nice
advantages:

 1. Signaling N is guaranteed to unblock everything waiting on n <=3D N
regardless of what else may be pending.
 2. It matches what I think is the next natural evolution of the Windows
model where the write is replaced with an atomic.
 3. It gracefully handles the case where the operation to signal 1 is added
after the one to signal 2.  We can also make this case illegal but this
model extends to one in which it could be legal and well-defined.
 4. If you do get into a sticky situation, you can unblock an entire
timeline by using the CPU signal ioctl to set it to a high value.

Of all these reasons, I think 1 and 2 carry the most weight.  2, in
particular, is interesting if we one day want to implement the same
behavior with a simple 64-bit value like Windows does.  Immagine, for
instance, a scenario where the GPU is doing it's own scheduling or command
buffers are submitted ahead of the signal operation being available and
told to just sit on the GPU until they see x >=3D 3.  (Yes, there are issue=
s
here with residency, contention, etc.  I'm asking you to use your
immagination.)  Assuming you can do 64-bit atomics (there are aparently
issues here with PCIe that make things sticky), the behavior I'm suggesting
is completely implementable in that way whereas the behavior Christian is
suggesting is only implementable if you're maintaining a CPU-side list of
fences.  I don't think we want to paint ourselves into that corner.

--Jason


> >
> > Regards,
> > Christian.
> >
> >> -Lionel
> >>
> >> On 07/12/2018 09:55, Chunming Zhou wrote:
> >>> From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> >>>
> >>> Lockless container implementation similar to a dma_fence_array, but
> with
> >>> only two elements per node and automatic garbage collection.
> >>>
> >>> v2: properly document dma_fence_chain_for_each, add
> >>> dma_fence_chain_find_seqno,
> >>>       drop prev reference during garbage collection if it's not a
> >>> chain fence.
> >>> v3: use head and iterator for dma_fence_chain_for_each
> >>> v4: fix reference count in dma_fence_chain_enable_signaling
> >>>
> >>> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>> ---
> >>>    drivers/dma-buf/Makefile          |   3 +-
> >>>    drivers/dma-buf/dma-fence-chain.c | 241
> ++++++++++++++++++++++++++++++
> >>>    include/linux/dma-fence-chain.h   |  81 ++++++++++
> >>>    3 files changed, 324 insertions(+), 1 deletion(-)
> >>>    create mode 100644 drivers/dma-buf/dma-fence-chain.c
> >>>    create mode 100644 include/linux/dma-fence-chain.h
> >>>
> >>> diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
> >>> index 0913a6ccab5a..1f006e083eb9 100644
> >>> --- a/drivers/dma-buf/Makefile
> >>> +++ b/drivers/dma-buf/Makefile
> >>> @@ -1,4 +1,5 @@
> >>> -obj-y :=3D dma-buf.o dma-fence.o dma-fence-array.o reservation.o
> >>> seqno-fence.o
> >>> +obj-y :=3D dma-buf.o dma-fence.o dma-fence-array.o dma-fence-chain.o=
 \
> >>> +     reservation.o seqno-fence.o
> >>>    obj-$(CONFIG_SYNC_FILE)        +=3D sync_file.o
> >>>    obj-$(CONFIG_SW_SYNC)        +=3D sw_sync.o sync_debug.o
> >>>    obj-$(CONFIG_UDMABUF)        +=3D udmabuf.o
> >>> diff --git a/drivers/dma-buf/dma-fence-chain.c
> >>> b/drivers/dma-buf/dma-fence-chain.c
> >>> new file mode 100644
> >>> index 000000000000..0c5e3c902fa0
> >>> --- /dev/null
> >>> +++ b/drivers/dma-buf/dma-fence-chain.c
> >>> @@ -0,0 +1,241 @@
> >>> +/*
> >>> + * fence-chain: chain fences together in a timeline
> >>> + *
> >>> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
> >>> + * Authors:
> >>> + *    Christian K=C3=B6nig <christian.koenig@amd.com>
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or
> >>> modify it
> >>> + * under the terms of the GNU General Public License version 2 as
> >>> published by
> >>> + * the Free Software Foundation.
> >>> + *
> >>> + * This program is distributed in the hope that it will be useful,
> >>> but WITHOUT
> >>> + * ANY WARRANTY; without even the implied warranty of
> >>> MERCHANTABILITY or
> >>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> >>> License for
> >>> + * more details.
> >>> + */
> >>> +
> >>> +#include <linux/dma-fence-chain.h>
> >>> +
> >>> +static bool dma_fence_chain_enable_signaling(struct dma_fence *fence=
);
> >>> +
> >>> +/**
> >>> + * dma_fence_chain_get_prev - use RCU to get a reference to the
> >>> previous fence
> >>> + * @chain: chain node to get the previous node from
> >>> + *
> >>> + * Use dma_fence_get_rcu_safe to get a reference to the previous
> >>> fence of the
> >>> + * chain node.
> >>> + */
> >>> +static struct dma_fence *dma_fence_chain_get_prev(struct
> >>> dma_fence_chain *chain)
> >>> +{
> >>> +    struct dma_fence *prev;
> >>> +
> >>> +    rcu_read_lock();
> >>> +    prev =3D dma_fence_get_rcu_safe(&chain->prev);
> >>> +    rcu_read_unlock();
> >>> +    return prev;
> >>> +}
> >>> +
> >>> +/**
> >>> + * dma_fence_chain_walk - chain walking function
> >>> + * @fence: current chain node
> >>> + *
> >>> + * Walk the chain to the next node. Returns the next fence or NULL
> >>> if we are at
> >>> + * the end of the chain. Garbage collects chain nodes which are
> already
> >>> + * signaled.
> >>> + */
> >>> +struct dma_fence *dma_fence_chain_walk(struct dma_fence *fence)
> >>> +{
> >>> +    struct dma_fence_chain *chain, *prev_chain;
> >>> +    struct dma_fence *prev, *replacement, *tmp;
> >>> +
> >>> +    chain =3D to_dma_fence_chain(fence);
> >>> +    if (!chain) {
> >>> +        dma_fence_put(fence);
> >>> +        return NULL;
> >>> +    }
> >>> +
> >>> +    while ((prev =3D dma_fence_chain_get_prev(chain))) {
> >>> +
> >>> +        prev_chain =3D to_dma_fence_chain(prev);
> >>> +        if (prev_chain) {
> >>> +            if (!dma_fence_is_signaled(prev_chain->fence))
> >>> +                break;
> >>> +
> >>> +            replacement =3D dma_fence_chain_get_prev(prev_chain);
> >>> +        } else {
> >>> +            if (!dma_fence_is_signaled(prev))
> >>> +                break;
> >>> +
> >>> +            replacement =3D NULL;
> >>> +        }
> >>> +
> >>> +        tmp =3D cmpxchg(&chain->prev, prev, replacement);
> >>> +        if (tmp =3D=3D prev)
> >>> +            dma_fence_put(tmp);
> >>> +        else
> >>> +            dma_fence_put(replacement);
> >>> +        dma_fence_put(prev);
> >>> +    }
> >>> +
> >>> +    dma_fence_put(fence);
> >>> +    return prev;
> >>> +}
> >>> +EXPORT_SYMBOL(dma_fence_chain_walk);
> >>> +
> >>> +/**
> >>> + * dma_fence_chain_find_seqno - find fence chain node by seqno
> >>> + * @pfence: pointer to the chain node where to start
> >>> + * @seqno: the sequence number to search for
> >>> + *
> >>> + * Advance the fence pointer to the chain node which will signal
> >>> this sequence
> >>> + * number. If no sequence number is provided then this is a no-op.
> >>> + *
> >>> + * Returns EINVAL if the fence is not a chain node or the sequence
> >>> number has
> >>> + * not yet advanced far enough.
> >>> + */
> >>> +int dma_fence_chain_find_seqno(struct dma_fence **pfence, uint64_t
> >>> seqno)
> >>> +{
> >>> +    struct dma_fence_chain *chain;
> >>> +
> >>> +    if (!seqno)
> >>> +        return 0;
> >>> +
> >>> +    chain =3D to_dma_fence_chain(*pfence);
> >>> +    if (!chain || chain->base.seqno < seqno)
> >>> +        return -EINVAL;
> >>> +
> >>> +    dma_fence_chain_for_each(*pfence, &chain->base) {
> >>> +        if ((*pfence)->context !=3D chain->base.context ||
> >>> +            to_dma_fence_chain(*pfence)->prev_seqno < seqno)
> >>> +            break;
> >>> +    }
> >>> +    dma_fence_put(&chain->base);
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +EXPORT_SYMBOL(dma_fence_chain_find_seqno);
> >>> +
> >>> +static const char *dma_fence_chain_get_driver_name(struct dma_fence
> >>> *fence)
> >>> +{
> >>> +        return "dma_fence_chain";
> >>> +}
> >>> +
> >>> +static const char *dma_fence_chain_get_timeline_name(struct
> >>> dma_fence *fence)
> >>> +{
> >>> +        return "unbound";
> >>> +}
> >>> +
> >>> +static void dma_fence_chain_irq_work(struct irq_work *work)
> >>> +{
> >>> +    struct dma_fence_chain *chain;
> >>> +
> >>> +    chain =3D container_of(work, typeof(*chain), work);
> >>> +
> >>> +    /* Try to rearm the callback */
> >>> +    if (!dma_fence_chain_enable_signaling(&chain->base))
> >>> +        /* Ok, we are done. No more unsignaled fences left */
> >>> +        dma_fence_signal(&chain->base);
> >>> +    dma_fence_put(&chain->base);
> >>> +}
> >>> +
> >>> +static void dma_fence_chain_cb(struct dma_fence *f, struct
> >>> dma_fence_cb *cb)
> >>> +{
> >>> +    struct dma_fence_chain *chain;
> >>> +
> >>> +    chain =3D container_of(cb, typeof(*chain), cb);
> >>> +    irq_work_queue(&chain->work);
> >>> +    dma_fence_put(f);
> >>> +}
> >>> +
> >>> +static bool dma_fence_chain_enable_signaling(struct dma_fence *fence=
)
> >>> +{
> >>> +    struct dma_fence_chain *head =3D to_dma_fence_chain(fence);
> >>> +
> >>> +    dma_fence_get(&head->base);
> >>> +    dma_fence_chain_for_each(fence, &head->base) {
> >>> +        struct dma_fence_chain *chain =3D to_dma_fence_chain(fence);
> >>> +        struct dma_fence *f =3D chain ? chain->fence : fence;
> >>> +
> >>> +        dma_fence_get(f);
> >>> +        if (!dma_fence_add_callback(f, &head->cb,
> >>> dma_fence_chain_cb)) {
> >>> +            dma_fence_put(fence);
> >>> +            return true;
> >>> +        }
> >>> +        dma_fence_put(f);
> >>> +    }
> >>> +    dma_fence_put(&head->base);
> >>> +    return false;
> >>> +}
> >>> +
> >>> +static bool dma_fence_chain_signaled(struct dma_fence *fence)
> >>> +{
> >>> +    dma_fence_chain_for_each(fence, fence) {
> >>> +        struct dma_fence_chain *chain =3D to_dma_fence_chain(fence);
> >>> +        struct dma_fence *f =3D chain ? chain->fence : fence;
> >>> +
> >>> +        if (!dma_fence_is_signaled(f)) {
> >>> +            dma_fence_put(fence);
> >>> +            return false;
> >>> +        }
> >>> +    }
> >>> +
> >>> +    return true;
> >>> +}
> >>> +
> >>> +static void dma_fence_chain_release(struct dma_fence *fence)
> >>> +{
> >>> +    struct dma_fence_chain *chain =3D to_dma_fence_chain(fence);
> >>> +
> >>> +    dma_fence_put(chain->prev);
> >>> +    dma_fence_put(chain->fence);
> >>> +    dma_fence_free(fence);
> >>> +}
> >>> +
> >>> +const struct dma_fence_ops dma_fence_chain_ops =3D {
> >>> +    .get_driver_name =3D dma_fence_chain_get_driver_name,
> >>> +    .get_timeline_name =3D dma_fence_chain_get_timeline_name,
> >>> +    .enable_signaling =3D dma_fence_chain_enable_signaling,
> >>> +    .signaled =3D dma_fence_chain_signaled,
> >>> +    .release =3D dma_fence_chain_release,
> >>> +};
> >>> +EXPORT_SYMBOL(dma_fence_chain_ops);
> >>> +
> >>> +/**
> >>> + * dma_fence_chain_init - initialize a fence chain
> >>> + * @chain: the chain node to initialize
> >>> + * @prev: the previous fence
> >>> + * @fence: the current fence
> >>> + *
> >>> + * Initialize a new chain node and either start a new chain or add
> >>> the node to
> >>> + * the existing chain of the previous fence.
> >>> + */
> >>> +void dma_fence_chain_init(struct dma_fence_chain *chain,
> >>> +              struct dma_fence *prev,
> >>> +              struct dma_fence *fence,
> >>> +              uint64_t seqno)
> >>> +{
> >>> +    struct dma_fence_chain *prev_chain =3D to_dma_fence_chain(prev);
> >>> +    uint64_t context;
> >>> +
> >>> +    spin_lock_init(&chain->lock);
> >>> +    chain->prev =3D prev;
> >>> +    chain->fence =3D fence;
> >>> +    chain->prev_seqno =3D 0;
> >>> +    init_irq_work(&chain->work, dma_fence_chain_irq_work);
> >>> +
> >>> +    /* Try to reuse the context of the previous chain node. */
> >>> +    if (prev_chain && __dma_fence_is_later(seqno, prev->seqno)) {
> >>> +        context =3D prev->context;
> >>> +        chain->prev_seqno =3D prev->seqno;
> >>> +    } else {
> >>> +        context =3D dma_fence_context_alloc(1);
> >>> +        /* Make sure that we always have a valid sequence number. */
> >>> +        if (prev_chain)
> >>> +            seqno =3D max(prev->seqno, seqno);
> >>> +    }
> >>> +
> >>> +    dma_fence_init(&chain->base, &dma_fence_chain_ops,
> >>> +               &chain->lock, context, seqno);
> >>> +}
> >>> +EXPORT_SYMBOL(dma_fence_chain_init);
> >>> diff --git a/include/linux/dma-fence-chain.h
> >>> b/include/linux/dma-fence-chain.h
> >>> new file mode 100644
> >>> index 000000000000..a5c2e8c6915c
> >>> --- /dev/null
> >>> +++ b/include/linux/dma-fence-chain.h
> >>> @@ -0,0 +1,81 @@
> >>> +/*
> >>> + * fence-chain: chain fences together in a timeline
> >>> + *
> >>> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
> >>> + * Authors:
> >>> + *    Christian K=C3=B6nig <christian.koenig@amd.com>
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or
> >>> modify it
> >>> + * under the terms of the GNU General Public License version 2 as
> >>> published by
> >>> + * the Free Software Foundation.
> >>> + *
> >>> + * This program is distributed in the hope that it will be useful,
> >>> but WITHOUT
> >>> + * ANY WARRANTY; without even the implied warranty of
> >>> MERCHANTABILITY or
> >>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> >>> License for
> >>> + * more details.
> >>> + */
> >>> +
> >>> +#ifndef __LINUX_DMA_FENCE_CHAIN_H
> >>> +#define __LINUX_DMA_FENCE_CHAIN_H
> >>> +
> >>> +#include <linux/dma-fence.h>
> >>> +#include <linux/irq_work.h>
> >>> +
> >>> +/**
> >>> + * struct dma_fence_chain - fence to represent an node of a fence
> chain
> >>> + * @base: fence base class
> >>> + * @lock: spinlock for fence handling
> >>> + * @prev: previous fence of the chain
> >>> + * @prev_seqno: original previous seqno before garbage collection
> >>> + * @fence: encapsulated fence
> >>> + * @cb: callback structure for signaling
> >>> + * @work: irq work item for signaling
> >>> + */
> >>> +struct dma_fence_chain {
> >>> +    struct dma_fence base;
> >>> +    spinlock_t lock;
> >>> +    struct dma_fence *prev;
> >>> +    u64 prev_seqno;
> >>> +    struct dma_fence *fence;
> >>> +    struct dma_fence_cb cb;
> >>> +    struct irq_work work;
> >>> +};
> >>> +
> >>> +extern const struct dma_fence_ops dma_fence_chain_ops;
> >>> +
> >>> +/**
> >>> + * to_dma_fence_chain - cast a fence to a dma_fence_chain
> >>> + * @fence: fence to cast to a dma_fence_array
> >>> + *
> >>> + * Returns NULL if the fence is not a dma_fence_chain,
> >>> + * or the dma_fence_chain otherwise.
> >>> + */
> >>> +static inline struct dma_fence_chain *
> >>> +to_dma_fence_chain(struct dma_fence *fence)
> >>> +{
> >>> +    if (!fence || fence->ops !=3D &dma_fence_chain_ops)
> >>> +        return NULL;
> >>> +
> >>> +    return container_of(fence, struct dma_fence_chain, base);
> >>> +}
> >>> +
> >>> +/**
> >>> + * dma_fence_chain_for_each - iterate over all fences in chain
> >>> + * @iter: current fence
> >>> + * @head: starting point
> >>> + *
> >>> + * Iterate over all fences in the chain. We keep a reference to the
> >>> current
> >>> + * fence while inside the loop which must be dropped when breaking
> out.
> >>> + */
> >>> +#define dma_fence_chain_for_each(iter, head)    \
> >>> +    for (iter =3D dma_fence_get(head); iter; \
> >>> +         iter =3D dma_fence_chain_walk(head))
> >>> +
> >>> +struct dma_fence *dma_fence_chain_walk(struct dma_fence *fence);
> >>> +int dma_fence_chain_find_seqno(struct dma_fence **pfence, uint64_t
> >>> seqno);
> >>> +void dma_fence_chain_init(struct dma_fence_chain *chain,
> >>> +              struct dma_fence *prev,
> >>> +              struct dma_fence *fence,
> >>> +              uint64_t seqno);
> >>> +
> >>> +#endif /* __LINUX_DMA_FENCE_CHAIN_H */
> >>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--000000000000eaee730581f18fdd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, Feb 15, 2019 at 9:52 AM Lionel Landwerlin via dri-devel &lt;=
<a href=3D"mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesk=
top.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On 15/02/2019 14:32, Koenig, Christian wrote:<br>
&gt; Am 15.02.19 um 15:23 schrieb Lionel Landwerlin:<br>
&gt;&gt; Hi Christian, David,<br>
&gt;&gt;<br>
&gt;&gt; For timeline semaphore we need points to signaled in order.<br>
&gt;&gt; I&#39;m struggling to understand how this fence-chain implementati=
on<br>
&gt;&gt; preserves ordering of the seqnos.<br>
&gt;&gt;<br>
&gt;&gt; One of the scenario I can see an issue happening is when you have =
a<br>
&gt;&gt; timeline with points 1 &amp; 2 and userspace submits for 2 differe=
nt<br>
&gt;&gt; engines :<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 - first with let&#39;s say a blitter styl=
e engine on point 2<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 - then a 3d style engine on point 1<br>
&gt; Yeah, and where exactly is the problem?<br>
&gt;<br>
&gt; Seqno 1 will signal when the 3d style engine finishes work.<br>
&gt;<br>
&gt; And seqno 2 will signal when both seqno 1 is signaled and the blitter<=
br>
&gt; style engine has finished its work.<br></blockquote><div><br></div><di=
v>That&#39;s an interesting interpretation of the spec.=C2=A0 I think it&#3=
9;s legal and I could see that behavior may be desirable in some ways.<br><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
That&#39;s not really how I understood the spec, but I might be wrong.<br>
<br>
What makes me thing 1 should be signaled as soon as 2 is signaled<br>
(regardless of whether the fence attached on point 1 is been signaled),<br>
is that the spec defines wait &amp; signal operations in term of the value<=
br>
of the timeline.<br>
<br>
<br>
-Lionel<br>
<br>
&gt;<br>
&gt;&gt; Another scenario would be signaling a timeline with points 1 &amp;=
 2 with<br>
&gt;&gt; those points in reverse order in the submission array.<br>
&gt; That is actually illegal in the spec, but actually handled gracefully =
as<br>
&gt; well.<br>
&gt;<br>
&gt; E.g. when you add seqno 1 to the syncobj container it will only signal=
<br>
&gt; when 2 is signaled as well.<br></blockquote><div><br></div><div>I thin=
k what Christian is suggesting is a valid interpretation of the spec though=
 it is rather unconventional.=C2=A0 The Vulkan spec, as it stands today, re=
quires that the application ensure that at the time of signaling, the timel=
ine semaphore value increases.=C2=A0 This means that all of the above possi=
ble cases are technically illegal in Vulkan and so it doesn&#39;t really ma=
tter what we do as long as we don&#39;t do anyting especially stupid.</div>=
<div><br></div><div>My understanding of how this works on Windows is that a=
 wait operation on 3 is a wait until x &gt;=3D 3 where x is a 64-bit value =
and a signal operation is simply a write to x.=C2=A0 This means that, in th=
e above cases, waits on 1 will be triggered immediately when 2 is written b=
ut waits on 2 may or may not happen at all depending on whether the GPU wri=
te which overwrites x to 1 or the CPU (or potentially GPU in a different co=
ntext) read gets there first such that the reader observes 2.=C2=A0 If you =
mess this up and something isn&#39;t signaled, that&#39;s your fault.</div>=
<div><br></div><div>Instead of specifying things to be exactly the Windows =
behavior, Vulkan says that you must only ever increase the value and anythi=
ng else is illegal and therefore leads to undefined behavior.=C2=A0 The usu=
al consequences of undefined behavior apply: anything can happen up to and =
including process termination.=C2=A0 In other words, how we handle those ca=
ses is completely up to us as long as we do something sane that doesn&#39;t=
 result in kernel crashes or anything like that.=C2=A0 We do have to handle=
 it in some way because we can&#39;t outright prevent those cases from happ=
ening.=C2=A0 The question then becomes what&#39;s the best way for the beha=
vior to degrade.<br></div><div><br></div><div>In my opinion, the smoothest =
degredation is if you take the windows model and replace the 64-bit write t=
o x with a 64-bit atomic MAX operation.=C2=A0 In other words, signaling 2 a=
utomatically unblocks 1 and any attempt to signal a value lower than the cu=
rrent value is a no-op.=C2=A0 It has a few nice advantages:</div><div><br><=
/div><div>=C2=A01. Signaling N is guaranteed to unblock everything waiting =
on n &lt;=3D N regardless of what else may be pending.<br></div><div>=C2=A0=
2. It matches what I think is the next natural evolution of the Windows mod=
el where the write is replaced with an atomic.</div><div>=C2=A03. It gracef=
ully handles the case where the operation to signal 1 is added after the on=
e to signal 2.=C2=A0 We can also make this case illegal but this model exte=
nds to one in which it could be legal and well-defined.<br></div><div>=C2=
=A04. If you do get into a sticky situation, you can unblock an entire time=
line by using the CPU signal ioctl to set it to a high value. <br></div><di=
v><br></div><div>Of all these reasons, I think 1 and 2 carry the most weigh=
t.=C2=A0 2, in particular, is interesting if we one day want to implement t=
he same behavior with a simple 64-bit value like Windows does.=C2=A0 Immagi=
ne, for instance, a scenario where the GPU is doing it&#39;s own scheduling=
 or command buffers are submitted ahead of the signal operation being avail=
able and told to just sit on the GPU until they see x &gt;=3D 3.=C2=A0 (Yes=
, there are issues here with residency, contention, etc.=C2=A0 I&#39;m aski=
ng you to use your immagination.)=C2=A0 Assuming you can do 64-bit atomics =
(there are aparently issues here with PCIe that make things sticky), the be=
havior I&#39;m suggesting is completely implementable in that way whereas t=
he behavior Christian is suggesting is only implementable if you&#39;re mai=
ntaining a CPU-side list of fences.=C2=A0 I don&#39;t think we want to pain=
t ourselves into that corner.</div><div><br></div><div>--Jason<br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; Regards,<br>
&gt; Christian.<br>
&gt;<br>
&gt;&gt; -Lionel<br>
&gt;&gt;<br>
&gt;&gt; On 07/12/2018 09:55, Chunming Zhou wrote:<br>
&gt;&gt;&gt; From: Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leich=
tzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>=
&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Lockless container implementation similar to a dma_fence_array=
, but with<br>
&gt;&gt;&gt; only two elements per node and automatic garbage collection.<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v2: properly document dma_fence_chain_for_each, add<br>
&gt;&gt;&gt; dma_fence_chain_find_seqno,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 drop prev reference during garb=
age collection if it&#39;s not a<br>
&gt;&gt;&gt; chain fence.<br>
&gt;&gt;&gt; v3: use head and iterator for dma_fence_chain_for_each<br>
&gt;&gt;&gt; v4: fix reference count in dma_fence_chain_enable_signaling<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:chri=
stian.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br=
>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 drivers/dma-buf/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 drivers/dma-buf/dma-fence-chain.c | 241 +++++++++=
+++++++++++++++++++++<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 include/linux/dma-fence-chain.h=C2=A0=C2=A0 |=C2=
=A0 81 ++++++++++<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 3 files changed, 324 insertions(+), 1 deletion(-)=
<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 create mode 100644 drivers/dma-buf/dma-fence-chai=
n.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 create mode 100644 include/linux/dma-fence-chain.=
h<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefi=
le<br>
&gt;&gt;&gt; index 0913a6ccab5a..1f006e083eb9 100644<br>
&gt;&gt;&gt; --- a/drivers/dma-buf/Makefile<br>
&gt;&gt;&gt; +++ b/drivers/dma-buf/Makefile<br>
&gt;&gt;&gt; @@ -1,4 +1,5 @@<br>
&gt;&gt;&gt; -obj-y :=3D dma-buf.o dma-fence.o dma-fence-array.o reservatio=
n.o<br>
&gt;&gt;&gt; seqno-fence.o<br>
&gt;&gt;&gt; +obj-y :=3D dma-buf.o dma-fence.o dma-fence-array.o dma-fence-=
chain.o \<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 reservation.o seqno-fence.o<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 obj-$(CONFIG_SYNC_FILE)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +=3D sync_file.o<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 obj-$(CONFIG_SW_SYNC)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 +=3D sw_sync.o sync_debug.o<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 obj-$(CONFIG_UDMABUF)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 +=3D udmabuf.o<br>
&gt;&gt;&gt; diff --git a/drivers/dma-buf/dma-fence-chain.c<br>
&gt;&gt;&gt; b/drivers/dma-buf/dma-fence-chain.c<br>
&gt;&gt;&gt; new file mode 100644<br>
&gt;&gt;&gt; index 000000000000..0c5e3c902fa0<br>
&gt;&gt;&gt; --- /dev/null<br>
&gt;&gt;&gt; +++ b/drivers/dma-buf/dma-fence-chain.c<br>
&gt;&gt;&gt; @@ -0,0 +1,241 @@<br>
&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt; + * fence-chain: chain fences together in a timeline<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * Copyright (C) 2018 Advanced Micro Devices, Inc.<br>
&gt;&gt;&gt; + * Authors:<br>
&gt;&gt;&gt; + *=C2=A0=C2=A0=C2=A0 Christian K=C3=B6nig &lt;<a href=3D"mail=
to:christian.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>=
&gt;<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * This program is free software; you can redistribute it and=
/or<br>
&gt;&gt;&gt; modify it<br>
&gt;&gt;&gt; + * under the terms of the GNU General Public License version =
2 as<br>
&gt;&gt;&gt; published by<br>
&gt;&gt;&gt; + * the Free Software Foundation.<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * This program is distributed in the hope that it will be us=
eful,<br>
&gt;&gt;&gt; but WITHOUT<br>
&gt;&gt;&gt; + * ANY WARRANTY; without even the implied warranty of<br>
&gt;&gt;&gt; MERCHANTABILITY or<br>
&gt;&gt;&gt; + * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU Genera=
l Public<br>
&gt;&gt;&gt; License for<br>
&gt;&gt;&gt; + * more details.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#include &lt;linux/dma-fence-chain.h&gt;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static bool dma_fence_chain_enable_signaling(struct dma_fence=
 *fence);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +/**<br>
&gt;&gt;&gt; + * dma_fence_chain_get_prev - use RCU to get a reference to t=
he<br>
&gt;&gt;&gt; previous fence<br>
&gt;&gt;&gt; + * @chain: chain node to get the previous node from<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * Use dma_fence_get_rcu_safe to get a reference to the previ=
ous<br>
&gt;&gt;&gt; fence of the<br>
&gt;&gt;&gt; + * chain node.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +static struct dma_fence *dma_fence_chain_get_prev(struct<br>
&gt;&gt;&gt; dma_fence_chain *chain)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct dma_fence *prev;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 rcu_read_lock();<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 prev =3D dma_fence_get_rcu_safe(&amp;chain=
-&gt;prev);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 rcu_read_unlock();<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return prev;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +/**<br>
&gt;&gt;&gt; + * dma_fence_chain_walk - chain walking function<br>
&gt;&gt;&gt; + * @fence: current chain node<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * Walk the chain to the next node. Returns the next fence or=
 NULL<br>
&gt;&gt;&gt; if we are at<br>
&gt;&gt;&gt; + * the end of the chain. Garbage collects chain nodes which a=
re already<br>
&gt;&gt;&gt; + * signaled.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +struct dma_fence *dma_fence_chain_walk(struct dma_fence *fenc=
e)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct dma_fence_chain *chain, *prev_chain=
;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct dma_fence *prev, *replacement, *tmp=
;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 chain =3D to_dma_fence_chain(fence);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (!chain) {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_put(fenc=
e);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 while ((prev =3D dma_fence_chain_get_prev(=
chain))) {<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prev_chain =3D to_=
dma_fence_chain(prev);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (prev_chain) {<=
br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!dma_fence_is_signaled(prev_chain-&gt;fence))<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 replacement =3D dma_fence_chain_get_prev(prev_chain);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!dma_fence_is_signaled(prev))<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 replacement =3D NULL;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D cmpxchg(&a=
mp;chain-&gt;prev, prev, replacement);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tmp =3D=3D pre=
v)<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dma_fence_put(tmp);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dma_fence_put(replacement);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_put(prev=
);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_fence_put(fence);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return prev;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +EXPORT_SYMBOL(dma_fence_chain_walk);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +/**<br>
&gt;&gt;&gt; + * dma_fence_chain_find_seqno - find fence chain node by seqn=
o<br>
&gt;&gt;&gt; + * @pfence: pointer to the chain node where to start<br>
&gt;&gt;&gt; + * @seqno: the sequence number to search for<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * Advance the fence pointer to the chain node which will sig=
nal<br>
&gt;&gt;&gt; this sequence<br>
&gt;&gt;&gt; + * number. If no sequence number is provided then this is a n=
o-op.<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * Returns EINVAL if the fence is not a chain node or the seq=
uence<br>
&gt;&gt;&gt; number has<br>
&gt;&gt;&gt; + * not yet advanced far enough.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +int dma_fence_chain_find_seqno(struct dma_fence **pfence, uin=
t64_t<br>
&gt;&gt;&gt; seqno)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct dma_fence_chain *chain;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (!seqno)<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 chain =3D to_dma_fence_chain(*pfence);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (!chain || chain-&gt;base.seqno &lt; se=
qno)<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;<br=
>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_fence_chain_for_each(*pfence, &amp;cha=
in-&gt;base) {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((*pfence)-&gt;=
context !=3D chain-&gt;base.context ||<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 to_dma_fence_chain(*pfence)-&gt;prev_seqno &lt; seqno)<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_fence_put(&amp;chain-&gt;base);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return 0;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +EXPORT_SYMBOL(dma_fence_chain_find_seqno);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static const char *dma_fence_chain_get_driver_name(struct dma=
_fence<br>
&gt;&gt;&gt; *fence)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return &quot;dma_f=
ence_chain&quot;;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static const char *dma_fence_chain_get_timeline_name(struct<b=
r>
&gt;&gt;&gt; dma_fence *fence)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return &quot;unbou=
nd&quot;;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static void dma_fence_chain_irq_work(struct irq_work *work)<b=
r>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct dma_fence_chain *chain;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 chain =3D container_of(work, typeof(*chain=
), work);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* Try to rearm the callback */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (!dma_fence_chain_enable_signaling(&amp=
;chain-&gt;base))<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Ok, we are done=
. No more unsignaled fences left */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_signal(&=
amp;chain-&gt;base);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_fence_put(&amp;chain-&gt;base);<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static void dma_fence_chain_cb(struct dma_fence *f, struct<br=
>
&gt;&gt;&gt; dma_fence_cb *cb)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct dma_fence_chain *chain;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 chain =3D container_of(cb, typeof(*chain),=
 cb);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 irq_work_queue(&amp;chain-&gt;work);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_fence_put(f);<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static bool dma_fence_chain_enable_signaling(struct dma_fence=
 *fence)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct dma_fence_chain *head =3D to_dma_fe=
nce_chain(fence);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_fence_get(&amp;head-&gt;base);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_fence_chain_for_each(fence, &amp;head-=
&gt;base) {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence_c=
hain *chain =3D to_dma_fence_chain(fence);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence *=
f =3D chain ? chain-&gt;fence : fence;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_get(f);<=
br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dma_fence_add=
_callback(f, &amp;head-&gt;cb,<br>
&gt;&gt;&gt; dma_fence_chain_cb)) {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dma_fence_put(fence);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return true;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_put(f);<=
br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_fence_put(&amp;head-&gt;base);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return false;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static bool dma_fence_chain_signaled(struct dma_fence *fence)=
<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_fence_chain_for_each(fence, fence) {<b=
r>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence_c=
hain *chain =3D to_dma_fence_chain(fence);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence *=
f =3D chain ? chain-&gt;fence : fence;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dma_fence_is_=
signaled(f)) {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dma_fence_put(fence);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return false;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return true;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static void dma_fence_chain_release(struct dma_fence *fence)<=
br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct dma_fence_chain *chain =3D to_dma_f=
ence_chain(fence);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_fence_put(chain-&gt;prev);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_fence_put(chain-&gt;fence);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_fence_free(fence);<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +const struct dma_fence_ops dma_fence_chain_ops =3D {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 .get_driver_name =3D dma_fence_chain_get_d=
river_name,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 .get_timeline_name =3D dma_fence_chain_get=
_timeline_name,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 .enable_signaling =3D dma_fence_chain_enab=
le_signaling,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 .signaled =3D dma_fence_chain_signaled,<br=
>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 .release =3D dma_fence_chain_release,<br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +EXPORT_SYMBOL(dma_fence_chain_ops);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +/**<br>
&gt;&gt;&gt; + * dma_fence_chain_init - initialize a fence chain<br>
&gt;&gt;&gt; + * @chain: the chain node to initialize<br>
&gt;&gt;&gt; + * @prev: the previous fence<br>
&gt;&gt;&gt; + * @fence: the current fence<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * Initialize a new chain node and either start a new chain o=
r add<br>
&gt;&gt;&gt; the node to<br>
&gt;&gt;&gt; + * the existing chain of the previous fence.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +void dma_fence_chain_init(struct dma_fence_chain *chain,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct dma_fence *prev,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct dma_fence *fence,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint64_t seqno)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct dma_fence_chain *prev_chain =3D to_=
dma_fence_chain(prev);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint64_t context;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 spin_lock_init(&amp;chain-&gt;lock);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 chain-&gt;prev =3D prev;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 chain-&gt;fence =3D fence;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 chain-&gt;prev_seqno =3D 0;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 init_irq_work(&amp;chain-&gt;work, dma_fen=
ce_chain_irq_work);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* Try to reuse the context of the previou=
s chain node. */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (prev_chain &amp;&amp; __dma_fence_is_l=
ater(seqno, prev-&gt;seqno)) {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 context =3D prev-&=
gt;context;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chain-&gt;prev_seq=
no =3D prev-&gt;seqno;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 } else {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 context =3D dma_fe=
nce_context_alloc(1);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Make sure that =
we always have a valid sequence number. */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (prev_chain)<br=
>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 seqno =3D max(prev-&gt;seqno, seqno);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_fence_init(&amp;chain-&gt;base, &amp;d=
ma_fence_chain_ops,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 &amp;chain-&gt;lock, context, seqno);<br>
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
&gt;&gt;&gt; + * fence-chain: chain fences together in a timeline<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * Copyright (C) 2018 Advanced Micro Devices, Inc.<br>
&gt;&gt;&gt; + * Authors:<br>
&gt;&gt;&gt; + *=C2=A0=C2=A0=C2=A0 Christian K=C3=B6nig &lt;<a href=3D"mail=
to:christian.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>=
&gt;<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * This program is free software; you can redistribute it and=
/or<br>
&gt;&gt;&gt; modify it<br>
&gt;&gt;&gt; + * under the terms of the GNU General Public License version =
2 as<br>
&gt;&gt;&gt; published by<br>
&gt;&gt;&gt; + * the Free Software Foundation.<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * This program is distributed in the hope that it will be us=
eful,<br>
&gt;&gt;&gt; but WITHOUT<br>
&gt;&gt;&gt; + * ANY WARRANTY; without even the implied warranty of<br>
&gt;&gt;&gt; MERCHANTABILITY or<br>
&gt;&gt;&gt; + * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU Genera=
l Public<br>
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
&gt;&gt;&gt; + * struct dma_fence_chain - fence to represent an node of a f=
ence chain<br>
&gt;&gt;&gt; + * @base: fence base class<br>
&gt;&gt;&gt; + * @lock: spinlock for fence handling<br>
&gt;&gt;&gt; + * @prev: previous fence of the chain<br>
&gt;&gt;&gt; + * @prev_seqno: original previous seqno before garbage collec=
tion<br>
&gt;&gt;&gt; + * @fence: encapsulated fence<br>
&gt;&gt;&gt; + * @cb: callback structure for signaling<br>
&gt;&gt;&gt; + * @work: irq work item for signaling<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +struct dma_fence_chain {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct dma_fence base;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 spinlock_t lock;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct dma_fence *prev;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 u64 prev_seqno;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct dma_fence *fence;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct dma_fence_cb cb;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct irq_work work;<br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +extern const struct dma_fence_ops dma_fence_chain_ops;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +/**<br>
&gt;&gt;&gt; + * to_dma_fence_chain - cast a fence to a dma_fence_chain<br>
&gt;&gt;&gt; + * @fence: fence to cast to a dma_fence_array<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * Returns NULL if the fence is not a dma_fence_chain,<br>
&gt;&gt;&gt; + * or the dma_fence_chain otherwise.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +static inline struct dma_fence_chain *<br>
&gt;&gt;&gt; +to_dma_fence_chain(struct dma_fence *fence)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (!fence || fence-&gt;ops !=3D &amp;dma_=
fence_chain_ops)<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return container_of(fence, struct dma_fenc=
e_chain, base);<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +/**<br>
&gt;&gt;&gt; + * dma_fence_chain_for_each - iterate over all fences in chai=
n<br>
&gt;&gt;&gt; + * @iter: current fence<br>
&gt;&gt;&gt; + * @head: starting point<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * Iterate over all fences in the chain. We keep a reference =
to the<br>
&gt;&gt;&gt; current<br>
&gt;&gt;&gt; + * fence while inside the loop which must be dropped when bre=
aking out.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +#define dma_fence_chain_for_each(iter, head)=C2=A0=C2=A0=C2=
=A0 \<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 for (iter =3D dma_fence_get(head); iter; \=
<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iter =3D dma=
_fence_chain_walk(head))<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +struct dma_fence *dma_fence_chain_walk(struct dma_fence *fenc=
e);<br>
&gt;&gt;&gt; +int dma_fence_chain_find_seqno(struct dma_fence **pfence, uin=
t64_t<br>
&gt;&gt;&gt; seqno);<br>
&gt;&gt;&gt; +void dma_fence_chain_init(struct dma_fence_chain *chain,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct dma_fence *prev,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct dma_fence *fence,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint64_t seqno);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#endif /* __LINUX_DMA_FENCE_CHAIN_H */<br>
&gt;&gt;<br>
<br>
_______________________________________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank">dri-de=
vel@lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listin=
fo/dri-devel</a></blockquote></div></div>

--000000000000eaee730581f18fdd--

--===============0666902528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0666902528==--
