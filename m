Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B84FC79FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 20:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035FD10EBC0;
	Wed,  9 Sep 2026 20:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gaZkHrge";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112A610EBC0
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 20:39:26 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 ada2fe7eead31-781d5f20ed1so115761137.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 13:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788986365; cv=none;
 d=google.com; s=arc-20260327;
 b=LN8EHgTMMmOtGwAFXnfg5WHBCeFqFPyoADfthAcJY6WBrHnEuF82JujT4adxkXkkK3
 VDmHlWT7ndGeoqnS5esAuJPYu8kOvqXDgHTeD6uI9eZ9008lG0U4/DE0JL3dZxe8rI/l
 oFM47Sa8QoMe9eAEOHxgCkm9IAYr0LCGUQKGwz+CRiDkX5d48ZwjVBOCGcQLbHV8AbP1
 3DC0lmt8E/cwIjmnP5Vyg9vbvs8Nxmg09ue+Th9UYcJRKV1OlaGqW0J0qGLnzmBuLjXK
 CcHuoQmr8I4QWCmVWWO/3KwABliryspMXm+LhNFN+zTSfVoOnfTk6ZoLen2A3bIJI7aD
 0bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Mws7yeqDEI391cI8MtGChbnOVUx1ayOb28OxGup/NOk=;
 fh=4P9x7y4MJH3N/TAzoORNpb2m6AX4ZnnvrBp038kMIIE=;
 b=lFRqMTzaQyX+W3aqU44yTsVHWVw9AUvTHzR77ifz/yvDELmutMi0DGEAlX/UfSmfnH
 s0bxO7cC22fMU19qpm43+Yw9mQbDhksOWJc5JYFnapxjiVuXBDSbPFxZidkSY7XvTrz0
 Upn5AJoU09n3OwSO37bTT6IZEswEhTfVBcZrl7CnIfyxpWzHmJoT2GN3RL6B7C+2aYhO
 t8sUlcTI5wdN/GKMR1N/Mq8slsWx0zmI3F0DHOpT8SwvHXltBbTyV3G6OA1IS56FtcKl
 Eb6/UT6x1eP58hbiqok7dsdM5HwEBYKMCGUaUdSI6YCEtaF0Br0tcdgE7iyLudoif1Su
 1kuA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788986365; x=1789591165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mws7yeqDEI391cI8MtGChbnOVUx1ayOb28OxGup/NOk=;
 b=gaZkHrgefGrY+TcJs+OgdD5tQohqysQDhwWiNWdHfy5wqVL6r4yEia8zUpw04Wt9gx
 KSy2S4nOZwVQFeRF3BzIoIWvuo5tqCCujOxu6OeH1cLdCr4cTXrt8749nH3rjmwzdjXF
 JTErkyb+t3dqJE+oo+WKfKpJR/OklUStRKrWAr5PoF9R6feqC6v8j2EHxefj1JjIiWfI
 RjGBwlXEFuSJQcB9vu/8Z1pC2TQPVha96Fbq71qoHgHBSJHVeLAfAepfSW4mgmejqOsS
 I7mzbPvl+lVmhMCdMCWMtzAO08YDkzaB9J6iH0N9C4/YLnyWIbSn886MxG9COt27gsHr
 XPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788986365; x=1789591165;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mws7yeqDEI391cI8MtGChbnOVUx1ayOb28OxGup/NOk=;
 b=Clnh7g2xkaaUpE6CFgdaWTsUs8+wQjrMwfIcQUwTLdZJAYlsPJb0Id9QJwIpEA6jUP
 rjxHn62uncBR5N80y5EQeO9nVQwrdUcoRubD1IFooKB4ppmu4LPveD/VRqAXvvqW6+1o
 Fe8NELeTvkYXiPTZMOIXHqSxyB6DqTIFuEx4LRq/DPkF/f1alWv2K5Io/l3Newfpn2su
 Xe/mb5D3UFCQyBM+kW7tS+ZTrcToRV853JHRKembMbDHvBFij/bhqy+9+ys2HD8765Ex
 Pbva5ifWyV7DebfDRiboE4fPQT7lpZ2nVbKvLvyUwhWNh469BVZmAClG4xTcphe50Nsa
 qZag==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhaq4sOvqgqXSkEWIwqSp+lMA3eH2k43vXoBFmlpOup1ybJ4qhbJqe7j9vWUoIASdZEE+HIRou@lists.freedesktop.org
