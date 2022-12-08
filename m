Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A7DC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 17:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC1A410E1C8;
	Thu,  8 Dec 2022 17:37:04 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B397810E1C8
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 17:37:01 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id v70so2107409oie.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Dec 2022 09:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOKmQgtoNy6eTWB7tvXGadXipgDDyIdmbaqYhv7iBCQ=;
 b=kYFsRdM0l8A1AaEkFscWFOEIFJBVwf5P593XQQvIrtjmnE9XgMt9zd+6bsdZIYdgP8
 iL+UoHe0biAgL4PAyls9Nz6oXOJjHOWiwb9Y0XnXpvtNkaRO+oPPuCM8OmPfI5oJUPlm
 +RZNWtDCzLBhxSoAdkQmwEilH5xrVs6cr7gLqk2ufq7kbVP+P+PTncppnNVQsGMG2b3D
 OEgfKSmhOTNy7Zaq51adOBWiMXSz2CvXbrd8nPDALS0Y6hckJCFQ0vwBHytqcWrkfTVX
 NAs9bTWfaJWwVT8xJ4AYfsiAZlkzXYM7izEHfhDcyXuf73dGlfh+xER/NN08yQ4heF1i
 O+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UOKmQgtoNy6eTWB7tvXGadXipgDDyIdmbaqYhv7iBCQ=;
 b=jglqsuBgSfhBTiWgZtLwyLdrHNWG5u1TxblKoFNeJcsdd1tMNKn5vSekzUvBggWyi+
 ZNf8rfPqMP0d+ogaUJC3JCGmq66j8ZrwBlH5FYuSOJQo6nX/bWAyYHb102k3XR0WGo+v
 kepBxJqoRXNDpZzlc+U0W9SqRr/w4dgM/CPb5g0OhE+UmYF7gLuznSPiBfeL2/q2J9Ky
 zLnP5XE0uKO4Qk8iefsBZV5tWQFSZK6Oce9KdS7qfbIoFcW5Ut8fd8H+GxZBLI5rDfPg
 kznC4Ibu2n8gsEEFxMHRcrc2PPPOmwuw41MXlDs7QWAkAQT1ljhG3+M5FJ1ZrE7cWxQ6
 2jzg==
X-Gm-Message-State: ANoB5pnA3w70rxKtB7Ri8Q/aB2AXE2x8ZizPzgsTxat9mFSyqVgJNVor
 ZQBmJNCPcR3/qHMpyVkQQ5EepR/k+aRCxpWwpAjxTIlb
X-Google-Smtp-Source: AA0mqf7lCoA3l/XfxT4Cti8EPjcjcJdHdErUWj3fHQPoVsxMpzSu+yPTeazg4D1xIRtYVqutgoI8LUHOfl8U69KdlE0=
X-Received: by 2002:aca:1913:0:b0:35b:f5f7:3ed0 with SMTP id
 l19-20020aca1913000000b0035bf5f73ed0mr12333324oii.46.1670521020884; Thu, 08
 Dec 2022 09:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20221205104333.12536-1-christian.koenig@amd.com>
 <20221205104333.12536-4-christian.koenig@amd.com>
