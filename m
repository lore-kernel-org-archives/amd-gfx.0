Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025D7CAC5B8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 12:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D83710E066;
	Mon,  6 Oct 2025 12:45:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fgy6aQBP";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72CC010E066
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 12:45:28 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-27eda3a38ceso7480495ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Oct 2025 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759754728; x=1760359528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZp9YmdG33EZIQ0tqCffJwFd8BJY00pMR8uEogDFa1g=;
 b=Fgy6aQBPOkIJ9niE8M3oUN1XXPXuP43mABeSr2f4u/sklPsSDnPqKuFpql3ja5XgLU
 9+SDOICKyBu0bmxXCQxN7ImqVE1hHQf4ZeFcj8+xPbqvP3i1pPURLCve+JGY7li0g2+5
 SRKG8pxmsiJvCipJzo7NAVH9ZTpm5qcROpmJ0JDNojjzXgukggIQNnQLvOQg3RrzsulW
 KoERSbOtXSWL0YdnUuvSoEBAIssVOCGI9VJ0WvQLD6OK0zsiCCzXtLXNN3eQFAHYTyaz
 GIHFeyi4BGj9kW3nN4TQq5vjSBOxRA6+CLnuRfS8zs9EtDTMpXWiBgN2/ivIol21oWme
 PgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759754728; x=1760359528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZp9YmdG33EZIQ0tqCffJwFd8BJY00pMR8uEogDFa1g=;
 b=JHGWKHrD18eK4RmqjWRXJF3znIOJkNFKSqAARYYrgjh3B0Tdzei9INgtXeHQ3DFg5w
 8TNXifTXRGUK9ZujgzruDvnwu73o1moVhYu6OnKtB16tfnLjhiI62u55giyvPLM+b3k8
 I5gEggXVhjjp1pxFPqTZn8y/2gahsPnPY0ZZ66ML71ov7plXDowvnqvyIsfFUX3YacFj
 SyhOLza/yMyJIrAUftxTqFykbFTk7Uqwv4FR+0APgLpXMzigjvwpDdDhlFpNcmpzHVbq
 UnaFNyqMEYFv4v/gEdQw1okG5yoBha8n1Q97rdUSFVX7nl0TNowbhoYTnWqyQfeahH1L
 C/2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP8S4MCkRZd7k8kglJFUJ+GL1P2JUrcaQhyK50krWH5gwiFR/nNbvzjn4G8P7VRlINyvqJrD0f@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0q2ARGSWxYgllUg6yjKYok7Y3H25ojqeg4t++yD1paYITIbxm
 9xhA30YSNM/i4wPhPetMomF1uy1tKEo6SV+SdtpYZ0+GBopJQnz5GQJCJxRlUxPEtWQWdso3KGb
 ZZdkON7MVa9KpxraUnVi7kjeUZ2+ov7elKw==
X-Gm-Gg: ASbGnctG3C1OUG8V6ivZ5e327JVhtd7TUwAMSi7eZ35YkO5ecN7xqGgZ9sWFk5GNaMB
 smuencVOI6d2qod90t0NwibzqDxcK2xngOzcW0iiTu582FsN0m8SdviLlR+6vMIlH2sBbYwmeuE
 sRk2wsswdI+Z+pd98B8sW9gMvRu1aUSJ+rd29DEtPjjpPWhnGCduAN4KwBHl3ox637URwM+YLvY
 2tVZ2TDLwIbZm+0IaWOsM3r8nxFTOLroTcJ/zMHfQ==
X-Google-Smtp-Source: AGHT+IHuqmXgM4sECTI8m8HjMzGaYOOQXX9QHIbbVc+4GLJPjyfVxHyovd7g5Z6C6d+0SeDDVXr//90Gk5WGubxNwm0=
X-Received: by 2002:a17:902:c403:b0:27e:f02a:b280 with SMTP id
 d9443c01a7336-28e9a65bd1cmr78846875ad.5.1759754727619; Mon, 06 Oct 2025
 05:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251006104719.12886-1-christian.koenig@amd.com>
In-Reply-To: <20251006104719.12886-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Oct 2025 08:45:15 -0400
X-Gm-Features: AS18NWDZRZYtX-jyKJeWsQGrVpkRGCCwKwfd3sz3oyRcodjOojbrozQYQMZZD7w
Message-ID: <CADnq5_M8zDgHHqUfXAr8Rmsu9qPGypLgVaPn7CN9bR6=K5=8QQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: partially revert "revert to old status lock
 handling v3"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: alexander.deucher@amd.com, Kenny.Ho@amd.com, amd-gfx@lists.freedesktop.org
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

