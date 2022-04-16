Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1F0C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Apr 2022 18:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8FE310E0A1;
	Sat, 16 Apr 2022 18:43:52 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D4A610E0A1
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Apr 2022 18:43:51 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-2eafabbc80aso108636007b3.11
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Apr 2022 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=82ToEq2sTFJ1/4Fxl0uzbS0u0tAvWXjhBndfTjYzHTE=;
 b=GAowiEsSOWWI0EmanxkjSaNTVKcFDIHlOGuXLnHZxd5B9ttgHWUUQKL8RDDbmxKZfu
 rqHc3xT5wAHyzJlRrrpmunBYa8LXVL7Ern5wazb1+nG+pODwey6vXgXxGTCq2P9reVjs
 06SSQx9EHC5oyA7KLr4npEEBWgDAskNuyOgKDmkUf28scwmXxxF0R/4YXr3wmz2ymxxh
 545qWGOV/jNSEsXvXdGjbjs7aOMKsUtUsg5UR/TzSkQ2kHnzea075dS0Edie1g3hxevb
 Zu2MVdpCP7b+QA4HBV8JI+tqRoDDq3YE3EVn9kE2hRRQrV+y2MMMXvBmJaROuQA0F86T
 KlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=82ToEq2sTFJ1/4Fxl0uzbS0u0tAvWXjhBndfTjYzHTE=;
 b=u9XfMDQROkGOhfEss3Edp7Lq7gSnusVQpI81taexPpUgelUry92yPy27IFIO8n4cPy
 R2+FSBF2oQ0CK0SSWSakDkeWCjQfsUI972E9XYzlSz1sn2N3ynV6EnBsjjiNJoHvWMo8
 IlFJxOdlagELhNoNRqsnCxvlMZxHPAFqTSSr4CrEIspuBuVK0oNhMwOr4F/dsR3KMCl9
 OUX+UqNi1/UQ20s/fQYKW8ouFbJxXe7LbKd6Cv6OCtdHOjV6hUt1vpKrSV8n2rvOj6pp
 Clnb6DStA0JKN3wGBf/RPWxvpTBvCl6WElu/CcnCHUAAGO99yHve1hPMRP/XBj9CGCV9
 arKg==
X-Gm-Message-State: AOAM530yYuKwH3j4K1MNbQ8TdIsF20dyZ3JkVpKIECMOqYRdDPXNdUHX
 Hucmkv+fq1kuIuf9KpLFHIf7JH/j89txi6dp4PAFXQ==
X-Google-Smtp-Source: ABdhPJy8DgJjAwF5I/rwKludBrIuoZcQ67Pn3JtQjnhyPw7BQZvR4kuwQW1uid19lIRG2Zhl3jKgWZSfuQ3YzupPNVU=
X-Received: by 2002:a81:2055:0:b0:2d4:2fd7:a4b9 with SMTP id
 g82-20020a812055000000b002d42fd7a4b9mr4363459ywg.444.1650134630300; Sat, 16
 Apr 2022 11:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220331094727.27153-1-christian.koenig@amd.com>
 <20220331094727.27153-5-christian.koenig@amd.com>
 <CAP+8YyGwU+xJkBJ-AYPckQqpY6ucUWWp-QYO4b9UN7WcrEMGkQ@mail.gmail.com>
 <7f1d5626-8429-c06e-5642-5328f0d95044@amd.com>
 <CAP+8YyGiq8V9g58Qbusign4ZcKYxCfTdaNDCWt6-XwjM+kAn_g@mail.gmail.com>
