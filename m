Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E44C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Apr 2022 01:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123B310E2FB;
	Mon,  4 Apr 2022 01:32:16 +0000 (UTC)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC9210E2FB
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Apr 2022 01:32:15 +0000 (UTC)
Received: by mail-io1-xd35.google.com with SMTP id b16so9615017ioz.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 03 Apr 2022 18:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1ReaSdR+4/ThPTn3P/GhU2f+slx4pzU/jF/xB0RJLrU=;
 b=Kcrqcd0Hb6yDTJ2cK4dMx2JdtZ3HN7s3Io7IL2gsj4j/mncibVZwYKIvgG/5AosBen
 XVJMgBZwrj+3Ev3Tvr6GiMsYtwC3YPkEVNCyxOGGR9+LqI5s8kQerRiZOZA90lpHTWl3
 J/bdyWxkrnFo396Sfwq00dZqXrMlPKiCvVUX/R51hLivzAoBNlsewcOOLh5RUUjzAs1p
 FAVrPzK2/kfkK3B9dbNtSLjRAjleoVTxZp+pWf1VeLN0JFJ8gCj0QZJkxGPLLT8xZJvj
 sc2wbkO4NnFPP7mKu+WD7juIoExL+15JGviFSCs6K9cbqdmTMiUUmaAyoF8JHASoOf4J
 1l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1ReaSdR+4/ThPTn3P/GhU2f+slx4pzU/jF/xB0RJLrU=;
 b=w6/JRCx7kv2Otq/Y1VARkwny2fYe5P8+NN2hp92pJMWo7pG7PWIHDIO5xudkqHWLTP
 vVhmjxwsSoGxVIA98DI0HpRU6YlXnzOBgz1BWE0hcbzDptynAzsKM7f4WgYFr806DElT
 S/Q5YwquWeOeHskafo8zQxh3p70fnFDU6xa7teP5GCc+6aiCJX2kVt0lcR9NYu9hsueg
 r8akWpORcS1VtE3YI82WdFbc1+LNSR7fWChwTZdOGBIwwzsAFmn9TwBJsODrvbJQJe1e
 wwGXF7gK+E360rKBZhDafBpWiCLyBZu/+DWun0VBVS8k9dz1xbddkhtMEFZxviC1kfvL
 J1tQ==
X-Gm-Message-State: AOAM532CmOLsFmsZVV4QpLaLkU7N1PYmoLyieQWDtjxWNvoPTbBLdURl
 AiyvFpZMJhs2HoPmJ/+RKsCH3HkZTbLlnNe/2CPPT9owCHUdhQ==
X-Google-Smtp-Source: ABdhPJwJ2+PWDsjpbG7h0rXmp2UrcyTMJ85Bsik0s3u+fLAiHCElakSCXKYx7jm/QjOTygAFxkSDMfPcVRPL6mQi99k=
X-Received: by 2002:a05:6602:2d8d:b0:649:f82b:c877 with SMTP id
 k13-20020a0566022d8d00b00649f82bc877mr4305896iow.66.1649035934227; Sun, 03
 Apr 2022 18:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220331094727.27153-1-christian.koenig@amd.com>
 <20220331094727.27153-5-christian.koenig@amd.com>
In-Reply-To: <20220331094727.27153-5-christian.koenig@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Mon, 4 Apr 2022 03:32:17 +0200
Message-ID: <CAP+8YyGwU+xJkBJ-AYPckQqpY6ucUWWp-QYO4b9UN7WcrEMGkQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: allow specifying a syncobj for VM map
 operations
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,

Couple of concerns here:

1) This is missing the option to wait on a syncobj before executing the VA =
op.
2) There are no mechanisms to disable implicit sync yet.
3) in radv we typically signal multiple syncobj, so it would be nice
if we could have that capability here too. Technically we can use the
transfer ioctls, but it is kinda annoying.

I had https://github.com/BNieuwenhuizen/linux/commit/d8a1cce0c4c5c87522ae88=
66faf4f67be7189ef0
+ radv implementation before we ended up in the situation of waits not
being a doable thing.

