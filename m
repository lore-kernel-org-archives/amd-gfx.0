Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDA2FED3CC
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 13:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC3310F598;
	Fri, 24 Apr 2026 13:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AcS8LH+U";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93ABA10F598
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 13:38:06 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-124a7216c9cso491947c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 06:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777037886; cv=none;
 d=google.com; s=arc-20240605;
 b=h7p1k6VJjW+eucHYS0L2uDhsXQmnctPQkn+DA25dvgrlURrXOVNoQ0umf9pvVHS9kd
 ZyMhKRYthLfDBOybqsMyyHoccJDgyFwDkNQ+6x+6bWNiFpyngRf7g13TtXJKSUuMl3bq
 QX9RQ2YLI185RYF0sXDgW2ULjCNin21B2mZwaKmgHAfhV6UWLjGM7qGhxwDJ2m+Ejt3L
 csF1/vSBpg56gMO/tZ8vF1TCyYgiz1fJTjalNrj0qHJ9Lmxs8yxDrCNINy0bkLss6ARi
 Y2m+V64eIKMAnxlO9yNY1MwzDLtuZYlRqSoHR+kE48cznirwU/pu/TuzoQJdDztQF1wi
 TufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2MruGEJL7FbFUE2rRTAexn/1ic6VQroUiXC3xo9633Q=;
 fh=gltY1SNDn8Thmq9dgajgQzR98fiBG2+Ql9xdkvFP7Nk=;
 b=J7XIeMNCOtJzZsM4TBL6KBNzaAkmD3ark7jlTV2EulTF9U43oIf57Gi7RlCP2Gnmx3
 bT0EReuCkE8S3Ymo8QK66WiuytUeCqMQ2US4PspkXwyFoZZWnuLQ86XPSz3kIvgsR6pu
 WFkRHOkcZYXw/xVh28/kgYe2kqrvwbYPiHBs8dLfouF/qnT+56X/c/DLnPhwXDxwb7ac
 00O1R6Xu4GVyQnmlXX9b3zaCaM03l9MMjQ8oqTo9eh5WJh5GOr3Nrc9+i1L8iwBJcHNV
 uqaGhcfAIkBCMpp+kZE8znzyZjbOHw7xAQWrD2e8Yakw4FW46GPKoyBUv8+PJYfsbA1/
 t3AA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777037886; x=1777642686; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MruGEJL7FbFUE2rRTAexn/1ic6VQroUiXC3xo9633Q=;
 b=AcS8LH+U8F6dS4eWSmHQ/Mqfjft8d3m8ZlXXw8rMKOk+jfYN6GIxM3hQODSHnRheZ/
 dqSgPdJ8Dqf7QsgsT9gAm8sAQWtGbZcVE/gI6hqpzwbgtXVL6+BhyJIyLPik6ng3vnQf
 Rg0UDVbAhAYOAE/CYRWFtCDZAyUuL/ruBREnvgl1O7Yn6jGXB3qWVwTQChfF8qVFXyBj
 JRArlGii2dFNpoZjEz0dTueDfZFj8sM+V71oGYjI8rjd8Ln71jeBro6RTFuOmA51DJbM
 /dXNW0BEvuWOTIoMrMO8VwukZXgvKahJbxxjktlvse2QMmCBDnmP4w0jd63CJ4PPAZSB
 lJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777037886; x=1777642686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2MruGEJL7FbFUE2rRTAexn/1ic6VQroUiXC3xo9633Q=;
 b=QX8cPqb5TlU5NXEU6V3LXhWRDLvk55hgu2k0w5q9CMiNt97rHGwTBiF3lyZ7RY/W3O
 OfDqwBooFv+lq43RLBskKoc1jkRx0gUhlcHx537nGb3teuXuNV4PySGDq+ZeBG9c2Lqe
 iic64aRcUzug3+ylcsApGe4DMuaBc0sKhQbq7UJaxBoi3bsghazG+BDdYg0SqgNe7iAv
 pGPHaJIXqxOQuj6CsPtnBzy28s9qSEPo2OKPD7iXZ0r8UyexCJn8qXJ/1GPCH3LxNQcF
 rcsA+v3mv4cdBmLbZrhv/f/bedr+SOytiuKQJBCImlUlNvK18wifxKoT0+JoM2sNsDiX
 Srxw==
