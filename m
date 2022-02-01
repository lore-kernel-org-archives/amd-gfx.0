Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1292C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Feb 2022 16:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DBB510E6DD;
	Tue,  1 Feb 2022 16:27:56 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8567010E6DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Feb 2022 16:27:55 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id q186so34305075oih.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Feb 2022 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8PB6Z/gq2zBkIwkLH8SsNtPGdILpE0KNW4k/6uQv5c8=;
 b=CU/ujfmP3qaedSEI5TVYPh5OaGPLr9iJFLezmbbWSI/h73e+nTZtsFRRLsd9jLEAF5
 /q+SyjIVlLkESo4JDe6i3GiqbdhFrofvrJS7NQlbeJ/QNcMCo89o2H3DwloKub77Jle4
 GvJ7VKywQsD3P1jqIp8qP2fKJXPSTm8jbv/kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8PB6Z/gq2zBkIwkLH8SsNtPGdILpE0KNW4k/6uQv5c8=;
 b=ixgMTelKKuNOKwsd3LFDoV69eveqz9Vm3Nfu+CTfCkw3MCg71XiQ7BxtgbOzmXMl8k
 abAN2itX5CV+j/a3XjXUmcdIez6XjTUeqOzGy5YR71wZ+uEY1+EUSQEVEvMDXBfALLfG
 dLjnHpxNWQ8SzmxG6xCIAG9wlCsIbTi6dJMbU1moRm3puHw1RSKbcRTwr9HVmC43CEAf
 GCYMrQ/d9n/VBYxiPLJXYnj33qiyVduXTdBPGWCJy+YM+PnluCml0i49Or7HQ5oc93Hx
 7NY3P657KviO7mwFFNhUx2RlGnx7h6WJVtYZzs+2+sYUe8M0XQww9UVMv3njXBXXzeye
 PDyw==
X-Gm-Message-State: AOAM532mAn7144lnqgJlCK6bkN/ThHF8bXfIZX9j92xfzSeuGX9v3Sq2
 RGzkooCqUy4epQXwHkYhpot8j/qwRPnvMmpby7GMn8NS9wQ=
X-Google-Smtp-Source: ABdhPJyyaiYvKVgGYaOSs2DYRlY4AbddSfv+zBI3XciRZT4PvZ2fKyHNZG3SFx8shBbNMzoMGutWxJxlDADG+VVEd8g=
X-Received: by 2002:a05:6808:1304:: with SMTP id
 y4mr1866120oiv.260.1643732874693; 
 Tue, 01 Feb 2022 08:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20220201152802.12159-1-christian.koenig@amd.com>
 <20220201152802.12159-2-christian.koenig@amd.com>
In-Reply-To: <20220201152802.12159-2-christian.koenig@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 1 Feb 2022 17:27:43 +0100
Message-ID: <CAKMK7uEwnC4EzJODd64sXB7ntR3+6jQK+nTHskTWgmv25H=sUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: rename amdgpu_vm_bo_rmv to _del
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
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 1, 2022 at 4:28 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Some people complained about the name and this matches much
> more Linux naming conventions for object functions.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

"some people" sounds mightily ominous :-)

On both patches: Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c          | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c          | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 2 +-
>  6 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 5df387c4d7fb..5d00a6878ef2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -778,7 +778,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev,=
 struct kgd_mem *mem,
>                         continue;
>                 if (attachment[i]->bo_va) {
>                         amdgpu_bo_reserve(bo[i], true);
> -                       amdgpu_vm_bo_rmv(adev, attachment[i]->bo_va);
> +                       amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
>                         amdgpu_bo_unreserve(bo[i]);
>                         list_del(&attachment[i]->list);
>                 }
> @@ -795,7 +795,7 @@ static void kfd_mem_detach(struct kfd_mem_attachment =
*attachment)
>
>         pr_debug("\t remove VA 0x%llx in entry %p\n",
>                         attachment->va, attachment);
> -       amdgpu_vm_bo_rmv(attachment->adev, attachment->bo_va);
> +       amdgpu_vm_bo_del(attachment->adev, attachment->bo_va);
>         drm_gem_object_put(&bo->tbo.base);
>         list_del(&attachment->list);
>         kfree(attachment);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_csa.c
> index da21e60bb827..c6d4d41c4393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> @@ -98,7 +98,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm,
>
>         if (r) {
>                 DRM_ERROR("failed to do bo_map on static CSA, err=3D%d\n"=
, r);
> -               amdgpu_vm_bo_rmv(adev, *bo_va);
> +               amdgpu_vm_bo_del(adev, *bo_va);
>                 ttm_eu_backoff_reservation(&ticket, &list);
>                 return r;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 7c1f1b8ca77d..b4c0a4e77525 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -221,7 +221,7 @@ static void amdgpu_gem_object_close(struct drm_gem_ob=
ject *obj,
>         if (!bo_va || --bo_va->ref_count)
>                 goto out_unlock;
>
> -       amdgpu_vm_bo_rmv(adev, bo_va);
> +       amdgpu_vm_bo_del(adev, bo_va);
>         if (!amdgpu_vm_ready(vm))
>                 goto out_unlock;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index ee3c17bd02fc..efd13898c83e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1194,12 +1194,12 @@ void amdgpu_driver_postclose_kms(struct drm_devic=
e *dev,
>         if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) !=
=3D NULL)
>                 amdgpu_vce_free_handles(adev, file_priv);
>
> -       amdgpu_vm_bo_rmv(adev, fpriv->prt_va);
> +       amdgpu_vm_bo_del(adev, fpriv->prt_va);
>
>         if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
>                 /* TODO: how to handle reserve failure */
>                 BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, true));
> -               amdgpu_vm_bo_rmv(adev, fpriv->csa_va);
> +               amdgpu_vm_bo_del(adev, fpriv->csa_va);
>                 fpriv->csa_va =3D NULL;
>                 amdgpu_bo_unreserve(adev->virt.csa_obj);
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 7910046fe11a..8174d71764d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2653,7 +2653,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, st=
ruct ww_acquire_ctx *ticket)
>  }
>
>  /**
> - * amdgpu_vm_bo_rmv - remove a bo to a specific vm
> + * amdgpu_vm_bo_del - remove a bo to a specific vm
>   *
>   * @adev: amdgpu_device pointer
>   * @bo_va: requested bo_va
> @@ -2662,7 +2662,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, st=
ruct ww_acquire_ctx *ticket)
>   *
>   * Object have to be reserved!
>   */
> -void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
> +void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>                       struct amdgpu_bo_va *bo_va)
>  {
>         struct amdgpu_bo_va_mapping *mapping, *next;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 85fcfb8c5efd..a40a6a993bb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -435,7 +435,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device =
*adev,
>  struct amdgpu_bo_va_mapping *amdgpu_vm_bo_lookup_mapping(struct amdgpu_v=
m *vm,
>                                                          uint64_t addr);
>  void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *=
ticket);
> -void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
> +void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>                       struct amdgpu_bo_va *bo_va);
>  void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_s=
ize,
>                            uint32_t fragment_size_default, unsigned max_l=
evel,
> --
> 2.25.1
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
