Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA4BC79FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 20:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C7210E943;
	Wed,  9 Sep 2026 20:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LFMKOmE0";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2750010E943
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 20:51:05 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 ada2fe7eead31-781d5818299so205603137.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 13:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788987064; cv=none;
 d=google.com; s=arc-20260327;
 b=NnU/4+1DI92Q19wi6KNJoq0SsrvlxEEerl36HEFGgoTZ17b+x4F0SVLXt/GHSxw201
 ELfCX7GQj2yaPHlXmNcXIWymqoDLIYD4kVBZOsvXLaFVCD0zBxmYOPSRjvqcdGhuGXk9
 MWVsi+nrfqzmQp4/Mh6JUTH4CBLiOTSGlsG7l0qWHuSoJiP2nPOE5DEQuu3W4uhEnBuM
 bVcjBS/nx1kVJbdz1H/pWIkt1ESdi30ZhgWCyv/j2gtxekZsRep6g3YVpTiDvBI29Yd+
 ndAbG1TrBZTxRABmgCamSaJExhCVcOsSNZMLTbf/PhANs4AVzASbdwrchuGNHysnbUZr
 KpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t3anDrESRoGxyy/BJegCxXPg/vVR8l/epg5gAmp3BIE=;
 fh=EL8o3zSXtVii4Z83Fl7KtGVA0EOCeol4Xbmu8vCrmI8=;
 b=m5aHZIRD6DWEKdYb/BRGzOztj7E0LypDVLvkVRF20W8VbeaFG6sOtKKUu7S7CgAL3p
 bzQiAozsSr9H0zPH3l9zVQBLFJ0VOc6LrC9WUdrJtWNnYb0X+f3RaIq+nzGlQm8bpewX
 Xy4NTG1IN/Dv+tN98JHQ8MGygpJTBqMQj2OTvBnV7m4D6gFUIfBC2jyaBqkMxtu/9Ll3
 HmJK01PziEu5eyQyp7DY9MtuStOXyNu7GxkHnlS1VrV2V0XyED9U3lDhMgHMQh6VLZqQ
 buLaOhvG6LBCRdKBG+Z9ckkd9uoM7/Cj5fE4dStt5COZQ0K14yDOxRplLiNgTTtLUOFp
 OVVQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788987064; x=1789591864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t3anDrESRoGxyy/BJegCxXPg/vVR8l/epg5gAmp3BIE=;
 b=LFMKOmE0K/6zW1MOswv2HxCBZba1/XJoUZBJVO5QaGGvpGBTkwLnfirRxJfvwc8s0k
 uHHbl1nUcxvu2mL0QABG+56bZje1TPGzy1nhCVUezwelBcFpj6iovkSgxH/ZhVynhKoT
 X3wZqbvr9zFoxK+/QVQLmI8+8xAj7B1tLdt5yIh72tytM/bowDEnI2/EhdEFYEWj+tDn
 ejWicldqB6p6Nc8gorsFMNjKjLQdmdGUp1riAJv3jB0mWikxxYdHXqNooUdxq4aldKHP
 zE544XCJ7jQj/sLcvleKTOBIeCWOBar1Sab1K+lIGcMA40j78e5RDsFZ/QeUQtWZZ3VV
 iyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788987064; x=1789591864;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t3anDrESRoGxyy/BJegCxXPg/vVR8l/epg5gAmp3BIE=;
 b=eu2SVRFvKokUJkVSHsUhn+G4W6M0IdAjueS5FXcmux0sDg84okNUvFvJUgjgi/Cmzs
 H/FAHkxhuGnOhPUB/8ASGssTGluyihEbnkPZJXcEkQ37QuVXW8bCfWSYVZEDnBanhprj
 ea+LMOaaFMwOkjzbwcQsURbkohUUDwCnGiIhBc3StVSuCOR9MNkHExXR8KkqTTvxwGjD
 jgro5r2q8TlRcB/Fkl7Em7RKDGwIVJwLU1byXK85CxkRr+EU7TtKIUfxjs2PaEX8H4ef
 +3LHKwk6yRbLN7qv0nALIDXgj8ePefCaR149tsX9Nimqu7F+sME/HgIbebdRUKzgdiGj
 UOkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBybIvBvs/qEW/3L9WIYqtlqTbw4HqfHhtZWuuLXqNOEGLPx6gaoZmjiscRANNzMMww/DxFknsCy@lists.freedesktop.org