For (1) we can emulate in userspace by waiting for all syncobj to
signal first, but I'm concerned that will result in GPU bubbles due to
CPU work.  To test this out I'm starting to hook up more implicit sync
disabling stuff (starting with the submissions themselves, WIP at
https://github.com/BNieuwenhuizen/linux/tree/no-implicit-sync), which
is why you're seeing some random comments on your dma resv usage
series coming your way.

- Bas


On Thu, Mar 31, 2022 at 11:47 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> To improve synchronization of command submissions with page table updates=
 RADV
> wants to manually wait for the updates to be completed without affecting
> parallel submissions.
>
> Implement this by allowing to specify a drm_sync_obj handle and a timelin=
e
> point for the GEM_VA IOCTL.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 79 ++++++++++++++++++++-----
>  include/uapi/drm/amdgpu_drm.h           |  5 +-
>  2 files changed, 67 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 9cdfee67efeb..bf0092f629f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -33,6 +33,7 @@
>
>  #include <drm/amdgpu_drm.h>
>  #include <drm/drm_drv.h>
> +#include <drm/drm_syncobj.h>
>  #include <drm/drm_gem_ttm_helper.h>
>
>  #include "amdgpu.h"
> @@ -598,6 +599,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev,=
 void *data,
>   * @vm: vm to update
>   * @bo_va: bo_va to update
>   * @operation: map, unmap or clear
> + * @last_update: optional pointer to a dma_fence for the last VM update
>   *
>   * Update the bo_va directly after setting its address. Errors are not
>   * vital here, so they are not reported back to userspace.
> @@ -605,20 +607,21 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *de=
v, void *data,
>  static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>                                     struct amdgpu_vm *vm,
>                                     struct amdgpu_bo_va *bo_va,
> -                                   uint32_t operation)
> +                                   uint32_t operation,
> +                                   struct dma_fence **last_update)
>  {
>         int r;
>
>         if (!amdgpu_vm_ready(vm))
>                 return;
>
> -       r =3D amdgpu_vm_clear_freed(adev, vm, NULL);
> +       r =3D amdgpu_vm_clear_freed(adev, vm, last_update);
>         if (r)
>                 goto error;
>
>         if (operation =3D=3D AMDGPU_VA_OP_MAP ||
>             operation =3D=3D AMDGPU_VA_OP_REPLACE) {
> -               r =3D amdgpu_vm_bo_update(adev, bo_va, false, NULL);
> +               r =3D amdgpu_vm_bo_update(adev, bo_va, false, last_update=
);
>                 if (r)
>                         goto error;
>         }
> @@ -671,6 +674,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void =
*data,
>         struct drm_gem_object *gobj;
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
>         struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +       struct dma_fence *fence =3D dma_fence_get_stub();
> +       struct dma_fence_chain *chain =3D NULL;
> +       struct drm_syncobj *syncobj =3D NULL;
>         struct amdgpu_bo *abo;
>         struct amdgpu_bo_va *bo_va;
>         struct amdgpu_bo_list_entry vm_pd;
> @@ -714,17 +720,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void=
 *data,
>                 return -EINVAL;
>         }
>
> -       switch (args->operation) {
> -       case AMDGPU_VA_OP_MAP:
> -       case AMDGPU_VA_OP_UNMAP:
> -       case AMDGPU_VA_OP_CLEAR:
> -       case AMDGPU_VA_OP_REPLACE:
> -               break;
> -       default:
> -               dev_dbg(dev->dev, "unsupported operation %d\n",
> -                       args->operation);
> -               return -EINVAL;
> -       }
> +       /* For debugging delay all VM updates till CS time */
> +       if (!amdgpu_vm_debug)
> +               args->flags |=3D AMDGPU_VM_DELAY_UPDATE;
>
>         INIT_LIST_HEAD(&list);
>         INIT_LIST_HEAD(&duplicates);
> @@ -763,6 +761,30 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void=
 *data,
>                 bo_va =3D NULL;
>         }
>
> +       if (args->syncobj) {
> +               syncobj =3D drm_syncobj_find(filp, args->syncobj);
> +               if (!syncobj) {
> +                       r =3D -EINVAL;
> +                       goto error_backoff;
> +               }
> +
> +               if (args->timeline_point) {
> +                       chain =3D dma_fence_chain_alloc();
> +                       if (!chain) {
> +                               r =3D -ENOMEM;
> +                               goto error_put_syncobj;
> +                       }
> +               }
> +
> +               /*
> +                * Update the VM once before to make sure there are no ot=
her
> +                * pending updates.
> +                */
> +               if (!(args->flags & AMDGPU_VM_DELAY_UPDATE))
> +                       amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> +                                               args->operation, NULL);
> +       }
> +
>         switch (args->operation) {
>         case AMDGPU_VA_OP_MAP:
>                 va_flags =3D amdgpu_gem_va_map_flags(adev, args->flags);
> @@ -786,17 +808,42 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, voi=
d *data,
>                                              va_flags);
>                 break;
>         default:
> +               dev_dbg(dev->dev, "unsupported operation %d\n",
> +                       args->operation);
> +               r =3D -EINVAL;
>                 break;
>         }
> -       if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !amdgpu_vm_d=
ebug)
> +       if (r)
> +               goto error_free_chain;
> +
> +       if (!(args->flags & AMDGPU_VM_DELAY_UPDATE))
>                 amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> -                                       args->operation);
> +                                       args->operation, syncobj ?
> +                                       &fence : NULL);
> +
> +       if (syncobj) {
> +               if (chain) {
> +                       drm_syncobj_add_point(syncobj, chain, fence,
> +                                             args->timeline_point);
> +                       chain =3D NULL;
> +               } else {
> +                       drm_syncobj_replace_fence(syncobj, fence);
> +               }
> +       }
> +
> +error_free_chain:
> +       dma_fence_chain_free(chain);
> +
> +error_put_syncobj:
> +       if (syncobj)
> +               drm_syncobj_put(syncobj);
>
>  error_backoff:
>         ttm_eu_backoff_reservation(&ticket, &list);
>
>  error_unref:
>         drm_gem_object_put(gobj);
> +       dma_fence_put(fence);
>         return r;
>  }
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 1d65c1fbc4ec..f84b5f2c817c 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -533,7 +533,8 @@ struct drm_amdgpu_gem_op {
>  struct drm_amdgpu_gem_va {
>         /** GEM object handle */
>         __u32 handle;
> -       __u32 _pad;
> +       /** Optional DRM Syncobj to signal when operation completes */
> +       __u32 syncobj;
>         /** AMDGPU_VA_OP_* */
>         __u32 operation;
>         /** AMDGPU_VM_PAGE_* */
> @@ -544,6 +545,8 @@ struct drm_amdgpu_gem_va {
>         __u64 offset_in_bo;
>         /** Specify mapping size. Must be correctly aligned. */
>         __u64 map_size;
> +       /** Optional Syncobj timeline point to signal */
> +       __u64 timeline_point;
>  };
>
>  #define AMDGPU_HW_IP_GFX          0
> --
> 2.25.1
>