X-Gm-Message-State: AOJu0YyTH1BhPYAZKnxXjQLl45TUakVlwvVnMoSMcj/6Shi5I/+iDx9w
 s4r23fkbO8wtHZNdg6i3l0Tm2VhgDLyLM6p0ewFIYI/PpZW+aSkv3VHPdLFik8fxgQRNMuz7mtr
 H/nihicJDj4O5Jn7qUs5GrNclbGeMMV4=
X-Gm-Gg: AeBDieukI7cfKk+o7ZTH19UzLWRxdqIkb2LZ7Z/t9E0Q1uBrBGXGPwHdUtk5AzSfr8w
 bpBwH7PCBlKLodnAy7Apf6sibZK860yrG60PuqBt2Lqpp8cNs+CUTgj2p0qHgvon7yqEn5FLZpi
 0iX4mUuqcaDUJRTzzDSFtttPgsnd55kzhWzvUSlC+O9KVHNrcEmmiWT6SBlC8uHVmmE2BAxMhM5
 UmuQ3G5uCYxt6LtZPCdI8cfp3CTEPiC6QCce+zKfR7liQCzs6oX2oSPilSyOk8wH3OZsoAW/qoQ
 mAP+qxWDJZ3srWFU050vzK4SmzTlEUzRfasnACq3E+29McX0VOG8WlnA6/RBYHgZelqFSTtwPlA
 +k9iD
X-Received: by 2002:a05:7022:238e:b0:12c:8bd1:30a7 with SMTP id
 a92af1059eb24-12c8bd132f7mr5683169c88.2.1777037885558; Fri, 24 Apr 2026
 06:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260210214729.80964-1-David.Wu3@amd.com>
 <20260210214729.80964-10-David.Wu3@amd.com>
In-Reply-To: <20260210214729.80964-10-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Apr 2026 09:37:53 -0400
X-Gm-Features: AQROBzDtjdqtDv54ZJiVp06I26SPebVCrclLxVKZ73ty7q4BYFOWbMttf4SgS-E
Message-ID: <CADnq5_PdNhBtPSOLet4EDnCDW1eLzEb8YYWTHSS8_BLOLV7zvQ@mail.gmail.com>
Subject: Re: [PATCH 09/14] drm/amdgpu/userq: rework on
 amdgpu_userq_create_wptr_mapping
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com, leo.liu@amd.com, Boyuan.Zhang@amd.com
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

On Tue, Feb 10, 2026 at 5:07=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> v3 - lock both VM and WPTR BO (Christian)
> v2 - get a reference (amdgpu_bo_ref(wptr_obj->obj)) before
>      amdgpu_bo_unreserve() to avoid use-after-free issue
>
> remove amdgpu_userq_map_gtt_bo_to_gart() and move its calls
> into amdgpu_userq_create_wptr_mapping() to eliminate duplicated
> calls.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

+ Jesse