In-Reply-To: <20221205104333.12536-4-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Dec 2022 12:36:49 -0500
Message-ID: <CADnq5_PEqkBws6ZODrnpiL5Tz9BHF+AtovhxyP3BPV3F1NGgXA@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: rework reserved VMID handling
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Dec 5, 2022 at 5:43 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Instead of reserving a VMID for a single process allow that many
> processes use the reserved ID. This allows for proper isolation
> between the processes.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 45 ++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  6 +---
>  3 files changed, 24 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ids.c
> index 7e5aad241295..6481b43ffe25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -279,12 +279,13 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_=
vm *vm,
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         unsigned vmhub =3D ring->funcs->vmhub;
> +       struct amdgpu_vmid_mgr *id_mgr =3D &adev->vm_manager.id_mgr[vmhub=
];
>         uint64_t fence_context =3D adev->fence_context + ring->idx;
>         bool needs_flush =3D vm->use_cpu_for_update;
>         uint64_t updates =3D amdgpu_vm_tlb_seq(vm);
>         int r;
>
> -       *id =3D vm->reserved_vmid[vmhub];
> +       *id =3D id_mgr->reserved;
>         if ((*id)->owner !=3D vm->immediate.fence_context ||
>             !amdgpu_vmid_compatible(*id, job) ||
>             (*id)->flushed_updates < updates ||
> @@ -464,31 +465,27 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device=
 *adev,
>                                struct amdgpu_vm *vm,
>                                unsigned vmhub)
>  {
> -       struct amdgpu_vmid_mgr *id_mgr;
> -       struct amdgpu_vmid *idle;
> -       int r =3D 0;
> +       struct amdgpu_vmid_mgr *id_mgr =3D &adev->vm_manager.id_mgr[vmhub=
];
>
> -       id_mgr =3D &adev->vm_manager.id_mgr[vmhub];
>         mutex_lock(&id_mgr->lock);
>         if (vm->reserved_vmid[vmhub])
>                 goto unlock;
> -       if (atomic_inc_return(&id_mgr->reserved_vmid_num) >
> -           AMDGPU_VM_MAX_RESERVED_VMID) {
> -               DRM_ERROR("Over limitation of reserved vmid\n");
> -               atomic_dec(&id_mgr->reserved_vmid_num);
> -               r =3D -EINVAL;
> -               goto unlock;
> +
> +       ++id_mgr->reserved_use_count;
> +       if (!id_mgr->reserved) {
> +               struct amdgpu_vmid *id;
> +
> +               id =3D list_first_entry(&id_mgr->ids_lru, struct amdgpu_v=
mid,
> +                                     list);
> +               /* Remove from normal round robin handling */
> +               list_del_init(&id->list);
> +               id_mgr->reserved =3D id;
>         }
> -       /* Select the first entry VMID */
> -       idle =3D list_first_entry(&id_mgr->ids_lru, struct amdgpu_vmid, l=
ist);
> -       list_del_init(&idle->list);
> -       vm->reserved_vmid[vmhub] =3D idle;
> -       mutex_unlock(&id_mgr->lock);
> +       vm->reserved_vmid[vmhub] =3D true;
>
> -       return 0;
>  unlock:
>         mutex_unlock(&id_mgr->lock);
> -       return r;
> +       return 0;
>  }
>
>  void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
> @@ -498,12 +495,12 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device=
 *adev,
>         struct amdgpu_vmid_mgr *id_mgr =3D &adev->vm_manager.id_mgr[vmhub=
];
>
>         mutex_lock(&id_mgr->lock);
> -       if (vm->reserved_vmid[vmhub]) {
> -               list_add(&vm->reserved_vmid[vmhub]->list,
> -                       &id_mgr->ids_lru);
> -               vm->reserved_vmid[vmhub] =3D NULL;
> -               atomic_dec(&id_mgr->reserved_vmid_num);
> +       if (vm->reserved_vmid[vmhub] &&
> +           !--id_mgr->reserved_use_count) {
> +               /* give the reserved ID back to normal round robin */
> +               list_add(&id_mgr->reserved->list, &id_mgr->ids_lru);
>         }
> +       vm->reserved_vmid[vmhub] =3D false;
>         mutex_unlock(&id_mgr->lock);
>  }
>
> @@ -570,7 +567,7 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>
>                 mutex_init(&id_mgr->lock);
>                 INIT_LIST_HEAD(&id_mgr->ids_lru);
> -               atomic_set(&id_mgr->reserved_vmid_num, 0);
> +               id_mgr->reserved_use_count =3D 0;
>
>                 /* manage only VMIDs not used by KFD */
>                 id_mgr->num_ids =3D adev->vm_manager.first_kfd_vmid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ids.h
> index 06c8a0034fa5..c573a8ffff47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -67,7 +67,8 @@ struct amdgpu_vmid_mgr {
>         unsigned                num_ids;
>         struct list_head        ids_lru;
>         struct amdgpu_vmid      ids[AMDGPU_NUM_VMID];
> -       atomic_t                reserved_vmid_num;
> +       struct amdgpu_vmid      *reserved;
> +       unsigned int            reserved_use_count;
>  };
>
>  int amdgpu_pasid_alloc(unsigned int bits);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 6546e786bf00..094bb4807303 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -119,9 +119,6 @@ struct amdgpu_bo_vm;
>  /* Reserve 2MB at top/bottom of address space for kernel use */
>  #define AMDGPU_VA_RESERVED_SIZE                        (2ULL << 20)
>
> -/* max vmids dedicated for process */
> -#define AMDGPU_VM_MAX_RESERVED_VMID    1
> -
>  /* See vm_update_mode */
>  #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
>  #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
> @@ -298,8 +295,7 @@ struct amdgpu_vm {
>         struct dma_fence        *last_unlocked;
>
>         unsigned int            pasid;
> -       /* dedicated to vm */
> -       struct amdgpu_vmid      *reserved_vmid[AMDGPU_MAX_VMHUBS];
> +       bool                    reserved_vmid[AMDGPU_MAX_VMHUBS];
>
>         /* Flag to indicate if VM tables are updated by CPU or GPU (SDMA)=
 */
>         bool                                    use_cpu_for_update;
> --
> 2.34.1
>
