Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF46C88E45
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 14:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E1E10E35B;
	Fri, 11 Sep 2026 14:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gQzMxejs";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A6810E35B
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 14:07:58 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b1a806664so148341a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 07:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789135678; cv=none;
 d=google.com; s=arc-20260327;
 b=A5ACUJGJQVnA9D7PWwNfeD1lOMa40FhAcMvBaXgOkqM5aCiK4j9DwOijOTKc4wWQrR
 772QpvVfOMNrg6S3MTgpVr6Kj46NIPdoFG+rI5WSpwUM6uXSSYfgv5XNNouK0m9ahh26
 2jgvpQl3/IxR0QfQ464ubkZ0UANJ0gfYl1X8XMrTsVnz9pVDk+WuAU5szieRszAoadqO
 znbAjM9yhsB4z9TB/lUMfnnXduasAhlGbuvNFlCTNYcxUfe/CicKdTPt2g7O3YnjR6qd
 H7cDpKMbI5N8JttYODXh9I+S4cosPiD0EFaUmTtjUKO8gd/MblEKJHIShjrvQ4XW3EXI
 OatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sLOiEFnjnzcO94dU7EHCB1ChoMXpiSyEFowLFbkM0nk=;
 fh=eDBCY8yd41SU9QO09SBHX1JrKkby0Rwp1oeNBCCaikk=;
 b=cYRzWmaqpJ0wAVLrMOVQcwAzJUGaY/sFqEdBUsu6RxjfAzcTQ7kdQTB8fey6Wi9lqa
 CNZNL1HT/Hq4jNqN4WRHV9C6ywOsidCODebfwLetpFR9LFvZGTmXO3WUMrydWW3Y5aqY
 amaoKFdHghlkwF1rBSbr2t2FUjJp2/atJX30Y286Q6lnNq2Su5RIOYUloUFPvFNEBrd0
 zm+qoOOD3MR9JeNVNxWUNOratgEBFrtgTgcjaXeOoF5Mg0c9XsjaFzL4j37XGVh4rLBq
 RB0QxbTUVKXD6ALtwhIzl45vnswt08aDhfjREzCox3rCs8jlfyqQm7/rUGhFh5AzhycT
 Z2/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789135678; x=1789740478; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sLOiEFnjnzcO94dU7EHCB1ChoMXpiSyEFowLFbkM0nk=;
 b=gQzMxejspuhjFvL3Pq0+uqqljKUcEOOAVKcmj1//YHWQveRtvzuw5rTq6s0gMcMNKu
 T0UwjZ2k7fpyJbbJEP8aR+4dTpFRg7tS4jkIXnL+VnXdEAdSY2BVXTg+YSXGhj2qqzxG
 8KQux9xmsVtr4vp0biH8spRQzRpLzGouqkJKBe389VpI288K2F3p5VT1+RwfBhYzMYYN
 D+HGoOnDGAHNaiC2ry/eY6zpQa8KcSRw15A7UeJH0/pZKDnu609ADsLqHb86BrrBEJFO
 oqe/3vXBYbcU0bNlpTwW/ikPAxND9LXifx4Ff729nuSPwGI/IXT5MVTSR13JJUBBO9Vv
 E8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789135678; x=1789740478;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sLOiEFnjnzcO94dU7EHCB1ChoMXpiSyEFowLFbkM0nk=;
 b=mMWYUEsHR0liHqL/ndvbJPrWKYnUKqJwYjg1BBwGfPMoUNf92IA/c+/RrUdTPiBmSM
 inPuLgA72QFv5Qg6qDZxJznrRkxdBkAEVF7DnxiODbkoHmfDdjxOq98zEf8D7+psqMsL
 AECSQKHEYBILGvJoK5baocrUtOa37rz1uFUubapFMKTnGkTbDA2E4EApL/jcxpi5gXbB
 dF4nhZJTN81mfHJvNq6ykFdoHhvi9hGTt27j/S50rVoVeUoxZqfWtYkvpCwOoVK7JXlw
 kDcxd5or9F5LB4aT41Hulg9dcNCfNhtkzbV0uUlmIqoJnd7g9TWkrZxQAn2MTgdMuKdX
 q2Fg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQgVhCcKI/vLhmEbYscVc+uOtXuRNua3aKTxyx+mLF0Qr5I5dLUfu2Rm7Tl8s2uZmVqzJo9RSD@lists.freedesktop.org
X-Gm-Message-State: AFuF++l38wuWzqrtAuslQoSq032DWe7YiWApfALRAapi3egSOOdf1SMg
 t8n/t3mYzdvsMD3tzVQ6vZP/oLE4DOJi4FpFuSYC/KgF57zuupSqdHZgT2DFVXmaXnuTGLfU4vk
 apJ2YT12R28U5ElsGn0/hHAiPepwVkKw=