X-Gm-Message-State: AFuF++lsJ9uIFLhLZShUxek5rdwfE7qZwPaC3dhpPlPJuREZWJzRCZNl
 xj0allCy39TuVPfVqAMOZYek2Ir+bvdSW6SLyZoZ1akCuG2RWGt3Sp3tF+Oa6qsb5G47LOp2TA6
 bz6swVxQ7Sy0R3MPmJ10jFhN0hkrpNNfkVg==
X-Gm-Gg: AYBFou3+xNY7aYBK650XqWwim4eD2mDlFXYn3AB+JTL5vw1k3cHYM5pqxo+3AVtHghY
 HfwlYHORTpAnr8ExRW6HE7HSMfteezCBJ+9vezf5N+Fppv0HjaTOL76u0+aI4H705f4BZo2zuTN
 zYcWrvFYhvKgBdGAe8CuF6hvzym9Ee/C1nDv9cBbvMctOId6CRSq3rh0YyOotM44aEMPzzhaNoz
 TkBFs+/F22nsKd65OMNH5AKMNhNVcUCRvizoikgg53UjBUr/x5admuc5WcsXOxMEWAIqLbaBqws
 0enoJsG0yD03ByEeM2W0cK+nm71CqXgYjA1BaNkeBDoYo6Ff3SSZmGq7HvwV6Q2j0pxAFGQdl+G
 NkRBbusulGQaQLpEzfiIPAVe1H1mQ0KhgnAKKEONLqw==
X-Received: by 2002:a05:6102:9d8:b0:787:74cc:2b68 with SMTP id
 ada2fe7eead31-78a60ccc908mr5463416137.1.1788986364856; Wed, 09 Sep 2026
 13:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
 <CADnq5_Ns1y7ZCAOmdVafVeu2KLNxObLDdhb=JzDp4daaUqtN4A@mail.gmail.com>
In-Reply-To: <CADnq5_Ns1y7ZCAOmdVafVeu2KLNxObLDdhb=JzDp4daaUqtN4A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Sep 2026 16:39:11 -0400
X-Gm-Features: AcwNN1U_qMN0AoQ7aMkRhUkTiXonSV7gkX5ZgqYduHVJQJOETT_GFTTr19OVYuI
Message-ID: <CADnq5_PY5-uLYs2_gYMzrDqMdLQPBQX_VPMk_MenUMmmYrBpFA@mail.gmail.com>
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

