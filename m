Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D447C79FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 19:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D590110E1FB;
	Wed,  9 Sep 2026 19:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NlnWOMEn";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE5EB10E1FB
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 19:23:48 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396673bd283so1080744a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 12:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788981828; cv=none;
 d=google.com; s=arc-20260327;
 b=d/Yn8QQkgXfLlS3W+l5HGnfyvW8xlYfLz9n7DrpQ6B2LFYJdd+sn3Fm5M1dL+FvW2u
 5EcgKlqjcos8TQ1abWpFdUSlBrXXdRzIDK+Ukme9uVikeD66+EIZa+j4jlRDUv1Qk+K+
 UBoAPED+wjQCZrZiGAMP0M8O3hENOemZ1yqEYpsggnxHrOFXTclcNvXniFEV1Lwn08/t
 UkX2ww1KTw+1snnHp6QurX/lt/R1/+DPA/Ez09x01AoZJ4UnV4dkEqtVYQZ4K+Qe6a+e
 6O8j79bs/ooCR+R/9ddjy58VAVXXAfRQlzamJEKsqS5zUH5rzCdqsB1ol9JtNFNWNHb3
 52Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BtYBlEhPDmtKlAbALGQ5ZO/WbDmkQ55k6tlaCY5D0Z8=;
 fh=yLGtBc/2Y1R3mqMVjyDzfKiTtDMdAauZFaHGaNwo5js=;
 b=cuLfiE4Z+sm6xUQIdR9MXHYOG4ggiDXJe9qbqxtS4yAL+L9R1eVbdcElmyuoZ+MjoJ
 apQD8wB9AqkM+GHYzwAraubt+jf/tYb9Gcha4Sgp7TORJEJ8Ibut4kFyjBZ80RnWphgo
 O9P50hoMzLaBvpo3aTyHEpd8ebjb12bfjuHTl0E0DDbNZ1q/sSNhA4hdvD0/Fwk9SxrU
 PjPa05uirGQrDjJ32ORD79OMTx8uQfs6PMf6w2P7WDM4IeH3skEWOYX7eQr5Kzeth5Tp
 UELooPHhZEiA/Yy6/d1ltEBpGW+yEKXOgD1UlqAZBmukkUGXqqWEBf7f9gf0hcLKvLz9
 dVsw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788981828; x=1789586628; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BtYBlEhPDmtKlAbALGQ5ZO/WbDmkQ55k6tlaCY5D0Z8=;
 b=NlnWOMEnwcouLd4ifGeQ+Y8Y/u3fCXTJlRrYOuDvFr+TN/wLg2pTau9Twj04IUYfue
 G2yyzZU0vLjcsamrwIVn4RmuMeBF4RbwsyYEvo6ZeDD8SBsa+r/82JGoquExNx+xoHJt
 XucE086DQGfXc+Rv7kfaScOeKNxmKNd/lfaahwsZSnTEOxo/Y94loqun93FuwEoeUlcc
 ZskRFIuzTUF1e7q4OHwdpu/icmndwvblRU5QX+rwFGmPU+osvv909XVTuED7RhXCnRds
 ZIhzpOfR6AkiZrGauwwWd878AcoL1rmeS2jQo8iMEGhge0UCYiA8F8aJmCbe8BpeS4F5
 x+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788981828; x=1789586628;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BtYBlEhPDmtKlAbALGQ5ZO/WbDmkQ55k6tlaCY5D0Z8=;
 b=nmEnV2Wyeqao4fwEwunm60U9Aq/VhbcfsGFw2yrOy2BczCb9gMUTDrzN5IbiP07m4w
 b4tP3jlI4QF3sexa3M/fbujHLTcsQtlHJ+oCdo70aRYtoFSxqPzU2g1EePrFSiB6Z7he
 3QwDWnbPhZrBSVpwl8Ku+o75M1IbCIgFFjoNkVj8Gsz+a950qBVsnAHPHHrQoQuINMrJ
 O4I/OMoNF5/yGCnaCxaQx4ZewGHFb/EOqHXX1U6wZ5CqarfZI1eZe/+E9SL1XK9bkg9M
 wF0t6KtVm5aUntAZA/f058Ff5894xAhuBoGiTm6IeK9mGNYyw5rUVDe2Druk1EVUQQqg
 1OQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwywq0B48mCkWea/F2w+eVauAS/NqiHyOya8kXPFRteQOXDazUW5xMz0ZIxyHtKq8TfAoQKQ4nL@lists.freedesktop.org
X-Gm-Message-State: AFuF++nyo/0ScFf4suzFd88/q83zTm3wROhnRfG9wrrZ+aVWvYrxSFnx
 FzJRWNvtrYSgVcHWwj7SgEHKuUDSrqu0p1bqDinBw4NF0ByVW6o7xNyIz7pOMzjueek9/24UeA3
 AxOiO11FXaD16+oKoV1LVBW0YrMfIns0=