X-Gm-Gg: AYBFou1saa0EFfsEsNXkFg2m/UDIyu+JsGdMOE/iRp7eDkvU9q/GIUDJfJNIRWEEwUB
 YUTmn/AnpV8bVSjaVntnljjzvDRZtoAYh16z23sZ2pcxLYrJ+r4Z6F4Ev8U9TydjUpsUB8QCOJs
 ZRkxEmZZGVBu3qBFERQhcun5WhH/YQ9ebnrteCa95y5Spfp9UCG5o/mb9yC6MT4ioW/xbngGTMR
 KeZUK+dHBB/KRZUKEiIJ2GUC+O/VVTeASWzQJ8u+uRy4ThIfz8AtOQrl8CZ11WxJJQ5SqGtzn8G
 RcZcwbV2PvpO6A6bWnfk0AmIxS2JJ7iKJsqoZHjgoDRAbpuHrhaN9wSKgYbBAga7Xj5TbrNfBlJ
 Arrwz4VizryhYP8ZImuNDMbgLvxloeymMZFPhP85gZA==
X-Received: by 2002:a17:90b:4b82:b0:39b:34ef:3b24 with SMTP id
 98e67ed59e1d1-39d9bc05930mr5010587a91.1.1789135677899; Fri, 11 Sep 2026
 07:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
 <4f97a5e8-8bef-4353-9998-9e6daee499d2@amd.com>
 <b652b617-de17-4e11-9492-ffb003a9e51e@amd.com>
 <SA0PR12MB7091A430EEAB0FD042DF601597B02@SA0PR12MB7091.namprd12.prod.outlook.com>
 <CADnq5_N38NE6Q8Bstcwx5aVh5Jfm8yCJO=ffD-vhBND9mZkisw@mail.gmail.com>
 <SA0PR12MB7091203029CC7166AB28355597BF2@SA0PR12MB7091.namprd12.prod.outlook.com>
 <0d91c47d-086f-4fae-a92d-8b69f14410f0@amd.com>
In-Reply-To: <0d91c47d-086f-4fae-a92d-8b69f14410f0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Sep 2026 10:07:45 -0400
X-Gm-Features: AcwNN1V1LMF7_ANXdy0xtDBSRGSUaNkVxaI-Y_uFltUKTZIEgoo-osOQ1kVqz2A
Message-ID: <CADnq5_Nya37VsLXL+X07HzOG1N9eGvOgCVR+=x_b0Xejh_6WCw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap
 handler infrastructure
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
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

On Thu, Sep 10, 2026 at 1:23=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 10-Sep-26 7:36 AM, Lazar, Lijo wrote:
> > AMD General
> >
> >
> > My question was slightly different context - The first level TMA is
> > fetched based on VMID of execution context .
> >
> > If user waves are executed in IB VMID context (even though submitted
> > through kernel queues), do we need to allow user to install handlers fo=
r
> > kernel VMIDs?
> >
>
>
> To clarify -
>
> For other non-zero VMIDs, is there a need to allocate separate BOs like
> kq_tba_bo/kq_tma_bo?
>
> Can't we keep just one set of tba/tma bo for first level? User handling
> may always be through second level as the ioctl allows user to install
> only second level ones. If separate handling is required based on queue
> type (kq vs uq), I think trap handler can identify the queue based on
> doorbell offset.

Maybe I'm misunderstanding how the second level registration works.  I
thought the pointer to the second level trap handler was changed in
the first level trap handler when the user registers the second level
trap handler. If so, we need a per VM BO for the first level trap
handler.  Then the second level trap handler is either NULL or
whatever the user registers for their GPU VM.

Alex

>
> Thanks,
> Lijo
>
> > Thanks,
> > Lijo
> > -----------------------------------------------------------------------=
-
> > *From:* Alex Deucher <alexdeucher@gmail.com>
> > *Sent:* Thursday, 10 September 2026 00:24:03
> > *To:* Lazar, Lijo <Lijo.Lazar@amd.com>
> > *Cc:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Koenig,
> > Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org <amd-
> > gfx@lists.freedesktop.org>; Timur Krist=C3=B3f <timur.kristof@gmail.com=
>;
> > Samuel Pitoiset <hakzsam@gmail.com>; Natalie Vock <natalie.vock@gmx.de>
> > *Subject:* Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-
> > level trap handler infrastructure
> > On Wed, Sep 9, 2026 at 2:05=E2=80=AFPM Lazar, Lijo <Lijo.Lazar@amd.com>=
 wrote:
> >>
> >> AMD General
> >>
> >>
> >> One generic question - I am assuming the overall purpose is to debug a=
 user job submitted to kernel queue. When user IBs are submitted to kernel =