On Wed, Sep 9, 2026 at 3:23=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Sat, Sep 5, 2026 at 4:55=E2=80=AFAM Srinivasan Shanmugam
> <srinivasan.shanmugam@amd.com> wrote:
> >
> > MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
>
> MES doesn't own the kernel queue VMIDs.  The kernel driver does.  MES
> assigns VMIDs dynamically for user queues, but for kernel queues, the
> kernel assigns the vmids.
>
> > SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queues
> > via ADD_QUEUE with map_legacy_kq=3D1 but does not set trap handler stat=
e.
> > On GFX10 and earlier HWS-based hardware, the driver programs trap
> > registers via SRBM select for KFD queues but no equivalent exists for
> > driver-managed kernel queue VMIDs.
> >
> > Add a vmhub callback program_kernel_trap_vmids() so each gfxhub version
> > can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
> > device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
> > address AMDGPU_VA_RESERVED_TRAP_START =E2=80=94 each VM maps its own kq=
_tma_bo
> > there, so per-VM isolation is handled entirely by page tables without
> > needing to reprogram the register per job or per submission.
> >
> > The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
> > (parallel to page table allocation) and mapped read-only into the GPU V=
M
> > at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the second-leve=
l
> > handler address into it via kq_tma_map when userspace calls SET_L2_TRAP=
.
> > The first-level CWSR handler reads this address to chain to the
> > second-level handler when a shader exception fires.
> >
> > This design is:
> >   - Per-VM BO (not device-level) =E2=80=94 same model as page tables
> >   - Fixed VA in each VM's address space =E2=80=94 same VA, different ph=
ysical BO
> >   - Read-only from GPU =E2=80=94 kernel CPU updates it via CPU mapping
> >   - Treat allocation/free lifecycle identical to page tables
> >
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Suggested-by: Alexander Deucher <alexander.deucher@amd.com>
> > Cc: Lijo Lazar <lijo.lazar@amd.com>
> > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Cc: Samuel Pitoiset <hakzsam@gmail.com>
> > Cc: Natalie Vock <natalie.vock@gmx.de>
> > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
> >  5 files changed, 110 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.h
> > index 3ca187f5ade8..5624a5ab5c62 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
> >         void (*print_l2_protection_fault_status)(struct amdgpu_device *=
adev,
> >                                                  uint32_t status);
> >         uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flus=
h_type);
> > +       void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
> >  };
> >
> >  struct amdgpu_vmhub {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_trap.c
> > index 623cac6781be..e913488ca3fa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> > @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
> >
> >         amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
> >         adev->trap_info =3D no_free_ptr(trap_info);
> > +       amdgpu_trap_program_kernel_vmids(adev);
> >

Why do we call this here?

Alex

> >         return 0;
> >  }
> > @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
> >         adev->trap_info =3D NULL;
> >  }
> >
> > +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
> > +{
> > +       struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];
> > +
> > +       if (!amdgpu_trap_is_enabled(adev))
> > +               return;
> > +       if (!hub->vmhub_funcs || !hub->vmhub_funcs->program_kernel_trap=
_vmids)
> > +               return;
> > +
> > +       hub->vmhub_funcs->program_kernel_trap_vmids(adev);
> > +}
> > +
> > +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
> > +                               struct amdgpu_vm *vm)
> > +{
> > +       void *cpu_addr;
> > +       uint64_t va;
> > +       int r;
> > +
> > +       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> > +
> > +       r =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_=
SIZE,
> > +                                   AMDGPU_GEM_DOMAIN_GTT, &vm->kq_tma_=
bo,
> > +                                   NULL, &cpu_addr);
> > +       if (r)
> > +               return r;
> > +
> > +       if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
> > +               iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
> > +                                         (void __iomem *)cpu_addr);
> > +       else
> > +               iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);
>
> Are you planning to copy the first level trap handler to the buffer
> later?  Why not just initialize it here?
>
> Alex
>
> > +
> > +       vm->kq_tma_va =3D amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
> > +       if (!vm->kq_tma_va) {
> > +               r =3D -ENOMEM;
> > +               goto err_free_bo;
> > +       }
> > +
> > +       va =3D AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MA=
SK;
> > +       r =3D amdgpu_vm_bo_map(adev, vm->kq_tma_va, va, 0,
> > +                            AMDGPU_GPU_PAGE_SIZE,
> > +                            AMDGPU_VM_PAGE_READABLE);
> > +       if (r)
> > +               goto err_del_va;
> > +
> > +       r =3D amdgpu_vm_bo_update(adev, vm->kq_tma_va, false);
> > +       if (r)
> > +               goto err_del_va;
> > +
> > +       return 0;
> > +
> > +err_del_va:
> > +       amdgpu_vm_bo_del(adev, vm->kq_tma_va);
> > +       vm->kq_tma_va =3D NULL;
> > +err_free_bo:
> > +       amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
> > +       return r;
> > +}
> > +
> > +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
> > +                               struct amdgpu_vm *vm)
> > +{
> > +       uint64_t va;
> > +
> > +       if (!vm->kq_tma_bo)
> > +               return;
> > +
> > +       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> > +
> > +       if (vm->kq_tma_va) {
> > +               va =3D AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC=
_HOLE_MASK;
> > +               amdgpu_vm_bo_unmap(adev, vm->kq_tma_va, va);
> > +               amdgpu_vm_bo_del(adev, vm->kq_tma_va);
> > +               vm->kq_tma_va =3D NULL;
> > +       }
> > +       amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
> > +}
> > +
> >  static int amdgpu_trap_map_region(struct amdgpu_device *adev,
> >                                   struct amdgpu_vm *vm,
> >                                   struct amdgpu_trap_obj *cwsr,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_trap.h
> > index 7f83174a4742..9be5035abd1c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> > @@ -155,4 +155,11 @@ int amdgpu_trap_set_trap_debug_flag(struct amdgpu_=
device *adev,
> >                                     struct amdgpu_trap_obj *cwsr_obj,
> >                                     bool enabled);
> >
> > +/* Kernel queue trap handler =E2=80=94 per-VM TMA and register program=
ming */
> > +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev);
> > +int  amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
> > +                                struct amdgpu_vm *vm);
> > +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
> > +                               struct amdgpu_vm *vm);
> > +
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index de3ef9ce2234..f5e228d4bfb5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2640,6 +2640,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm,
> >         if (r)
> >                 goto error_free_root;
> >
> > +       if (amdgpu_trap_is_enabled(adev)) {
> > +               r =3D amdgpu_trap_vm_kq_tma_alloc(adev, vm);
> > +               if (r)
> > +                       goto error_free_root;
> > +       }
> > +
> >         r =3D amdgpu_vm_create_task_info(vm);
> >         if (r)
> >                 dev_dbg(adev->dev, "Failed to create task info for VM\n=
");
> > @@ -2774,6 +2780,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm)
> >                 amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
> >         }
> >
> > +       if (vm->kq_tma_bo)
> > +               amdgpu_trap_vm_kq_tma_free(adev, vm);
> > +
> >         amdgpu_vm_pt_free_root(adev, vm);
> >         amdgpu_bo_unreserve(root);
> >         amdgpu_bo_unref(&root);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.h
> > index dd825e179979..064f95a83790 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -25,6 +25,7 @@
> >  #define __AMDGPU_VM_H__
> >
> >  #include <linux/idr.h>
> > +#include <linux/iosys-map.h>
> >  #include <linux/kfifo.h>
> >  #include <linux/rbtree.h>
> >  #include <drm/gpu_scheduler.h>
> > @@ -488,6 +489,18 @@ struct amdgpu_vm {
> >
> >         /* cached fault info */
> >         struct amdgpu_vm_fault_info fault_info;
> > +
> > +       /*
> > +        * Per-VM kernel queue first-level TMA BO.
> > +        * Allocated at VM init, freed at VM fini =E2=80=94 same lifecy=
cle as page tables.
> > +        * Mapped read-only at AMDGPU_VA_RESERVED_TRAP_START in the GPU=
 VM.
> > +        * SQ_SHADER_TMA for all kernel VMIDs points to this fixed VA; =
per-VM
> > +        * isolation is via page tables mapping different physical BOs =
there.
> > +        * CPU kernel writes second-level handler address via kq_tma_ma=
p.
> > +        */
> > +       struct amdgpu_bo        *kq_tma_bo;
> > +       struct amdgpu_bo_va     *kq_tma_va;
> > +       struct iosys_map         kq_tma_map;
> >  };
> >
> >  struct amdgpu_vm_manager {
> > --
> > 2.34.1
> >
