From: Ben Skeggs <skeggsb@gmail.com>
Subject: Re: [Nouveau] [Intel-gfx] [PATCH v6 08/17] drm/ttm: use gem vma_node
Date: Mon, 16 Sep 2019 14:45:06 +1000
Message-ID: <CACAvsv4GOQjS9mkJM5Os01O0WZJpkn0FeupEq99O1FsDgTZVCQ@mail.gmail.com>
References: <20190805140119.7337-1-kraxel@redhat.com> <20190805140119.7337-9-kraxel@redhat.com>
 <20190813151115.GA29955@ulmo> <20190814055827.6hrxj6daovxxnnvw@sirius.home.kraxel.org>
 <20190814093524.GA31345@ulmo> <20190814101411.lj3p6zjzbjvnnjf4@sirius.home.kraxel.org>
 <CACAvsv5Rar9F=Wf-9HBpndY4QaQZcGCx05j0esvV9pitM=JoGg@mail.gmail.com>
 <20190821115523.GA21839@ulmo> <CAKb7UvjXq0ptiPYu5EGH6sJAbbRjN3X4f_knrxyOHD1Zi7P1BA@mail.gmail.com>
 <20190910215259.GA7525@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190910215259.GA7525@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ilia Mirkin <imirkin@alum.mit.edu>, ML dri-devel <dri-devel@lists.freedesktop.org>, ML nouveau <nouveau@lists.freedesktop.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, linux-graphics-maintainer@vmware.com, Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, 11 Sep 2019 at 07:53, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Sat, Sep 07, 2019 at 09:58:46PM -0400, Ilia Mirkin wrote:
> > On Wed, Aug 21, 2019 at 7:55 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > On Wed, Aug 21, 2019 at 04:33:58PM +1000, Ben Skeggs wrote:
> > > > On Wed, 14 Aug 2019 at 20:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > > >
> > > > >   Hi,
> > > > >
> > > > > > > Changing the order doesn't look hard.  Patch attached (untested, have no
> > > > > > > test hardware).  But maybe I missed some detail ...
> > > > > >
> > > > > > I came up with something very similar by splitting up nouveau_bo_new()
> > > > > > into allocation and initialization steps, so that when necessary the GEM
> > > > > > object can be initialized in between. I think that's slightly more
> > > > > > flexible and easier to understand than a boolean flag.
> > > > >
> > > > > Yes, that should work too.
> > > > >
> > > > > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> > > > Acked-by: Ben Skeggs <bskeggs@redhat.com>
> > >
> > > Thanks guys, applied to drm-misc-next.
> >
> > Hi Thierry,
> >
> > Initial investigations suggest that this commit currently in drm-next
> >
> > commit 019cbd4a4feb3aa3a917d78e7110e3011bbff6d5
> > Author: Thierry Reding <treding@nvidia.com>
> > Date:   Wed Aug 14 11:00:48 2019 +0200
> >
> >     drm/nouveau: Initialize GEM object before TTM object
> >
> > breaks nouveau userspace which tries to allocate GEM objects with a
> > non-page-aligned size. Previously nouveau_gem_new would just call
> > nouveau_bo_init which would call nouveau_bo_fixup_align before
> > initializing the GEM object. With this change, it is done after. What
> > do you think -- OK to just move that bit of logic into the new
> > nouveau_bo_alloc() (and make size/align be pointers so that they can
> > be fixed up?)
>
> Hi Ilia,
>
> sorry, got side-tracked earlier and forgot to send this out. I'll turn
> this into a proper patch, but if you manage to find the time to test
> this while I work out the userspace issues that are preventing me from
> testing this more thoroughly, that'd be great.
I can confirm both I can reproduce the bug, and that the fix here
appears to do the trick nicely.

Ben.