queue, those IBs carry VMID assigned to user. When wave submitted through s=
uch a job encounters a trap, isn't it having the user VMID? If so, when is =
this kernel queue related TBA/
> > TMA helpful or selected? If it's only for driver submitted jobs, then
> > this control to user is not required.
> >
> > Each fpriv GPUVM will have a copy of the first level trap handler
> > mapped at the same GPU virtual address.  If the user requests a second
> > level trap handler, their copy of the first level trap handler will be
> > updated to point to the provided second level trap handler.
> >
> > Alex
> >
> >>
> >> Thanks,
> >> Lijo
> >> ________________________________
> >> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> >> Sent: Wednesday, 09 September 2026 18:32:03
> >> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koe=
nig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> >> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Tim=
ur Krist=C3=B3f <timur.kristof@gmail.com>; Samuel Pitoiset <hakzsam@gmail.c=
om>; Natalie Vock <natalie.vock@gmx.de>
> >> Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-lev=
el trap handler infrastructure
> >>
> >>
> >>
> >> On 9/9/2026 1:15 PM, Lazar, Lijo wrote:
> >>
> >>
> >>
> >> On 05-Sep-26 1:49 PM, Srinivasan Shanmugam wrote:
> >>
> >> MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
> >> SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queues
> >> via ADD_QUEUE with map_legacy_kq=3D1 but does not set trap handler sta=
te.
> >> On GFX10 and earlier HWS-based hardware, the driver programs trap
> >> registers via SRBM select for KFD queues but no equivalent exists for
> >> driver-managed kernel queue VMIDs.
> >>
> >> Add a vmhub callback program_kernel_trap_vmids() so each gfxhub versio=
n
> >> can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
> >> device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
> >> address AMDGPU_VA_RESERVED_TRAP_START =E2=80=94 each VM maps its own k=
q_tma_bo
> >> there, so per-VM isolation is handled entirely by page tables without
> >> needing to reprogram the register per job or per submission.
> >>
> >> The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
> >> (parallel to page table allocation) and mapped read-only into the GPU =
VM
> >> at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the second-lev=
el
> >> handler address into it via kq_tma_map when userspace calls SET_L2_TRA=
P.
> >> The first-level CWSR handler reads this address to chain to the
> >> second-level handler when a shader exception fires.
> >>
> >> This design is:
> >>    - Per-VM BO (not device-level) =E2=80=94 same model as page tables
> >>    - Fixed VA in each VM's address space =E2=80=94 same VA, different =
physical BO
> >>    - Read-only from GPU =E2=80=94 kernel CPU updates it via CPU mappin=
g
> >>    - Treat allocation/free lifecycle identical to page tables
> >>
> >> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Suggested-by: Alexander Deucher <alexander.deucher@amd.com>
> >> Cc: Lijo Lazar <lijo.lazar@amd.com>
> >> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> >> Cc: Natalie Vock <natalie.vock@gmx.de>
> >> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> >> Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++++++=
++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
> >>   5 files changed, 110 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.h
> >> index 3ca187f5ade8..5624a5ab5c62 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> >> @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
> >>       void (*print_l2_protection_fault_status)(struct amdgpu_device *a=
dev,
> >>                            uint32_t status);
> >>       uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush=
_type);
> >> +    void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
> >>   };
> >>     struct amdgpu_vmhub {
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_trap.c
> >> index 623cac6781be..e913488ca3fa 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> >> @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
> >>         amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
> >>       adev->trap_info =3D no_free_ptr(trap_info);
> >> +    amdgpu_trap_program_kernel_vmids(adev);
> >>         return 0;
> >>   }
> >> @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
> >>       adev->trap_info =3D NULL;
> >>   }
> >>   +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
> >> +{
> >> +    struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];
> >> +
> >> +    if (!amdgpu_trap_is_enabled(adev))
> >> +        return;
> >> +    if (!hub->vmhub_funcs || !hub->vmhub_funcs->program_kernel_trap_v=
mids)
> >> +        return;
> >> +
> >> +    hub->vmhub_funcs->program_kernel_trap_vmids(adev);
> >> +}
> >> +
> >> +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
> >> +                struct amdgpu_vm *vm)
> >> +{
> >> +    void *cpu_addr;
> >> +    uint64_t va;
> >> +    int r;
> >> +
> >> +    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> >> +
> >> +    r =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SI=
ZE,
> >> +                    AMDGPU_GEM_DOMAIN_GTT, &vm->kq_tma_bo,
> >> +                    NULL, &cpu_addr);
> >> +    if (r)
> >> +        return r;
> >> +
> >> +    if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
> >> +        iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
> >> +                      (void __iomem *)cpu_addr);
> >> +    else
> >> +        iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);
> >> +
> >> +    vm->kq_tma_va =3D amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
> >> +    if (!vm->kq_tma_va) {
> >> +        r =3D -ENOMEM;
> >> +        goto err_free_bo;
> >> +    }
> >> +
> >> +    va =3D AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK=
;
> >>
> >>
> >> Is this the same address used for mapping of TMA for user queues?
> >>
> >> No =E2=80=94 these are different, non-overlapping addresses in the res=
erved VA region:
> >>
> >> AMDGPU_VA_RESERVED_TRAP_UQ_START =3D TRAP_START =E2=88=92 12 KiB
> >> =E2=86=92 used for UQ first-level TBA (8 KiB) + TMA (4 KiB)
> >> AMDGPU_VA_RESERVED_TRAP_START =3D SEQ64_START =E2=88=92 64 KiB
> >> =E2=86=92 used for KQ per-VM TMA (this patch)
> >>
> >> The UQ region sits immediately below the KQ region in the reserved VA
> >> space. No collision between the two mappings in the same VM.
> >>
> >> Regards, Srini
>