This is a nice clean up regardless of the rest of the series.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
I think patches 8, 9 can land now.  It would be nice to rework patch
11 to handle doorbell offsets for gfx/compute and sdma and land that
as well.  I think for the rest, we should hold off until we get
alignment with the FW team.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 89 ++++++++---------------
>  1 file changed, 32 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index ebb0d8a9967f..59e593b3bae7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1573,34 +1573,6 @@ int amdgpu_userq_post_reset(struct amdgpu_device *=
adev, bool vram_lost)
>         return r;
>  }
>
> -static int
> -amdgpu_userq_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgp=
u_bo *bo)
> -{
> -       int ret;
> -
> -       ret =3D amdgpu_bo_reserve(bo, true);
> -       if (ret) {
> -               dev_err(adev->dev, "Failed to reserve bo. ret %d\n", ret)=
;
> -               goto err_reserve_bo_failed;
> -       }
> -
> -       ret =3D amdgpu_ttm_alloc_gart(&bo->tbo);
> -       if (ret) {
> -               dev_err(adev->dev, "Failed to bind bo to GART. ret %d\n",=
 ret);
> -               goto err_map_bo_gart_failed;
> -       }
> -
> -       amdgpu_bo_unreserve(bo);
> -       bo =3D amdgpu_bo_ref(bo);
> -
> -       return 0;
> -
> -err_map_bo_gart_failed:
> -       amdgpu_bo_unreserve(bo);
> -err_reserve_bo_failed:
> -       return ret;
> -}
> -
>  int amdgpu_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
>                               struct amdgpu_usermode_queue *queue,
>                               uint64_t wptr)
> @@ -1609,53 +1581,56 @@ int amdgpu_userq_create_wptr_mapping(struct amdgp=
u_userq_mgr *uq_mgr,
>         struct amdgpu_bo_va_mapping *wptr_mapping;
>         struct amdgpu_vm *wptr_vm;
>         struct amdgpu_userq_obj *wptr_obj =3D &queue->wptr_obj;
> +       struct drm_exec exec;
>         int ret;
>
> +       wptr &=3D AMDGPU_GMC_HOLE_MASK;
>         wptr_vm =3D queue->vm;
> -       ret =3D amdgpu_bo_reserve(wptr_vm->root.bo, false);
> -       if (ret)
> -               return ret;
> +       drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
> +       drm_exec_until_all_locked(&exec) {
> +               ret =3D amdgpu_vm_lock_pd(wptr_vm, &exec, 0);
> +               drm_exec_retry_on_contention(&exec);
> +               if (unlikely(ret))
> +                       goto out_unlock;
>
> -       wptr &=3D AMDGPU_GMC_HOLE_MASK;
> -       wptr_mapping =3D amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAG=
E_SHIFT);
> -       amdgpu_bo_unreserve(wptr_vm->root.bo);
> -       if (!wptr_mapping) {
> -               dev_err(adev->dev, "Failed to lookup wptr bo\n");
> -               return -EINVAL;
> +               wptr_mapping =3D amdgpu_vm_bo_lookup_mapping(wptr_vm, wpt=
r >> PAGE_SHIFT);
> +               if (!wptr_mapping) {
> +                       dev_err(adev->dev, "Failed to lookup wptr bo\n");
> +                       goto out_unlock;
> +               }
> +
> +               wptr_obj->obj =3D wptr_mapping->bo_va->base.bo;
> +               ret =3D drm_exec_lock_obj(&exec, &wptr_obj->obj->tbo.base=
);
> +               drm_exec_retry_on_contention(&exec);
> +               if (unlikely(ret))
> +                       goto out_unlock;
>         }
>
> -       wptr_obj->obj =3D wptr_mapping->bo_va->base.bo;
> +       /* Now both VM and WPTR BO are locked */
>         if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
>                 dev_err(adev->dev, "Requested GART mapping for wptr bo la=
rger than one page\n");
> -               return -EINVAL;
> -       }
> -
> -       ret =3D amdgpu_userq_map_gtt_bo_to_gart(adev, wptr_obj->obj);
> -       if (ret) {
> -               dev_err(adev->dev, "Failed to map wptr bo to GART\n");
> -               return ret;
> -       }
> -
> -       ret =3D amdgpu_bo_reserve(wptr_obj->obj, true);
> -       if (ret) {
> -               dev_err(adev->dev, "Failed to reserve wptr bo\n");
> -               return ret;
> +               ret =3D -EINVAL;
> +               goto out_unlock;
>         }
>
>         /* TODO use eviction fence instead of pinning. */
>         ret =3D amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
>         if (ret) {
>                 drm_file_err(uq_mgr->file, "[Usermode queues] Failed to p=
in wptr bo\n");
> -               goto unresv_bo;
> +               goto out_unlock;
>         }
>
> +       ret =3D amdgpu_ttm_alloc_gart(&wptr_obj->obj->tbo);
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to bind bo to GART. ret %d\n",=
 ret);
> +               amdgpu_bo_unpin(wptr_obj->obj);
> +               goto out_unlock;
> +       }
>         queue->wptr_obj.gpu_addr =3D amdgpu_bo_gpu_offset(wptr_obj->obj);
> -       amdgpu_bo_unreserve(wptr_obj->obj);
> -
> -       return 0;
> +       amdgpu_bo_ref(wptr_obj->obj);
>
> -unresv_bo:
> -       amdgpu_bo_unreserve(wptr_obj->obj);
> +out_unlock:
> +       drm_exec_fini(&exec);
>         return ret;
>
>  }
> --
> 2.43.0
>
