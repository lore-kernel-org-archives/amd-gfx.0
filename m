Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86130C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 02:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A09C10E418;
	Wed,  6 Apr 2022 02:26:14 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F7C10E418
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 02:26:13 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-2eba37104a2so12422167b3.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Apr 2022 19:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=I7Fi5NV4Y+K0PWuKFKPe/grL5ibYNIZKyw6UaTPycOI=;
 b=WY1a4v/5FJwki0sM3LvubL1AHKWk4sZj7AagT4nbCIylFGr/RfMfFUpO5ImtzCt6l4
 yLTA/WWBqr9rSH6VL5Vk8KdstMnxhPrmscfSI2wmVxSl5W73uXQ+csyL4A/eIH9JlTY+
 q3swA1Zteg5MtU40eZNmA3pC3NrDiFREzUGRtloxxM9Vw/6fmwEk0N2YdAT1gqC9fcYu
 InA/fqziDX+2JiYqLSS11olZmOFSaK+yIjeSVmPA87AasBB3XFNDH6T56MeEEnCNdMxN
 QaPVY+PWk3fNGZ1gIFDLBJoJ9G505wLovOEeC6tpowf6l9aTlCzb0jOx2Urmor1Q91hn
 atLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=I7Fi5NV4Y+K0PWuKFKPe/grL5ibYNIZKyw6UaTPycOI=;
 b=cStpiaDxjQldyrbxkjzQaq3pkbl4VREcGuyAauZUxDbJ/2hqVFdH5JCV1YKt52BUBQ
 ohlarJVkjNCyUqKvUOQy81KBUlyB+z7M1s6pn/ly/Domf12ilMksTfx2qxSw8YRBsCO0
 IzuE+fos5OxXxm3n92KfazaJHABjtqYMVNavThmuG8yWbuTqMMY2eKFQaflvLRQOnujE
 Ocod9wFW1gSKm2JcIoeapxPC0Hvx8iN9Hw2HDzyzKxXm1dpvNGWXkIPsPDxsBWtgioD5
 v50OS/9eRp1uH46AE0H1v/h9RYDdYB+4dSBCggmxnrHuovPLQVG0XF0UImWfTp7yplmL
 XeNg==
X-Gm-Message-State: AOAM532jHlStQKPn4A+hSxnVzZm/NKlnCstZ4xs7ELGk0U21NPim64oa
 xnEqw9yw7WU5RCGSSK+ptNW9F7csQ7UZu/kfDE3vPw==
X-Google-Smtp-Source: ABdhPJwyqDEtMeGWSfRhfchQaMFmvWCKvkjX7DOI0z/G5A12dbI+qxERhIDGJhTVHqF9B3spG10f20BaVT6BEvOVh5c=
X-Received: by 2002:a81:94c:0:b0:2eb:53c4:57d9 with SMTP id
 73-20020a81094c000000b002eb53c457d9mr5163772ywj.254.1649211973005; Tue, 05
 Apr 2022 19:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220331094727.27153-1-christian.koenig@amd.com>
 <20220331094727.27153-4-christian.koenig@amd.com>
In-Reply-To: <20220331094727.27153-4-christian.koenig@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Wed, 6 Apr 2022 04:26:14 +0200
Message-ID: <CAP+8YyGFNe2RoW6S5WmkPMaHUfY7L8gevxH+HZcWRtqjkYTSWg@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: add last_update to amdgpu_vm_update_pdes
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

On Thu, Mar 31, 2022 at 11:47 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Allows separate tracking of VM updates.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 9 +++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 2 +-
>  6 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 57b521bb1eec..92a6ca415ab8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -410,7 +410,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct=
 amdgpu_sync *sync)
>         struct amdgpu_device *adev =3D amdgpu_ttm_adev(pd->tbo.bdev);
>         int ret;
>
> -       ret =3D amdgpu_vm_update_pdes(adev, vm, false);
> +       ret =3D amdgpu_vm_update_pdes(adev, vm, false, NULL);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 50fddd6715db..87daa75b57c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -849,7 +849,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_par=
ser *p)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vm_update_pdes(adev, vm, false);
> +       r =3D amdgpu_vm_update_pdes(adev, vm, false, NULL);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 3f84eedb4d96..9cdfee67efeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -623,7 +623,7 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_dev=
ice *adev,
>                         goto error;
>         }
>
> -       r =3D amdgpu_vm_update_pdes(adev, vm, false);
> +       r =3D amdgpu_vm_update_pdes(adev, vm, false, NULL);
>
>  error:
>         if (r && r !=3D -ERESTARTSYS)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 05024999556b..3391256e2448 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -725,14 +725,15 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages=
_addr, uint64_t addr)
>   * @adev: amdgpu_device pointer
>   * @vm: requested vm
>   * @immediate: submit immediately to the paging queue
> + * @last:update: optional returned last update
>   *
>   * Makes sure all directories are up to date.
>   *
>   * Returns:
>   * 0 for success, error for failure.
>   */
> -int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
> -                         struct amdgpu_vm *vm, bool immediate)
> +int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *=
vm,
> +                         bool immediate, struct dma_fence **last_update)
>  {
>         struct amdgpu_vm_update_params params;
>         struct amdgpu_vm_bo_base *entry;
> @@ -759,7 +760,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>                         goto error;
>         }
>
> -       r =3D vm->update_funcs->commit(&params, &vm->last_update);
> +       r =3D vm->update_funcs->commit(&params, last_update ? : &vm->last=
_update);

This ternary is pretty incomplete.
>         if (r)
>                 goto error;
>
> @@ -2529,7 +2530,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *a=
dev, u32 pasid,
>         if (r)
>                 goto error_unlock;
>
> -       r =3D amdgpu_vm_update_pdes(adev, vm, true);
> +       r =3D amdgpu_vm_update_pdes(adev, vm, true, NULL);
>
>  error_unlock:
>         amdgpu_bo_unreserve(root);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 3c7df1b8e3c9..692ec7b51ac2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -394,8 +394,8 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *a=
dev, struct amdgpu_vm *vm,
>                               int (*callback)(void *p, struct amdgpu_bo *=
bo),
>                               void *param);
>  int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bo=
ol need_pipe_sync);
> -int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
> -                         struct amdgpu_vm *vm, bool immediate);
> +int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *=
vm,
> +                         bool immediate, struct dma_fence **last_update)=
;
>  int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>                           struct amdgpu_vm *vm,
>                           struct dma_fence **fence);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index 907b02045824..74824e3806d5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1294,7 +1294,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd=
, struct svm_range *prange,
>                 last_start =3D prange->start + i + 1;
>         }
>
> -       r =3D amdgpu_vm_update_pdes(adev, vm, false);
> +       r =3D amdgpu_vm_update_pdes(adev, vm, false, NULL);
>         if (r) {
>                 pr_debug("failed %d to update directories 0x%lx\n", r,
>                          prange->start);
> --
> 2.25.1
>