X-Gm-Message-State: AFuF++nfE0Otio7hJtlFHxXAduuxkSfeL29aPIg/SHytQlgPggksZb7u
 lgra9H4d26gvv+LigmT2Sze60K6a8aXvqIrPiVgjQinjIPFVQjVpfZrOBczdYD6/CkGQ+9GtOtf
 pGl/HZSLoFwKwlLCKWs4/anzzL/hxaTE=
X-Gm-Gg: AYBFou3C4wwKD8m0UjBUFzeiWfk8smxQnyUYQDLlb8zrgoHjLl1QFRzqSf220erP+f+
 YTLZJkv2GoVbLKljs6kdsq+tS4k08FxHJKxO8JPVdJVct6TCI0uvDvSLU926fFLis5TimzHDKxN
 snXc5gG3ySiTHfZvwMAZNEPmcmXP0RLlQT4DVnqdVPQdWFHJhpdRQuVbjBa15q5tOehC19m9Czw
 3uqDyqH2+e6PeMiaevk3f1PolIvoRBzo6CH6PAdkK7s3YbKppq2UuJjLmKeEoQEWkD6Jtvryd0e
 JvDRxIYvKJtuLl1weyHOU9VN1B0ouCmL6fJxrU5jZMfP5FfWWCDvjoyEeT2fMAQwYzmn/bKsr5h
 5NeqSPUArjFr5Wle7L7hHiXNTypcZOTCZXXgJ/OEQzQ==
X-Received: by 2002:a05:6102:390b:b0:784:a169:1925 with SMTP id
 ada2fe7eead31-78a60f2f87fmr5877970137.2.1788987063979; Wed, 09 Sep 2026
 13:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
 <CADnq5_PHEQzUVTqJYzO3mALs9LfK9cAUMQtgi0JEzGvFSZk7Eg@mail.gmail.com>
In-Reply-To: <CADnq5_PHEQzUVTqJYzO3mALs9LfK9cAUMQtgi0JEzGvFSZk7Eg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Sep 2026 16:50:51 -0400
X-Gm-Features: AcwNN1VzKMLEU1BQCDP8kjMj9PhJmGcLe0QGRhvoLBjGkrQjRiCpz7GXHOxKj64
Message-ID: <CADnq5_M+tLHSrfXQCxX2+LFq-x8OO1=BG+ou=qq2_Y0VS+b8AA@mail.gmail.com>
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

On Wed, Sep 9, 2026 at 4:42=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Sat, Sep 5, 2026 at 4:55=E2=80=AFAM Srinivasan Shanmugam
> <srinivasan.shanmugam@amd.com> wrote:
> >
> > MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
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
>
> These should be the same for both user and kernel queues.  The only
> difference is who manages the vmids (driver vs MES).  They are per
> vmid so it doesn't matter whether it's a kernel queue or user queue.
>

I would merge these patch sets.  The trap handling is the same for
both kernel queues and user queues.  The only difference for kernel
queues is that the driver has to set the TBA/TMA registers while
MES/KIQ handles it for user queues.  At vm_init time, allocate the
memory for the trap handler, copy the trap handler to the memory and
add the mapping to the GPUVM address space.  Then in gfxhub init,
program the TBA/TMA registers for the kernel managed vmids.  Finally,
add the IOCTL to set/clear the second level trap handler and validate
the user supplied GPU VA.

Alex

> Alex
>
> >  };
> >
> >  struct amdgpu_vm_manager {
> > --
> > 2.34.1
> >