In-Reply-To: <CAP+8YyGiq8V9g58Qbusign4ZcKYxCfTdaNDCWt6-XwjM+kAn_g@mail.gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Sat, 16 Apr 2022 20:43:40 +0200
Message-ID: <CAP+8YyGnXgSa7yA+k+H_KD+8hdxk_MuEJApOR78a8TKQcFbJxQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: allow specifying a syncobj for VM map
 operations
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 6, 2022 at 4:25 AM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> On Mon, Apr 4, 2022 at 8:43 AM Christian K=C3=B6nig <christian.koenig@amd=
.com> wrote:
> >
> > Hi Bas,
> >
> > Am 04.04.22 um 03:32 schrieb Bas Nieuwenhuizen:
> > > Hi Christian,
> > >
> > > Couple of concerns here:
> > >
> > > 1) This is missing the option to wait on a syncobj before executing t=
he VA op.
> >
> > Uff, that was not really planned in any way.
> >
> > Currently all VM operations are scheduled to run behind all CS
> > operations and that is not easily changeable.
> >
> > In other words we planned that disable the VM->CS implicit sync, but no=
t
> > CS->VM.
> >
> > > 2) There are no mechanisms to disable implicit sync yet.
> >
> > Specifying a sync_obj will do that.
> >
> > > 3) in radv we typically signal multiple syncobj, so it would be nice
> > > if we could have that capability here too. Technically we can use the
> > > transfer ioctls, but it is kinda annoying.
> >
> > That shouldn't be much of a problem.

Update: I don't really think this would help, and is not a big issue
anyway. The overhead is only 1-5% on the remap operation and the
alternative doesn't provide the savings I expected.
> >
> > > I had https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Fgithub.com%2FBNieuwenhuizen%2Flinux%2Fcommit%2Fd8a1cce0c4c5c87522ae886=
6faf4f67be7189ef0&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C6d4dec0=
3a52b4ce510b208da15daf2fa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6378=
46327828400310%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi=
LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DK6J%2FHb2NAL8NpoTkaqmpjq4=
xJS9ozpu2UJBZwSA8OIk%3D&amp;reserved=3D0
> > > + radv implementation before we ended up in the situation of waits no=
t
> > > being a doable thing.
> >
> > Well I changed the TLB handling so that waits are doable now :)
> >
> > >
> > > For (1) we can emulate in userspace by waiting for all syncobj to
> > > signal first, but I'm concerned that will result in GPU bubbles due t=
o
> > > CPU work.  To test this out I'm starting to hook up more implicit syn=
c
> > > disabling stuff (starting with the submissions themselves, WIP at
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ithub.com%2FBNieuwenhuizen%2Flinux%2Ftree%2Fno-implicit-sync&amp;data=3D04%=
7C01%7Cchristian.koenig%40amd.com%7C6d4dec03a52b4ce510b208da15daf2fa%7C3dd8=
961fe4884e608e11a82d994e183d%7C0%7C0%7C637846327828400310%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C3000&amp;sdata=3Dtaf3fjRYd2OT9GR%2FgtBsCcoIOtOW0pYjdcsGAe%2BnJSw%3D&amp;re=
served=3D0), which
> > > is why you're seeing some random comments on your dma resv usage
> > > series coming your way.
> >
> > Which is rather welcomed. That patch set certainly needs more eyes on i=
t.
> >
> > Thanks,
> > Christian.
> >
> > >
> > > - Bas
> > >
> > >
> > > On Thu, Mar 31, 2022 at 11:47 AM Christian K=C3=B6nig
> > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > >> To improve synchronization of command submissions with page table up=
dates RADV
> > >> wants to manually wait for the updates to be completed without affec=
ting
> > >> parallel submissions.
> > >>
> > >> Implement this by allowing to specify a drm_sync_obj handle and a ti=
meline
> > >> point for the GEM_VA IOCTL.
> > >>
> > >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >> ---
> > >>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 79 ++++++++++++++++++++-=
----
> > >>   include/uapi/drm/amdgpu_drm.h           |  5 +-
> > >>   2 files changed, 67 insertions(+), 17 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_gem.c
> > >> index 9cdfee67efeb..bf0092f629f9 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > >> @@ -33,6 +33,7 @@
> > >>
> > >>   #include <drm/amdgpu_drm.h>
> > >>   #include <drm/drm_drv.h>
> > >> +#include <drm/drm_syncobj.h>
> > >>   #include <drm/drm_gem_ttm_helper.h>
> > >>
> > >>   #include "amdgpu.h"
> > >> @@ -598,6 +599,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device =
*dev, void *data,
> > >>    * @vm: vm to update
> > >>    * @bo_va: bo_va to update
> > >>    * @operation: map, unmap or clear
> > >> + * @last_update: optional pointer to a dma_fence for the last VM up=
date
> > >>    *
> > >>    * Update the bo_va directly after setting its address. Errors are=
 not
