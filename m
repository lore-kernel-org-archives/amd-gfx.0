Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36041C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 17:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B891A10E605;
	Tue, 24 Jun 2025 17:04:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="joZhIvLe";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C4B410E605
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 17:04:57 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b31ca219b97so871185a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 10:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750784696; x=1751389496; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCpcq+onKf493q93qJL7woUcZtRqF+2OC/4rkx0J1nM=;
 b=joZhIvLeFrvJFjhwxSwpng5m7wnBWJss2LyvyO1E3HEr6DIRSIntmj2FefFnW9RPdb
 WARP6VMGLqbEkiknNU6/gb4bvkyMzN8SHxLGQgCqm/a9wCrD/31UZdyvk+K/8AFqsimq
 +YIPoA3wf5tw0BJlZgl1JxqE96Fe3QxVpy11yXx4XSw+/VHCS4tYJNDMwlyL4hHVkYj+
 8Ae/MXIkbOQS0AHfwDF6sjivCjzrJ91+n82bIYo4oEHSX2dd9IeN4sIqdxfPX8lFEakX
 l1cgWDydXqNxVhTx/Dry7AnLv/bLFb6p+SlPyuS6WACJ8L+CPAdP2jyEVW02sPlebXz2
 EVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750784696; x=1751389496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCpcq+onKf493q93qJL7woUcZtRqF+2OC/4rkx0J1nM=;
 b=v3lRdP+oFeqD7qAbNE3h/nWPjGhv5TS4bC5FuD8D7SZ64trAu7F4Gf31htt3xgs1aK
 WCU+sall2iQ/qN7WAB2XUV8QBbQ5t0loGuPVROiUc+JLWNYCWZQeqmBL9mep7Db/dRzo
 zewMG0+iBB+oTnIph0o/yEfGhKVx4r/T5QmyzueRGKreo3yVinBBedzjhkyNoVfPY6iN
 +sfWHav6X9Wwp84r+8Qs1cX9o7uETsZtcMV+6PZxu8VjfLzHzw9cpWz77X0z2ijjCPEM
 7zPrvBVLluumUGwAHwmlZUQLP32LqnObLE0kJ1N9Z66bUxwviGwmd+EECWG37mrsAziG
 Hzkw==
X-Gm-Message-State: AOJu0YwawqL5KgJNsx4IWhSx8TmqjrOhV0wlA5raS58PHVpw90JDMQxv
 hA7Ek/Mg6Czh5FGezyrZg4dwT6bKHw7V0haODDX60mkwQmz1RymI9ruu7ps3wiri8KHmUfuprKu
 UmnxSpo2msoP95QhsP4wmWzHWAHVDlb4=
X-Gm-Gg: ASbGncs5U4eCIkaBRJkG2LvcCia4Xl0P0SwwA+DryD/weZTW3Ng8bVu+AuqljKf2qZO
 931Zl1fpoT2LSesy6Ua1LBjsXgcjYOVnGicD5EMdRA9/LC2b+At2/+uYCKLqcf9SLtLMzHXSzK1
 SLAurj7JNrD1zXALMaQ+yEKp2rECLPv7prbNctu/QuzvTC
X-Google-Smtp-Source: AGHT+IEtHq/Kwx1hqlp0rJfC0xcNGqPixy5Kz3MEQI0++BjnbabUDLMjrU0wjPC0KM3oND5Zzx1T2sCYZIA0WRi1+kA=
X-Received: by 2002:a17:90b:5286:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-3159d8f9537mr9935735a91.7.1750784696291; Tue, 24 Jun 2025
 10:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-9-Prike.Liang@amd.com>
In-Reply-To: <20250624084535.1178476-9-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Jun 2025 13:04:44 -0400
X-Gm-Features: AX0GCFsldtt6ahpNepFhQ_Z5JafGVPQMvaZQjc6O18qXNiw658YBBMq40hYiPBo
Message-ID: <CADnq5_MOG5Gcx8HR9oLHJtJ7Xbz5cNTM14YsLoDoD5jQy5VKiw@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] drm/amdgpu: validate userq activity status for
 GEM_VA unmap
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 24, 2025 at 4:53=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> The userq VA unmap requires validating queue status before unamapping
> it, if user tries to unmap a busy userq by GEM VA IOCTL then the
> driver should report an error for this illegal usage.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 534a9c98c011..5243512c9cec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -243,7 +243,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_m=
gr,
>         return r;
>  }
>
> -static void
> +static int
>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>                                  struct amdgpu_usermode_queue *queue)
>  {
> @@ -252,10 +252,14 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_user=
q_mgr *uq_mgr,
>
>         if (f && !dma_fence_is_signaled(f)) {
>                 ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(=
100));
> -               if (ret <=3D 0)
> +               if (ret <=3D 0) {
>                         drm_file_err(uq_mgr->file, "Timed out waiting for=
 fence=3D%llu:%llu\n",
>                                      f->context, f->seqno);
> +                       return -ETIMEDOUT;
> +               }
>         }
> +
> +       return 0;
>  }
>
>  static void
> @@ -471,7 +475,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queu=
e_id)
>                 mutex_unlock(&uq_mgr->userq_mutex);
>                 return -EINVAL;
>         }
> -       amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
> +
> +       if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
> +               drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy=
 userq\n");
> +               mutex_unlock(&uq_mgr->userq_mutex);
> +               return -EINVAL;

This is a memory leak.  I think we want to destroy a busy queue if the
fence doesn't signal.  If it doesn't signal, we should unmap/reset the
queue and destroy it.

Alex

> +       }
> +
>         r =3D amdgpu_bo_reserve(queue->db_obj.obj, true);
>         if (!r) {
>                 amdgpu_bo_unpin(queue->db_obj.obj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 5e075e8f0ca3..afc493f43256 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1929,6 +1929,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>         struct amdgpu_bo_va_mapping *mapping;
>         struct amdgpu_vm *vm =3D bo_va->base.vm;
>         bool valid =3D true;
> +       int r;
>
>         saddr /=3D AMDGPU_GPU_PAGE_SIZE;
>
> @@ -1949,6 +1950,13 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>                         return -ENOENT;
>         }
>
> +       /* It's unlike to happen that the mapping userq hasn't been idled
> +        * during user unmap vm except the vm unmaped forcely from user s=
pace.
> +        */
> +       r =3D amdgpu_userq_gem_va_unmap_validate(vm, saddr);
> +       if (unlikely(r && r !=3D -EBUSY))
> +               dev_warn(adev->dev, "Here should be an improper unmap req=
uest from user space\n");
> +
>         list_del(&mapping->list);
>         amdgpu_vm_it_remove(mapping, &vm->va);
>         mapping->bo_va =3D NULL;
> --
> 2.34.1
>