>
> Thierry
>
> --- >8 ---
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> index e918b437af17..7d5ede756711 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> @@ -186,8 +186,8 @@ nouveau_bo_fixup_align(struct nouveau_bo *nvbo, u32 flags,
>  }
>
>  struct nouveau_bo *
> -nouveau_bo_alloc(struct nouveau_cli *cli, u64 size, u32 flags, u32 tile_mode,
> -                u32 tile_flags)
> +nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size, int *align, u32 flags,
> +                u32 tile_mode, u32 tile_flags)
>  {
>         struct nouveau_drm *drm = cli->drm;
>         struct nouveau_bo *nvbo;
> @@ -195,8 +195,8 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 size, u32 flags, u32 tile_mode,
>         struct nvif_vmm *vmm = cli->svm.cli ? &cli->svm.vmm : &cli->vmm.vmm;
>         int i, pi = -1;
>
> -       if (!size) {
> -               NV_WARN(drm, "skipped size %016llx\n", size);
> +       if (!*size) {
> +               NV_WARN(drm, "skipped size %016llx\n", *size);
>                 return ERR_PTR(-EINVAL);
>         }
>
> @@ -266,7 +266,7 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 size, u32 flags, u32 tile_mode,
>                         pi = i;
>
>                 /* Stop once the buffer is larger than the current page size. */
> -               if (size >= 1ULL << vmm->page[i].shift)
> +               if (*size >= 1ULL << vmm->page[i].shift)
>                         break;
>         }
>
> @@ -281,6 +281,8 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 size, u32 flags, u32 tile_mode,
>         }
>         nvbo->page = vmm->page[pi].shift;
>
> +       nouveau_bo_fixup_align(nvbo, flags, align, size);
> +
>         return nvbo;
>  }
>
> @@ -292,12 +294,11 @@ nouveau_bo_init(struct nouveau_bo *nvbo, u64 size, int align, u32 flags,
>         size_t acc_size;
>         int ret;
>
> -       acc_size = ttm_bo_dma_acc_size(nvbo->bo.bdev, size, sizeof(*nvbo));
> -
> -       nouveau_bo_fixup_align(nvbo, flags, &align, &size);
>         nvbo->bo.mem.num_pages = size >> PAGE_SHIFT;
>         nouveau_bo_placement_set(nvbo, flags, 0);
>
> +       acc_size = ttm_bo_dma_acc_size(nvbo->bo.bdev, size, sizeof(*nvbo));
> +
>         ret = ttm_bo_init(nvbo->bo.bdev, &nvbo->bo, size, type,
>                           &nvbo->placement, align >> PAGE_SHIFT, false,
>                           acc_size, sg, robj, nouveau_bo_del_ttm);
> @@ -318,7 +319,8 @@ nouveau_bo_new(struct nouveau_cli *cli, u64 size, int align,
>         struct nouveau_bo *nvbo;
>         int ret;
>
> -       nvbo = nouveau_bo_alloc(cli, size, flags, tile_mode, tile_flags);
> +       nvbo = nouveau_bo_alloc(cli, &size, &align, flags, tile_mode,
> +                               tile_flags);
>         if (IS_ERR(nvbo))
>                 return PTR_ERR(nvbo);
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.h b/drivers/gpu/drm/nouveau/nouveau_bo.h
> index 62930d834fba..38f9d8350963 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.h
> @@ -71,8 +71,8 @@ nouveau_bo_ref(struct nouveau_bo *ref, struct nouveau_bo **pnvbo)
>  extern struct ttm_bo_driver nouveau_bo_driver;
>
>  void nouveau_bo_move_init(struct nouveau_drm *);
> -struct nouveau_bo *nouveau_bo_alloc(struct nouveau_cli *, u64 size, u32 flags,
> -                                   u32 tile_mode, u32 tile_flags);
> +struct nouveau_bo *nouveau_bo_alloc(struct nouveau_cli *, u64 *size, int *align,
> +                                   u32 flags, u32 tile_mode, u32 tile_flags);
>  int  nouveau_bo_init(struct nouveau_bo *, u64 size, int align, u32 flags,
>                      struct sg_table *sg, struct dma_resv *robj);
>  int  nouveau_bo_new(struct nouveau_cli *, u64 size, int align, u32 flags,
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
> index c2bfc0591909..1bdffd714456 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -188,7 +188,8 @@ nouveau_gem_new(struct nouveau_cli *cli, u64 size, int align, uint32_t domain,
>         if (domain & NOUVEAU_GEM_DOMAIN_COHERENT)
>                 flags |= TTM_PL_FLAG_UNCACHED;
>
> -       nvbo = nouveau_bo_alloc(cli, size, flags, tile_mode, tile_flags);
> +       nvbo = nouveau_bo_alloc(cli, &size, &align, flags, tile_mode,
> +                               tile_flags);
>         if (IS_ERR(nvbo))
>                 return PTR_ERR(nvbo);
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_prime.c b/drivers/gpu/drm/nouveau/nouveau_prime.c
> index 84658d434225..656c334ee7d9 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_prime.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
> @@ -62,14 +62,15 @@ struct drm_gem_object *nouveau_gem_prime_import_sg_table(struct drm_device *dev,
>         struct nouveau_drm *drm = nouveau_drm(dev);
>         struct nouveau_bo *nvbo;
>         struct dma_resv *robj = attach->dmabuf->resv;
> -       size_t size = attach->dmabuf->size;
> +       u64 size = attach->dmabuf->size;
>         u32 flags = 0;
> +       int align = 0;
>         int ret;
>
>         flags = TTM_PL_FLAG_TT;
>
>         dma_resv_lock(robj, NULL);
> -       nvbo = nouveau_bo_alloc(&drm->client, size, flags, 0, 0);
> +       nvbo = nouveau_bo_alloc(&drm->client, &size, &align, flags, 0, 0);
>         dma_resv_unlock(robj);
>         if (IS_ERR(nvbo))
>                 return ERR_CAST(nvbo);
> @@ -84,7 +85,7 @@ struct drm_gem_object *nouveau_gem_prime_import_sg_table(struct drm_device *dev,
>                 return ERR_PTR(-ENOMEM);
>         }
>
> -       ret = nouveau_bo_init(nvbo, size, 0, flags, sg, robj);
> +       ret = nouveau_bo_init(nvbo, size, align, flags, sg, robj);
>         if (ret) {
>                 nouveau_bo_ref(NULL, &nvbo);
>                 return ERR_PTR(ret);