X-Gm-Gg: AYBFou2adhAjw1zGmo5AtRjQJNjv7Gb78ILc9YqSfUd0+MZA+33wzOP78ZQhQe3DjfJ
 JSyTLwhnYB+FMnpCzovNtmDqvztDl9MbdqjwKIOW+y9Bkn3jEvgUjIeJS+gXDWwcsmVFkG6wtTb
 l03dRNEDZROtXDOXmXDPIiYvx1daIlvSL1bs4ZZnE7HSEmwjEXVBudfjifGQPe25r+Uid5KCu47
 jsf+vFQIUVsxO9ZttlAek6VMY8u07l/Gm5jdTFj3hCtXXr7h4qIbhP9+rbHQq+KsmG/xt/KLX4W
 KSMijSVlHgX2y7C5+HQboqt9ANGCUZVMKzrTsOwtVsHKBw63a3XjWHdlgc7aAd1mEoUushFGbNx
 0l82Rw1MHEKTDCmjBPpJ7+k4WGBwNSFKp3nSgMv8SrA==
X-Received: by 2002:a17:90b:3ccf:b0:39b:34ef:3b24 with SMTP id
 98e67ed59e1d1-39b3d5aaa70mr28242460a91.1.1788981828317; Wed, 09 Sep 2026
 12:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Sep 2026 15:23:36 -0400
X-Gm-Features: AcwNN1XqtGHrTgu3xMudCq7LQSJEAWFoPLGLHi4dqOQ8hEnhM9S4CqR2FYgmcLY
Message-ID: <CADnq5_Ns1y7ZCAOmdVafVeu2KLNxObLDdhb=JzDp4daaUqtN4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap
 handler infrastructure
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Lijo Lazar <lijo.lazar@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
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

On Sat, Sep 5, 2026 at 4:55=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program

MES doesn't own the kernel queue VMIDs.  The kernel driver does.  MES
assigns VMIDs dynamically for user queues, but for kernel queues, the
kernel assigns the vmids.

> SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queues
> via ADD_QUEUE with map_legacy_kq=3D1 but does not set trap handler state.
> On GFX10 and earlier HWS-based hardware, the driver programs trap
> registers via SRBM select for KFD queues but no equivalent exists for
> driver-managed kernel queue VMIDs.
>
> Add a vmhub callback program_kernel_trap_vmids() so each gfxhub version
> can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
> device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
> address AMDGPU_VA_RESERVED_TRAP_START =E2=80=94 each VM maps its own kq_t=
ma_bo
> there, so per-VM isolation is handled entirely by page tables without
> needing to reprogram the register per job or per submission.
>
> The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
> (parallel to page table allocation) and mapped read-only into the GPU VM
> at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the second-level
> handler address into it via kq_tma_map when userspace calls SET_L2_TRAP.
> The first-level CWSR handler reads this address to chain to the
> second-level handler when a shader exception fires.
>
> This design is:
>   - Per-VM BO (not device-level) =E2=80=94 same model as page tables
>   - Fixed VA in each VM's address space =E2=80=94 same VA, different phys=
ical BO
>   - Read-only from GPU =E2=80=94 kernel CPU updates it via CPU mapping
>   - Treat allocation/free lifecycle identical to page tables
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alexander Deucher <alexander.deucher@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
>  5 files changed, 110 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index 3ca187f5ade8..5624a5ab5c62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
>         void (*print_l2_protection_fault_status)(struct amdgpu_device *ad=
ev,
>                                                  uint32_t status);
>         uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush_=
type);
> +       void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
>  };
>
>  struct amdgpu_vmhub {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_trap.c
> index 623cac6781be..e913488ca3fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>
>         amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
>         adev->trap_info =3D no_free_ptr(trap_info);
> +       amdgpu_trap_program_kernel_vmids(adev);
>
>         return 0;
>  }
> @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
>         adev->trap_info =3D NULL;
>  }
>
> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];
> +
> +       if (!amdgpu_trap_is_enabled(adev))
> +               return;
> +       if (!hub->vmhub_funcs || !hub->vmhub_funcs->program_kernel_trap_v=
mids)
> +               return;
> +
> +       hub->vmhub_funcs->program_kernel_trap_vmids(adev);
> +}
> +
> +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
> +                               struct amdgpu_vm *vm)
> +{
> +       void *cpu_addr;
> +       uint64_t va;
> +       int r;
> +
> +       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +
> +       r =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SI=
ZE,
> +                                   AMDGPU_GEM_DOMAIN_GTT, &vm->kq_tma_bo=
,
> +                                   NULL, &cpu_addr);
> +       if (r)
> +               return r;
> +
> +       if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
> +               iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
> +                                         (void __iomem *)cpu_addr);
> +       else
> +               iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);

