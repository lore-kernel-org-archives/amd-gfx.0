Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B77BC79FB7
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 20:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1016D10F279;
	Wed,  9 Sep 2026 20:42:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f3qOQ0V3";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D2010F279
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 20:42:51 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 ada2fe7eead31-78830b3dfdcso150706137.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 13:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788986571; cv=none;
 d=google.com; s=arc-20260327;
 b=GrKMTLElPCEPvNGmlhbmEo1Ds930wR+w6RJ3G5hkK/rTW6wV2VZzMVArpfnpAGNvxe
 nlFzCqDRa2WwjQBsw9d81kahlPxfzTWcXFLH2TJ5wB2ce4TiarD6rfYbgUQLjiCx5pJp
 r+02nPWcJnb7pO8NqUt3cRU8uuqgaBgaYHshjHNExueFOp/cmpy+PN682WRyBBie8soV
 KTaOrNC8zWBwh4U/p7SWnVFSWwIaqRLoDc233MDIdIZOdGhfaOgrYMDnwRm6EpztL+r3
 uOGExAyF2IXyep0DOcsxqaVLxlm8pzaMz4P+K8RLdKWkF5OHDx3lIrYYIbzy3YbAaQ57
 1Ssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XQiMxqsgbFuHHXATngJfkFcIxKZAYqsytJJjPRKU+ps=;
 fh=tXPWZHFfA17O+gDhXewP3TF8xolXIlpdYaNjiWScBTM=;
 b=jCecGTsY2E8P9UfodcWCeda3gzwvTUnluuf4jd34ikdBcbYrpIp4gYXMPuB8I8Bq9K
 td8d3KENcZsHe2Kg0ny6A0Aqs/A+c+3OCL42yZGX8HgVAW9LiwiGIHgXR+UTNyWxnmfw
 NFIh+hTHrsCHVfSmF0QhAWZw0dHhvN8Gj32who2IfRveCj+zWJKCP0FwcXyko5asxt5P
 jyDLEk0CCI9bAoExSjUWk8GZYUxw71NupmXN33PfQbiDcwM0Mg/nvk3R5E8K+dRUCTDr
 h+nYhEyC7rSCyGJjrJmMfCQnyjddWra6r14JJHJxnrVQcE7i6fJD9Z3XFfAIkhKvdRQR
 m36w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788986571; x=1789591371; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XQiMxqsgbFuHHXATngJfkFcIxKZAYqsytJJjPRKU+ps=;
 b=f3qOQ0V3Ci6KcmfDwtd+Q2Du8p7I18hr7que5T6g+cIY/9MvKM89Y5nYJbHajD8TMv
 dqkVXZtkRJGcJ/41/EekRBiw7ObkFV81c5O7YM2dy86h9oevh4RRe229EHB7tZ7w6s91
 psIQnqO6yAS3FAfaITdo+LhCNRQRMHXEFVxRnHaQ2v/KACoOSE/cUM+9ieD4ciq6+NXz
 1EuUIErb5B8q3+W8ZtGUBaNITAXtMi3A2oXBV9WkwY1rlXtB0yERlCTtJB2Z81pRjLNC
 3tBjKYaL7PrSzr9ip0ThsapUoc+WaDD2EpPKUK4sDzNMnRrJpVD/QEA0Mhz8Kgen3kIX
 bgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788986571; x=1789591371;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XQiMxqsgbFuHHXATngJfkFcIxKZAYqsytJJjPRKU+ps=;
 b=aRikcSfmiTbuf6AGKmb5Q2MCNnOHtk5s6BmpjkqfIuxd9LCkrQ2ALtTvHpCVm1qF5f
 CvcdEYm9tXbcBbfuh4v/YP2WbKkHi+VBkhuW/UdfO5tfU9Sbpaf+P//KmelFl7EmVCfT
 X+zzujEkXJ59qPPONjWtphG1bogmaFiHRWQfUDgutdx8XOq657ON+1szQU0pNsq6dBKz
 uVeI4d9W49pmWnW+Fi5ixsBiLeXkZe7rGTAZ/Uxwdaf6F8xTsqrORWtMv/MjzbJjYto5
 KkUeq8aRKnHU7dzR8t/BY29wbYJfUy7beNP5EebEYCTKl3kFUHJBYS/ssMSo7CyOemmX
 DhUg==
X-Forwarded-Encrypted: i=1;
 AKwUvByZrlPlU07eOQQcfTg6KN4tREUX+0klkDJKf2C+ayFI6EevZ6VQ88FCeqFnViOiDiVzLhi62+0W@lists.freedesktop.org
X-Gm-Message-State: AFuF++m3y5vKkmEAEzQtwtR/X1+ozw40P+ktmuJ5MWZyAAEBQs0dLYA8
 mQHLYFDYwuU66cFMWQrDS+CXR32/wL2BF45h/rPhRXJuRyEPn/UsCjmnhqWcP+J+XfBZELvFKgp
 VqiBxA9UASzP60n+pE7LK3CRLKZDldk4=
X-Gm-Gg: AYBFou3nJ5xzmGXIAhimso3MjIrVC7YJLE/xtCKO3TIPy5ZYuav6o4S6y00wzfHIvLm
 biCZFoMv6A82nAw07+cXCEAhZfct9mjEU9lNGiK/arcuNTPZKlf4dtVsF2vi61dvAeyG/hbxTn+
 R7042xnSCLRG5IDReObHoUxIoja4H8o6b4qOtOEledKW+rs0iz4ak9YuBmsMVfbmVECDrzzmsC8
 5yIZVfPBlDHy0uCMgjY4FDXFSLvo6fWfv/rzxoBl2crgWydZovSGgRel6hx/XtG5/SU6pfS0yPR
 TyFz8eyRrkUY/sbSuHEaDSiLSwQZVnSmJ99NyabyTge6Vh6bm0GXvI3V5rzzuPXZuuLS2oePrXZ
 rKHNso3joL0eCpBm+PnwNV+heWzkBl/wxEEKXofwFqJY=
X-Received: by 2002:a05:6102:91b:b0:786:c254:b7f6 with SMTP id
 ada2fe7eead31-78a6082a131mr4995200137.0.1788986570667; Wed, 09 Sep 2026
 13:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Sep 2026 16:42:37 -0400
X-Gm-Features: AcwNN1VsSfCSkZ3EtNiDW5TcSLloR5E1EOFK964184c_jDIylMgHkBc4fXX33yM
Message-ID: <CADnq5_PHEQzUVTqJYzO3mALs9LfK9cAUMQtgi0JEzGvFSZk7Eg@mail.gmail.com>
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

These should be the same for both user and kernel queues.  The only
difference is who manages the vmids (driver vs MES).  They are per
vmid so it doesn't matter whether it's a kernel queue or user queue.

Alex

>  };
>
>  struct amdgpu_vm_manager {
> --
> 2.34.1
>