> > >>    * vital here, so they are not reported back to userspace.
> > >> @@ -605,20 +607,21 @@ int amdgpu_gem_metadata_ioctl(struct drm_devic=
e *dev, void *data,
> > >>   static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
> > >>                                      struct amdgpu_vm *vm,
> > >>                                      struct amdgpu_bo_va *bo_va,
> > >> -                                   uint32_t operation)
> > >> +                                   uint32_t operation,
> > >> +                                   struct dma_fence **last_update)
> > >>   {
> > >>          int r;
> > >>
> > >>          if (!amdgpu_vm_ready(vm))
> > >>                  return;
> > >>
> > >> -       r =3D amdgpu_vm_clear_freed(adev, vm, NULL);
> > >> +       r =3D amdgpu_vm_clear_freed(adev, vm, last_update);
> > >>          if (r)
> > >>                  goto error;
> > >>
> > >>          if (operation =3D=3D AMDGPU_VA_OP_MAP ||
> > >>              operation =3D=3D AMDGPU_VA_OP_REPLACE) {
> > >> -               r =3D amdgpu_vm_bo_update(adev, bo_va, false, NULL);
> > >> +               r =3D amdgpu_vm_bo_update(adev, bo_va, false, last_u=
pdate);
> > >>                  if (r)
> > >>                          goto error;

Two further issues here:

1) We're missing the fence in the pde update:
https://github.com/BNieuwenhuizen/linux/commit/0762af558151136a74681944ccb2=
d5e815f5cc57

2) in a replace, we're not emitting the shrunk mappings of the old
bo_va (e.g. the prt_va) in the ioctl, which ends up doing a mapping
update at CS time with implicit sync. I needed
https://github.com/BNieuwenhuizen/linux/commit/fe2559529f5ce3cafa4efb40b025=
d3deb8beab68
to avoid this, but I'm not sure about the lack of  reservation story
here (especially given you called something that looked like this
problem very deadlock prone in one of our earlier threads).


> > >>          }
> > >> @@ -671,6 +674,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, =
void *data,
> > >>          struct drm_gem_object *gobj;
> > >>          struct amdgpu_device *adev =3D drm_to_adev(dev);
> > >>          struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> > >> +       struct dma_fence *fence =3D dma_fence_get_stub();
> > >> +       struct dma_fence_chain *chain =3D NULL;
> > >> +       struct drm_syncobj *syncobj =3D NULL;
> > >>          struct amdgpu_bo *abo;
> > >>          struct amdgpu_bo_va *bo_va;
> > >>          struct amdgpu_bo_list_entry vm_pd;
> > >> @@ -714,17 +720,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev,=
 void *data,
> > >>                  return -EINVAL;
> > >>          }
> > >>
> > >> -       switch (args->operation) {
> > >> -       case AMDGPU_VA_OP_MAP:
> > >> -       case AMDGPU_VA_OP_UNMAP:
> > >> -       case AMDGPU_VA_OP_CLEAR:
> > >> -       case AMDGPU_VA_OP_REPLACE:
> > >> -               break;
> > >> -       default:
> > >> -               dev_dbg(dev->dev, "unsupported operation %d\n",
> > >> -                       args->operation);
> > >> -               return -EINVAL;
> > >> -       }
> > >> +       /* For debugging delay all VM updates till CS time */
> > >> +       if (!amdgpu_vm_debug)
> > >> +               args->flags |=3D AMDGPU_VM_DELAY_UPDATE;
>
> FWIW in my testing syncobj + AMDGPU_VM_DELAY_UPDATE seems to make the
> explicit sync not work (because we don't execute the map operations,
> and then the delayed operations don't know about the syncobj). So
> besides deleting this test code, should we reject
> AMDGPU_VM_DELAY_UPDATE + syncobj?
>
> With that I've had success getting some overlap (e.g.
> https://drive.google.com/file/d/1ER1fmx6jmZi1yHDyn0gefitmqHUGM0iL/view?us=
p=3Dsharing),
> though I still got a bit more than expected implicit synchronization
> going on due to creation of new buffers and their initial map
> operations. Though that seems to be squarely a radv problem :)
>
> As a side note, are MAP/UNMAP operations without AMDGPU_VM_PAGE_PRT
> valid or do we need to guard for them?
>
>
> > >>
> > >>          INIT_LIST_HEAD(&list);
> > >>          INIT_LIST_HEAD(&duplicates);
> > >> @@ -763,6 +761,30 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev,=
 void *data,