Are you planning to copy the first level trap handler to the buffer
later?  Why not just initialize it here?

Alex

> +
> +       vm->kq_tma_va =3D amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
> +       if (!vm->kq_tma_va) {
> +               r =3D -ENOMEM;
> +               goto err_free_bo;
> +       }
> +
> +       va =3D AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK=
;
> +       r =3D amdgpu_vm_bo_map(adev, vm->kq_tma_va, va, 0,
> +                            AMDGPU_GPU_PAGE_SIZE,
> +                            AMDGPU_VM_PAGE_READABLE);
> +       if (r)
> +               goto err_del_va;
> +
> +       r =3D amdgpu_vm_bo_update(adev, vm->kq_tma_va, false);
> +       if (r)
> +               goto err_del_va;
> +
> +       return 0;
> +
> +err_del_va:
> +       amdgpu_vm_bo_del(adev, vm->kq_tma_va);
> +       vm->kq_tma_va =3D NULL;
> +err_free_bo:
> +       amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
> +       return r;
> +}
> +
> +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
> +                               struct amdgpu_vm *vm)
> +{
> +       uint64_t va;
> +
> +       if (!vm->kq_tma_bo)
> +               return;
> +
> +       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +
> +       if (vm->kq_tma_va) {
> +               va =3D AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_H=
OLE_MASK;
> +               amdgpu_vm_bo_unmap(adev, vm->kq_tma_va, va);
> +               amdgpu_vm_bo_del(adev, vm->kq_tma_va);
> +               vm->kq_tma_va =3D NULL;
> +       }
> +       amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
> +}
> +
>  static int amdgpu_trap_map_region(struct amdgpu_device *adev,
>                                   struct amdgpu_vm *vm,
>                                   struct amdgpu_trap_obj *cwsr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_trap.h
> index 7f83174a4742..9be5035abd1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> @@ -155,4 +155,11 @@ int amdgpu_trap_set_trap_debug_flag(struct amdgpu_de=
vice *adev,
>                                     struct amdgpu_trap_obj *cwsr_obj,
>                                     bool enabled);
>
> +/* Kernel queue trap handler =E2=80=94 per-VM TMA and register programmi=
ng */
> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev);
> +int  amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
> +                                struct amdgpu_vm *vm);
> +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
> +                               struct amdgpu_vm *vm);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index de3ef9ce2234..f5e228d4bfb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2640,6 +2640,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
>         if (r)
>                 goto error_free_root;
>
> +       if (amdgpu_trap_is_enabled(adev)) {
> +               r =3D amdgpu_trap_vm_kq_tma_alloc(adev, vm);
> +               if (r)
> +                       goto error_free_root;
> +       }
> +
>         r =3D amdgpu_vm_create_task_info(vm);
>         if (r)
>                 dev_dbg(adev->dev, "Failed to create task info for VM\n")=
;
> @@ -2774,6 +2780,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm)
>                 amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
>         }
>
> +       if (vm->kq_tma_bo)
> +               amdgpu_trap_vm_kq_tma_free(adev, vm);
> +
>         amdgpu_vm_pt_free_root(adev, vm);
>         amdgpu_bo_unreserve(root);
>         amdgpu_bo_unref(&root);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index dd825e179979..064f95a83790 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -25,6 +25,7 @@
>  #define __AMDGPU_VM_H__
>
>  #include <linux/idr.h>
> +#include <linux/iosys-map.h>
>  #include <linux/kfifo.h>
>  #include <linux/rbtree.h>
>  #include <drm/gpu_scheduler.h>
> @@ -488,6 +489,18 @@ struct amdgpu_vm {
>
>         /* cached fault info */
>         struct amdgpu_vm_fault_info fault_info;
> +
> +       /*
> +        * Per-VM kernel queue first-level TMA BO.
> +        * Allocated at VM init, freed at VM fini =E2=80=94 same lifecycl=
e as page tables.
> +        * Mapped read-only at AMDGPU_VA_RESERVED_TRAP_START in the GPU V=
M.
> +        * SQ_SHADER_TMA for all kernel VMIDs points to this fixed VA; pe=
r-VM
> +        * isolation is via page tables mapping different physical BOs th=
ere.
> +        * CPU kernel writes second-level handler address via kq_tma_map.
> +        */
> +       struct amdgpu_bo        *kq_tma_bo;
> +       struct amdgpu_bo_va     *kq_tma_va;
> +       struct iosys_map         kq_tma_map;
>  };
>
>  struct amdgpu_vm_manager {
> --
> 2.34.1
>
