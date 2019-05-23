From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 01/12] dma-buf: add dynamic caching of sg_table
Date: Thu, 23 May 2019 13:32:53 +0200
Message-ID: <CAKMK7uGj3HEZO4j-2eNSEqJ+C5sNqvNbaeGnFZHDXXMTNN-teg@mail.gmail.com>
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <1556323269-19670-1-git-send-email-lmark@codeaurora.org> <CAO_48GGanguXbmYDD+p1kK_VkiWdZSTYAD1y-0JQK7hqL_OPPg@mail.gmail.com>
 <d7fb2a6b-f516-b506-247d-0f3d4d59ec8e@gmail.com> <CAKMK7uEaeVW0EMtCUeH+WeUmFnovEySz3kebRUcybLeySb4GSA@mail.gmail.com>
 <cbb1f3a1-6cd1-c231-f1b2-8f20a6bad067@amd.com> <CAKMK7uFghnEHjyOaJyui+8g9gJahhnhNWPruPMqPr6VAN1UvsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKMK7uFghnEHjyOaJyui+8g9gJahhnhNWPruPMqPr6VAN1UvsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Liam Mark <lmark@codeaurora.org>, Linaro MM SIG <linaro-mm-sig@lists.linaro.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, DRI mailing list <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, May 23, 2019 at 1:30 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, May 23, 2019 at 1:21 PM Koenig, Christian
> <Christian.Koenig@amd.com> wrote:
> >
> > Am 22.05.19 um 20:30 schrieb Daniel Vetter:
> > > [SNIP]
> > >> Well, it seems you are making incorrect assumptions about the cache
> > >> maintenance of DMA-buf here.
> > >>
> > >> At least for all DRM devices I'm aware of mapping/unmapping an
> > >> attachment does *NOT* have any cache maintenance implications.
> > >>
> > >> E.g. the use case you describe above would certainly fail with amdgpu,
> > >> radeon, nouveau and i915 because mapping a DMA-buf doesn't stop the
> > >> exporter from reading/writing to that buffer (just the opposite actually).
> > >>
> > >> All of them assume perfectly coherent access to the underlying memory.
> > >> As far as I know there is no documented cache maintenance requirements
> > >> for DMA-buf.
> > > I think it is documented. It's just that on x86, we ignore that
> > > because the dma-api pretends there's never a need for cache flushing
> > > on x86, and that everything snoops the cpu caches. Which isn't true
> > > since over 20 ago when AGP happened. The actual rules for x86 dma-buf
> > > are very much ad-hoc (and we occasionally reapply some duct-tape when
> > > cacheline noise shows up somewhere).
> >
> > Well I strongly disagree on this. Even on x86 at least AMD GPUs are also
> > not fully coherent.
> >
> > For example you have the texture cache and the HDP read/write cache. So
> > when both amdgpu as well as i915 would write to the same buffer at the
> > same time we would get a corrupted data as well.
> >
> > The key point is that it is NOT DMA-buf in it's map/unmap call who is
> > defining the coherency, but rather the reservation object and its
> > attached dma_fence instances.
> >
> > So for example as long as a exclusive reservation object fence is still
> > not signaled I can't assume that all caches are flushed and so can't
> > start with my own operation/access to the data in question.
>
> The dma-api doesn't flush device caches, ever. It might flush some
> iommu caches or some other bus cache somewhere in-between. So it also
> won't ever make sure that multiple devices don't trample on each
> another. For that you need something else (like reservation object,
> but I think that's not really followed outside of drm much).
>
> The other bit is the coherent vs. non-coherent thing, which in the
> dma-api land just talks about whether cpu/device access need extra
> flushing or not. Now in practice that extra flushing is always only
> cpu side, i.e. will cpu writes/reads go through the cpu cache, and
> will device reads/writes snoop the cpu caches. That's (afaik at least,
> an in practice, not the abstract spec) the _only_ thing dma-api's
> cache maintenance does. For 0 copy that's all completely irrelevant,
> because as soon as you pick a mode where you need to do manual cache
> management you've screwed up, it's not 0-copy anymore really.
>
> The other hilarious stuff is that on x86 we let userspace (at least
> with i915) do that cache management, so the kernel doesn't even have a
> clue. I think what we need in dma-buf (and dma-api people will scream
> about the "abstraction leak") is some notition about whether an
> importer should snoop or not (or if that device always uses non-snoop
> or snooped transactions). But that would shred the illusion the
> dma-api tries to keep up that all that matters is whether a mapping is
> coherent from the cpu's pov or not, and you can achieve coherence both
> with a cache cpu mapping + snooped transactions, or with wc cpu side
> and non-snooped transactions. Trying to add cache managment (which
> some dma-buf exporter do indeed attempt to) will be even worse.
>
> Again, none of this is about preventing concurrent writes, or making
> sure device caches are flushed correctly around batches.

btw I just grepped for reservation_object, no one outside of
drivers/gpu is using that. So for device access synchronization
everyone else is relying on userspace ordering requests correctly on
its own. Iirc v4l/media is pondering adding dma-fence support, but
that's not going anywhere.

Also, for correctness reservations aren't needed, we allow explicit
syncing userspace to managed dma-fences/drm_syncobj on their own, and
they are allowed to get this wrong.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