On Mon, Oct 6, 2025 at 6:47=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The CI systems are pointing out list corruptions, so we still need to
> fix something here.
>
> Keep the asserts, but revert the lock changes for now.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 146 ++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  15 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 +
>  4 files changed, 105 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 3bbe1001fda1..8dc12064da49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -724,12 +724,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev=
, struct drm_exec *exec,
>         struct amdgpu_bo *bo;
>         int ret;
>
> -       spin_lock(&vm->invalidated_lock);
> +       spin_lock(&vm->status_lock);
>         while (!list_empty(&vm->invalidated)) {
>                 bo_va =3D list_first_entry(&vm->invalidated,
>                                          struct amdgpu_bo_va,
>                                          base.vm_status);
> -               spin_unlock(&vm->invalidated_lock);
> +               spin_unlock(&vm->status_lock);
>
>                 bo =3D bo_va->base.bo;
>                 ret =3D drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> @@ -746,9 +746,9 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, =
struct drm_exec *exec,
>                 if (ret)
>                         return ret;
>
> -               spin_lock(&vm->invalidated_lock);
> +               spin_lock(&vm->status_lock);
>         }
> -       spin_unlock(&vm->invalidated_lock);
> +       spin_unlock(&vm->status_lock);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 86c8288c665f..100cb6cc0cff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -153,10 +153,12 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_b=
o_base *vm_bo)
>
>         vm_bo->moved =3D true;
>         amdgpu_vm_assert_locked(vm);
> +       spin_lock(&vm_bo->vm->status_lock);
>         if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
>                 list_move(&vm_bo->vm_status, &vm->evicted);
>         else
>                 list_move_tail(&vm_bo->vm_status, &vm->evicted);
> +       spin_unlock(&vm_bo->vm->status_lock);
>  }
>  /**
>   * amdgpu_vm_bo_moved - vm_bo is moved
> @@ -169,7 +171,9 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_=
base *vm_bo)
>  static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>  {
>         amdgpu_vm_assert_locked(vm_bo->vm);
> +       spin_lock(&vm_bo->vm->status_lock);
>         list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> +       spin_unlock(&vm_bo->vm->status_lock);
>  }
>
>  /**
> @@ -183,7 +187,9 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_ba=
se *vm_bo)
>  static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>  {
>         amdgpu_vm_assert_locked(vm_bo->vm);
> +       spin_lock(&vm_bo->vm->status_lock);
>         list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
> +       spin_unlock(&vm_bo->vm->status_lock);
>         vm_bo->moved =3D false;
>  }
>
> @@ -197,9 +203,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_bas=
e *vm_bo)
>   */
>  static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -       spin_lock(&vm_bo->vm->invalidated_lock);
> +       spin_lock(&vm_bo->vm->status_lock);
>         list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
> -       spin_unlock(&vm_bo->vm->invalidated_lock);
> +       spin_unlock(&vm_bo->vm->status_lock);
>  }
>
>  /**
> @@ -212,9 +218,10 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_v=
m_bo_base *vm_bo)
>   */
>  static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -       amdgpu_vm_assert_locked(vm_bo->vm);
>         vm_bo->moved =3D true;
> +       spin_lock(&vm_bo->vm->status_lock);
>         list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
> +       spin_unlock(&vm_bo->vm->status_lock);
>  }
>
>  /**
> @@ -228,10 +235,13 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu=
_vm_bo_base *vm_bo)
>  static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>  {
>         amdgpu_vm_assert_locked(vm_bo->vm);
> -       if (vm_bo->bo->parent)
> +       if (vm_bo->bo->parent) {
> +               spin_lock(&vm_bo->vm->status_lock);
>                 list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -       else
> +               spin_unlock(&vm_bo->vm->status_lock);
> +       } else {
>                 amdgpu_vm_bo_idle(vm_bo);
> +       }
>  }
>
>  /**
> @@ -245,7 +255,9 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_b=
o_base *vm_bo)
>  static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
>  {
>         amdgpu_vm_assert_locked(vm_bo->vm);
> +       spin_lock(&vm_bo->vm->status_lock);
>         list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> +       spin_unlock(&vm_bo->vm->status_lock);
>  }
>
>  /**
> @@ -259,13 +271,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct=
 amdgpu_vm *vm)
>  {
>         struct amdgpu_vm_bo_base *vm_bo, *tmp;
>
> -       spin_lock(&vm->invalidated_lock);
> +       amdgpu_vm_assert_locked(vm);
> +
> +       spin_lock(&vm->status_lock);
>         list_splice_init(&vm->done, &vm->invalidated);
>         list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
>                 vm_bo->moved =3D true;
> -       spin_unlock(&vm->invalidated_lock);
>
> -       amdgpu_vm_assert_locked(vm);
>         list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
>                 struct amdgpu_bo *bo =3D vm_bo->bo;
>
> @@ -275,13 +287,14 @@ static void amdgpu_vm_bo_reset_state_machine(struct=
 amdgpu_vm *vm)
>                 else if (bo->parent)
>                         list_move(&vm_bo->vm_status, &vm_bo->vm->relocate=
d);
>         }
> +       spin_unlock(&vm->status_lock);
>  }
>
>  /**
>   * amdgpu_vm_update_shared - helper to update shared memory stat
>   * @base: base structure for tracking BO usage in a VM
>   *
> - * Takes the vm stats_lock and updates the shared memory stat. If the ba=
sic
> + * Takes the vm status_lock and updates the shared memory stat. If the b=
asic
>   * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to b=
e called
>   * as well.
>   */
> @@ -294,7 +307,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_=
bo_base *base)
>         bool shared;
>
>         dma_resv_assert_held(bo->tbo.base.resv);
> -       spin_lock(&vm->stats_lock);
> +       spin_lock(&vm->status_lock);
>         shared =3D drm_gem_object_is_shared_for_memory_stats(&bo->tbo.bas=
e);
>         if (base->shared !=3D shared) {
>                 base->shared =3D shared;
> @@ -306,7 +319,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_=
bo_base *base)
>                         vm->stats[bo_memtype].drm.private +=3D size;
>                 }
>         }
> -       spin_unlock(&vm->stats_lock);
> +       spin_unlock(&vm->status_lock);
>  }
>
>  /**
> @@ -331,11 +344,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *b=
o)
>   *        be bo->tbo.resource
>   * @sign: if we should add (+1) or subtract (-1) from the stat
>   *
> - * Caller need to have the vm stats_lock held. Useful for when multiple =
update
> + * Caller need to have the vm status_lock held. Useful for when multiple=
 update
>   * need to happen at the same time.
>   */
>  static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base=
,
> -                                         struct ttm_resource *res, int s=
ign)
> +                           struct ttm_resource *res, int sign)
>  {
>         struct amdgpu_vm *vm =3D base->vm;
>         struct amdgpu_bo *bo =3D base->bo;
> @@ -359,8 +372,7 @@ static void amdgpu_vm_update_stats_locked(struct amdg=
pu_vm_bo_base *base,
>                  */
>                 if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>                         vm->stats[res_memtype].drm.purgeable +=3D size;
> -               if (!(bo->preferred_domains &
> -                     amdgpu_mem_type_to_domain(res_memtype)))
> +               if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(r=
es_memtype)))
>                         vm->stats[bo_memtype].evicted +=3D size;
>         }
>  }
> @@ -379,9 +391,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base =
*base,
>  {
>         struct amdgpu_vm *vm =3D base->vm;
>
> -       spin_lock(&vm->stats_lock);
> +       spin_lock(&vm->status_lock);
>         amdgpu_vm_update_stats_locked(base, res, sign);
> -       spin_unlock(&vm->stats_lock);
> +       spin_unlock(&vm->status_lock);
>  }
>
>  /**
> @@ -407,10 +419,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_bas=
e *base,
>         base->next =3D bo->vm_bo;
>         bo->vm_bo =3D base;
>
> -       spin_lock(&vm->stats_lock);
> +       spin_lock(&vm->status_lock);
>         base->shared =3D drm_gem_object_is_shared_for_memory_stats(&bo->t=
bo.base);
>         amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
> -       spin_unlock(&vm->stats_lock);
> +       spin_unlock(&vm->status_lock);
>
>         if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>                 return;
> @@ -469,10 +481,10 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, =
struct drm_exec *exec,
>         int ret;
>
>         /* We can only trust prev->next while holding the lock */
> -       spin_lock(&vm->invalidated_lock);
> +       spin_lock(&vm->status_lock);
>         while (!list_is_head(prev->next, &vm->done)) {
>                 bo_va =3D list_entry(prev->next, typeof(*bo_va), base.vm_=
status);
> -               spin_unlock(&vm->invalidated_lock);
> +               spin_unlock(&vm->status_lock);
>
>                 bo =3D bo_va->base.bo;
>                 if (bo) {
> @@ -480,10 +492,10 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, =
struct drm_exec *exec,
>                         if (unlikely(ret))
>                                 return ret;
>                 }
> -               spin_lock(&vm->invalidated_lock);
> +               spin_lock(&vm->status_lock);
>                 prev =3D prev->next;
>         }
> -       spin_unlock(&vm->invalidated_lock);
> +       spin_unlock(&vm->status_lock);
>
>         return 0;
>  }
> @@ -579,7 +591,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>                        void *param)
>  {
>         uint64_t new_vm_generation =3D amdgpu_vm_generation(adev, vm);
> -       struct amdgpu_vm_bo_base *bo_base, *tmp;
> +       struct amdgpu_vm_bo_base *bo_base;
>         struct amdgpu_bo *bo;
>         int r;
>
> @@ -592,7 +604,13 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm,
>                         return r;
>         }
>
> -       list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
> +       spin_lock(&vm->status_lock);
> +       while (!list_empty(&vm->evicted)) {
> +               bo_base =3D list_first_entry(&vm->evicted,
> +                                          struct amdgpu_vm_bo_base,
> +                                          vm_status);
> +               spin_unlock(&vm->status_lock);
> +
>                 bo =3D bo_base->bo;
>
>                 r =3D validate(param, bo);
> @@ -605,21 +623,26 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
>                         vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
>                         amdgpu_vm_bo_relocated(bo_base);
>                 }
> +               spin_lock(&vm->status_lock);
>         }
> +       while (ticket && !list_empty(&vm->evicted_user)) {
> +               bo_base =3D list_first_entry(&vm->evicted_user,
> +                                          struct amdgpu_vm_bo_base,
> +                                          vm_status);
> +               spin_unlock(&vm->status_lock);
>
> -       if (ticket) {
> -               list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
> -                                        vm_status) {
> -                       bo =3D bo_base->bo;
> -                       dma_resv_assert_held(bo->tbo.base.resv);
> +               bo =3D bo_base->bo;
> +               dma_resv_assert_held(bo->tbo.base.resv);
>
> -                       r =3D validate(param, bo);
> -                       if (r)
> -                               return r;
> +               r =3D validate(param, bo);
> +               if (r)
> +                       return r;
>
> -                       amdgpu_vm_bo_invalidated(bo_base);
> -               }
> +               amdgpu_vm_bo_invalidated(bo_base);
> +
> +               spin_lock(&vm->status_lock);
>         }
> +       spin_unlock(&vm->status_lock);
>
>         amdgpu_vm_eviction_lock(vm);
>         vm->evicting =3D false;
> @@ -648,7 +671,9 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>         ret =3D !vm->evicting;
>         amdgpu_vm_eviction_unlock(vm);
>
> +       spin_lock(&vm->status_lock);
>         ret &=3D list_empty(&vm->evicted);
> +       spin_unlock(&vm->status_lock);
>
>         spin_lock(&vm->immediate.lock);
>         ret &=3D !vm->immediate.stopped;
> @@ -939,13 +964,18 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *ade=
v,
>                           struct amdgpu_vm *vm, bool immediate)
>  {
>         struct amdgpu_vm_update_params params;
> -       struct amdgpu_vm_bo_base *entry, *tmp;
> +       struct amdgpu_vm_bo_base *entry;
>         bool flush_tlb_needed =3D false;
> +       LIST_HEAD(relocated);
>         int r, idx;
>
>         amdgpu_vm_assert_locked(vm);
>
> -       if (list_empty(&vm->relocated))
> +       spin_lock(&vm->status_lock);
> +       list_splice_init(&vm->relocated, &relocated);
> +       spin_unlock(&vm->status_lock);
> +
> +       if (list_empty(&relocated))
>                 return 0;
>
>         if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -960,7 +990,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>         if (r)
>                 goto error;
>
> -       list_for_each_entry(entry, &vm->relocated, vm_status) {
> +       list_for_each_entry(entry, &relocated, vm_status) {
>                 /* vm_flush_needed after updating moved PDEs */
>                 flush_tlb_needed |=3D entry->moved;
>
> @@ -976,7 +1006,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev=
,
>         if (flush_tlb_needed)
>                 atomic64_inc(&vm->tlb_seq);
>
> -       list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
> +       while (!list_empty(&relocated)) {
> +               entry =3D list_first_entry(&relocated, struct amdgpu_vm_b=
o_base,
> +                                        vm_status);
>                 amdgpu_vm_bo_idle(entry);
>         }
>
> @@ -1202,9 +1234,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm,
>  void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>                           struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>  {
> -       spin_lock(&vm->stats_lock);
> +       spin_lock(&vm->status_lock);
>         memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
> -       spin_unlock(&vm->stats_lock);
> +       spin_unlock(&vm->status_lock);
>  }
>
>  /**
> @@ -1571,24 +1603,29 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *=
adev,
>                            struct amdgpu_vm *vm,
>                            struct ww_acquire_ctx *ticket)
>  {
> -       struct amdgpu_bo_va *bo_va, *tmp;
> +       struct amdgpu_bo_va *bo_va;
>         struct dma_resv *resv;
>         bool clear, unlock;
>         int r;
>
> -       list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) =
{
> +       spin_lock(&vm->status_lock);
> +       while (!list_empty(&vm->moved)) {
> +               bo_va =3D list_first_entry(&vm->moved, struct amdgpu_bo_v=
a,
> +                                        base.vm_status);
> +               spin_unlock(&vm->status_lock);
> +
>                 /* Per VM BOs never need to bo cleared in the page tables=
 */
>                 r =3D amdgpu_vm_bo_update(adev, bo_va, false);
>                 if (r)
>                         return r;
> +               spin_lock(&vm->status_lock);
>         }
>
> -       spin_lock(&vm->invalidated_lock);
>         while (!list_empty(&vm->invalidated)) {
>                 bo_va =3D list_first_entry(&vm->invalidated, struct amdgp=
u_bo_va,
>                                          base.vm_status);
>                 resv =3D bo_va->base.bo->tbo.base.resv;
> -               spin_unlock(&vm->invalidated_lock);
> +               spin_unlock(&vm->status_lock);
>
>                 /* Try to reserve the BO to avoid clearing its ptes */
>                 if (!adev->debug_vm && dma_resv_trylock(resv)) {
> @@ -1620,9 +1657,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ad=
ev,
>                      bo_va->base.bo->tbo.resource->mem_type =3D=3D TTM_PL=
_SYSTEM))
>                         amdgpu_vm_bo_evicted_user(&bo_va->base);
>
> -               spin_lock(&vm->invalidated_lock);
> +               spin_lock(&vm->status_lock);
>         }
> -       spin_unlock(&vm->invalidated_lock);
> +       spin_unlock(&vm->status_lock);
>
>         return 0;
>  }
> @@ -2151,9 +2188,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>                 }
>         }
>
> -       spin_lock(&vm->invalidated_lock);
> +       spin_lock(&vm->status_lock);
>         list_del(&bo_va->base.vm_status);
> -       spin_unlock(&vm->invalidated_lock);
> +       spin_unlock(&vm->status_lock);
>
>         list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>                 list_del(&mapping->list);
> @@ -2261,10 +2298,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, stru=
ct ttm_resource *new_mem,
>         for (bo_base =3D bo->vm_bo; bo_base; bo_base =3D bo_base->next) {
>                 struct amdgpu_vm *vm =3D bo_base->vm;
>
> -               spin_lock(&vm->stats_lock);
> +               spin_lock(&vm->status_lock);
>                 amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, =
-1);
>                 amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
> -               spin_unlock(&vm->stats_lock);
> +               spin_unlock(&vm->status_lock);
>         }
>
>         amdgpu_vm_bo_invalidate(bo, evicted);
> @@ -2532,12 +2569,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>         INIT_LIST_HEAD(&vm->relocated);
>         INIT_LIST_HEAD(&vm->moved);
>         INIT_LIST_HEAD(&vm->idle);
> -       spin_lock_init(&vm->invalidated_lock);
>         INIT_LIST_HEAD(&vm->invalidated);
> +       spin_lock_init(&vm->status_lock);
>         INIT_LIST_HEAD(&vm->freed);
>         INIT_LIST_HEAD(&vm->done);
>         INIT_KFIFO(vm->faults);
> -       spin_lock_init(&vm->stats_lock);
>
>         r =3D amdgpu_vm_init_entities(adev, vm);
>         if (r)
> @@ -3013,6 +3049,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm=
, struct seq_file *m)
>
>         amdgpu_vm_assert_locked(vm);
>
> +       spin_lock(&vm->status_lock);
>         seq_puts(m, "\tIdle BOs:\n");
>         list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>                 if (!bo_va->base.bo)
> @@ -3050,13 +3087,11 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *=
vm, struct seq_file *m)
>         id =3D 0;
>
>         seq_puts(m, "\tInvalidated BOs:\n");
> -       spin_lock(&vm->invalidated_lock);
>         list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_st=
atus) {
>                 if (!bo_va->base.bo)
>                         continue;
>                 total_invalidated +=3D amdgpu_bo_print_info(id++, bo_va->=
base.bo, m);
>         }
> -       spin_unlock(&vm->invalidated_lock);
>         total_invalidated_objs =3D id;
>         id =3D 0;
>
> @@ -3066,6 +3101,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm=
, struct seq_file *m)
>                         continue;
>                 total_done +=3D amdgpu_bo_print_info(id++, bo_va->base.bo=
, m);
>         }
> +       spin_unlock(&vm->status_lock);
>         total_done_objs =3D id;
>
>         seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", to=
tal_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 556d0483c6bc..77207f4e448e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -203,11 +203,11 @@ struct amdgpu_vm_bo_base {
>         /* protected by bo being reserved */
>         struct amdgpu_vm_bo_base        *next;
>
> -       /* protected by vm reservation and invalidated_lock */
> +       /* protected by vm status_lock */
>         struct list_head                vm_status;
>
>         /* if the bo is counted as shared in mem stats
> -        * protected by vm BO being reserved */
> +        * protected by vm status_lock */
>         bool                            shared;
>
>         /* protected by the BO being reserved */
> @@ -343,8 +343,10 @@ struct amdgpu_vm {
>         bool                    evicting;
>         unsigned int            saved_flags;
>
> -       /* Memory statistics for this vm, protected by stats_lock */
> -       spinlock_t              stats_lock;
> +       /* Lock to protect vm_bo add/del/move on all lists of vm */
> +       spinlock_t              status_lock;
> +
> +       /* Memory statistics for this vm, protected by status_lock */
>         struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>
>         /*
> @@ -352,8 +354,6 @@ struct amdgpu_vm {
>          * PDs, PTs or per VM BOs. The state transits are:
>          *
>          * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
> -        *
> -        * Lists are protected by the root PD dma_resv lock.
>          */
>
>         /* Per-VM and PT BOs who needs a validation */
> @@ -374,10 +374,7 @@ struct amdgpu_vm {
>          * state transits are:
>          *
>          * evicted_user or invalidated -> done
> -        *
> -        * Lists are protected by the invalidated_lock.
>          */
> -       spinlock_t              invalidated_lock;
>
>         /* BOs for user mode queues that need a validation */
>         struct list_head        evicted_user;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_pt.c
> index f57c48b74274..30022123b0bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -541,7 +541,9 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_bas=
e *entry)
>         entry->bo->vm_bo =3D NULL;
>         ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>
> +       spin_lock(&entry->vm->status_lock);
>         list_del(&entry->vm_status);
> +       spin_unlock(&entry->vm->status_lock);
>         amdgpu_bo_unref(&entry->bo);
>  }
>
> @@ -585,6 +587,7 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_up=
date_params *params,
>         struct amdgpu_vm_pt_cursor seek;
>         struct amdgpu_vm_bo_base *entry;
>
> +       spin_lock(&params->vm->status_lock);
>         for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, =
seek, entry) {
>                 if (entry && entry->bo)
>                         list_move(&entry->vm_status, &params->tlb_flush_w=
aitlist);
> @@ -592,6 +595,7 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_up=
date_params *params,
>
>         /* enter start node now */
>         list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist)=
;
> +       spin_unlock(&params->vm->status_lock);
>  }
>
>  /**
> --
> 2.43.0
>