> > >>                  bo_va =3D NULL;
> > >>          }
> > >>
> > >> +       if (args->syncobj) {
> > >> +               syncobj =3D drm_syncobj_find(filp, args->syncobj);
> > >> +               if (!syncobj) {
> > >> +                       r =3D -EINVAL;
> > >> +                       goto error_backoff;
> > >> +               }
> > >> +
> > >> +               if (args->timeline_point) {
> > >> +                       chain =3D dma_fence_chain_alloc();
> > >> +                       if (!chain) {
> > >> +                               r =3D -ENOMEM;
> > >> +                               goto error_put_syncobj;
> > >> +                       }
> > >> +               }
> > >> +
> > >> +               /*
> > >> +                * Update the VM once before to make sure there are =
no other
> > >> +                * pending updates.
> > >> +                */
> > >> +               if (!(args->flags & AMDGPU_VM_DELAY_UPDATE))
> > >> +                       amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo=
_va,
> > >> +                                               args->operation, NUL=
L);
> > >> +       }
> > >> +
> > >>          switch (args->operation) {
> > >>          case AMDGPU_VA_OP_MAP:
> > >>                  va_flags =3D amdgpu_gem_va_map_flags(adev, args->fl=
ags);
> > >> @@ -786,17 +808,42 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev=
, void *data,
> > >>                                               va_flags);
> > >>                  break;
> > >>          default:
> > >> +               dev_dbg(dev->dev, "unsupported operation %d\n",
> > >> +                       args->operation);
> > >> +               r =3D -EINVAL;
> > >>                  break;
> > >>          }
> > >> -       if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !amdgpu=
_vm_debug)
> > >> +       if (r)
> > >> +               goto error_free_chain;
> > >> +
> > >> +       if (!(args->flags & AMDGPU_VM_DELAY_UPDATE))
> > >>                  amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> > >> -                                       args->operation);
> > >> +                                       args->operation, syncobj ?
> > >> +                                       &fence : NULL);
> > >> +
> > >> +       if (syncobj) {
> > >> +               if (chain) {
> > >> +                       drm_syncobj_add_point(syncobj, chain, fence,
> > >> +                                             args->timeline_point);
> > >> +                       chain =3D NULL;
> > >> +               } else {
> > >> +                       drm_syncobj_replace_fence(syncobj, fence);
> > >> +               }
> > >> +       }
> > >> +
> > >> +error_free_chain:
> > >> +       dma_fence_chain_free(chain);
> > >> +
> > >> +error_put_syncobj:
> > >> +       if (syncobj)
> > >> +               drm_syncobj_put(syncobj);
> > >>
> > >>   error_backoff:
> > >>          ttm_eu_backoff_reservation(&ticket, &list);
> > >>
> > >>   error_unref:
> > >>          drm_gem_object_put(gobj);
> > >> +       dma_fence_put(fence);
> > >>          return r;
> > >>   }
> > >>
> > >> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu=
_drm.h
> > >> index 1d65c1fbc4ec..f84b5f2c817c 100644
> > >> --- a/include/uapi/drm/amdgpu_drm.h
> > >> +++ b/include/uapi/drm/amdgpu_drm.h
> > >> @@ -533,7 +533,8 @@ struct drm_amdgpu_gem_op {
> > >>   struct drm_amdgpu_gem_va {
> > >>          /** GEM object handle */
> > >>          __u32 handle;
> > >> -       __u32 _pad;
> > >> +       /** Optional DRM Syncobj to signal when operation completes =
*/
> > >> +       __u32 syncobj;
> > >>          /** AMDGPU_VA_OP_* */
> > >>          __u32 operation;
> > >>          /** AMDGPU_VM_PAGE_* */
> > >> @@ -544,6 +545,8 @@ struct drm_amdgpu_gem_va {
> > >>          __u64 offset_in_bo;
> > >>          /** Specify mapping size. Must be correctly aligned. */
> > >>          __u64 map_size;
> > >> +       /** Optional Syncobj timeline point to signal */
> > >> +       __u64 timeline_point;
> > >>   };
> > >>
> > >>   #define AMDGPU_HW_IP_GFX          0
> > >> --
> > >> 2.25.1
> > >>
> >
