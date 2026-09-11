Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52934C88E50
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 14:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB1B10E3DA;
	Fri, 11 Sep 2026 14:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i884wNl9";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C94810E002
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 14:41:28 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1ab17a810so4158a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 07:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789137688; cv=none;
 d=google.com; s=arc-20260327;
 b=dh+J4wspBk0AACvkIucT2xrggFHESiQeThuYqPFG3QesURY9h3ckSiYfFZheJAhhNd
 0H9egFFplYIUECyPx2xREf6BMpr3juMWTM14ylP9QbKeE0tort3ELNHVoDlkHt3ZujtS
 8c5NYKtc/i+T81gilddWE3OQckaI+vFmuDLIeITMewG/GHM+7miyo65/OrFzSGCFb7l0
 fA7LA0IqNWHljFg1s3ShoG9UdNE2YsJXjRGqYClZRFYWvlDBWSKVmtooobw2aipMjRzA
 c22G6HlNXL4SoF1I3XzP6uOa8+0qCPYEKuxd6R5SXgX6PmsT5bwrPY0Nz0z83cPlprEN
 agXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qBOpXEFj+5l1ohymQl3BIgsA2zVwiD3FzuPJ8XW64GI=;
 fh=FKlFLOkqhqcIrPDIJCw3b2uSwIx5WgAQBBJzEgBPTqM=;
 b=DaLf11SIgkZwgcoBx4DGrCjOEhdi1ER+IM/pWS01qQVCdyZmC5+eETs1QxXgjRGmXr
 pIlgu1w8at6X8rPI+aAdtZHntTFO3aS66ComEB3gkUMDwWbhu837TMDmn0Yt/JUw4hQ0
 dq1jWEMO8gLTbXuO/ikFt+Uu+lO9wx0XwzkY+GyISqwYGXqkqwKXsJ4m+JNgjdgbd/nn
 VDg46d7fFqE/aF/29a/uPSnzp3Ltwvr9WPqfxVL4OJfkmIO+cXokXDi9UkVCNlRQEBBB
 rLdpUv+hAe3iuS0USBPd0UYQUk2KD+H1T240x9DX9yFe8kwYfzbU6YLPken4NBUdEb/a
 LnSw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789137688; x=1789742488; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qBOpXEFj+5l1ohymQl3BIgsA2zVwiD3FzuPJ8XW64GI=;
 b=i884wNl9Lnhu8NDtZcOsV6R9yAJVM8Zy4sY93ialJehx2WorBDYuuqkP+Uh6hZ+NIi
 WzGMT3jPP1IiGw5wqYLNjcxwi69yd55qXcIgz/pKycvf8OMZAu0xpfB2wC/OzVYNyFq5
 +aR2jDrcnAgO0EYuCezjsKQOzJ+GqqwRdETrtT1s8CyLJWmzw82jsnVpPCwcEmOJQazT
 YD8xCKYMPWq4YG+VgRmy3Gp+zqJGIz73nF7eiob1gQ9Tyv66nw6wvJmAFFCE6k5Jklux
 cuTQf8fvUBdHCYLvnkmTU6ZgNb5Y5yx8abnwa9yxiGR89ksBgRlDWaI8fFvqbKwRm2XI
 ASgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789137688; x=1789742488;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qBOpXEFj+5l1ohymQl3BIgsA2zVwiD3FzuPJ8XW64GI=;
 b=VRcAlw9kqaAqRG6AuKWeRX4LoFErYeCu3TwDMcH8dHOfvt9bsKyuOzLhbNzO+DKpIG
 2N3wFTL5jAjYgMgrpdvMg3p368RM/5W+h+FzZmivO7q0rbePAACanNOQ9CKGXmiHon2a
 jnLCFNDzQMzjyMBI8Hiz+PQfkllIpTb1LDhlRy1tMa5hIFa83xnrIAqgUKGAMlh/EOXJ
 zsoVqzOLxEJHbb7D0VJRQxFYesyM/xRGTn22ONQCdC3h473NpfAPSxWhcD9cnJpux+aC
 zpas1tJK6fnn2IdO2qM4Xmj7P2ZctHkwnvcVGEKLQLcW9mtgVbHlZ0GJ87/fixwsYg3i
 /Fcw==
X-Forwarded-Encrypted: i=1;
 AKwUvBynRo3KuoJ4BqLQ9voxLk6wXTk88pI8yVzHGQQEpjAIRxWANQCpN0l2G/PdTaZ6EvK0k/4xSZlM@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5oajXe/yb+N7BHRQmpfxX7nIvW2TfSfuAkjAkTUl2dDpHMlyy
 Pw1auir93YSINprgFnIRrcAFmdJtxp7o0W9HVq1iall62DrBUiE8TJzDTss4JLolx5JVHxWVGPa
 dstzfesUeUYiq5jllmZrGCQ7RKGb9/zQ=
X-Gm-Gg: AYBFou39KOVkiJMfAn2HNYTk+DiXmUMkv7mJmWvuYSt62Hd/VU69LQnPaM1nnLf/nQZ
 37W3oozs8STnHSEF9QyMxaDuVsrjXXw4x+gxf3wDvUHUHjTEOC7BsgY4uya1wMHlIyXzR7seP8q
 VtS4GtcbKqdd149rDdIjBPbgLFXfe6zQXE48uxGhJeLWWRo5yTxuYdQToLy2wfUN4ngm5WnYIIu
 5P0jhAM+gH0daqiR/DtiCMD4wGa8rdMsD4/bvDZR6DF0jFS4LAUvZ86b69U2jxTOT67MnsRzf47
 vU1hZRqcJRxvu+jhYHORpM66uKRfH89dGloOmNi88ueKbQ/hpoSSV7Hw0ZL83cAsCLiimEiw058
 qyo5AxpXKhrNJ7g+CLdhbsaOMNw1hnxRepCmKUrHpLQ==
X-Received: by 2002:a17:90b:3808:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-39d9c2249c2mr4897030a91.4.1789137687394; Fri, 11 Sep 2026
 07:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
 <CADnq5_PHEQzUVTqJYzO3mALs9LfK9cAUMQtgi0JEzGvFSZk7Eg@mail.gmail.com>
 <CADnq5_M+tLHSrfXQCxX2+LFq-x8OO1=BG+ou=qq2_Y0VS+b8AA@mail.gmail.com>
 <8573edf1-9af4-423d-8af8-08ac38f33ab2@amd.com>
 <61caf661-a844-47b6-87b5-e7b71c3cd6b3@amd.com>
 <3aeba017-08b7-4554-9c71-e031c42e8a21@amd.com>
In-Reply-To: <3aeba017-08b7-4554-9c71-e031c42e8a21@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Sep 2026 10:41:14 -0400
X-Gm-Features: AcwNN1UwxyKbWAKON8YlzHMDdcXhTkk9QuThLGNo78ewQZGJIivqF-B0PActm2g
Message-ID: <CADnq5_PBQbLQ99c_uW6FCm4SOhLUrbC38TdcJsZ2pMO8o_EV1w@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap
 handler infrastructure
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
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

On Thu, Sep 10, 2026 at 4:25=E2=80=AFAM SRINIVASAN SHANMUGAM
<srinivasan.shanmugam@amd.com> wrote:
>
>
> On 9/10/2026 12:27 PM, Lazar, Lijo wrote:
>
>
>
> On 10-Sep-26 11:43 AM, SRINIVASAN SHANMUGAM wrote:
>
>
> On 9/10/2026 2:20 AM, Alex Deucher wrote:
>
> On Wed, Sep 9, 2026 at 4:42=E2=80=AFPM Alex Deucher<alexdeucher@gmail.com=
> wrote:
>
> On Sat, Sep 5, 2026 at 4:55=E2=80=AFAM Srinivasan Shanmugam
> <srinivasan.shanmugam@amd.com> wrote:
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
>    - Per-VM BO (not device-level) =E2=80=94 same model as page tables
>    - Fixed VA in each VM's address space =E2=80=94 same VA, different phy=
sical BO
>    - Read-only from GPU =E2=80=94 kernel CPU updates it via CPU mapping
>    - Treat allocation/free lifecycle identical to page tables
>
> Suggested-by: Christian K=C3=B6nig<christian.koenig@amd.com>
> Suggested-by: Alexander Deucher<alexander.deucher@amd.com>
> Cc: Lijo Lazar<lijo.lazar@amd.com>
> Cc: Timur Krist=C3=B3f<timur.kristof@gmail.com>
> Cc: Samuel Pitoiset<hakzsam@gmail.com>
> Cc: Natalie Vock<natalie.vock@gmx.de>
> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
> Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
>   5 files changed, 110 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index 3ca187f5ade8..5624a5ab5c62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
>          void (*print_l2_protection_fault_status)(struct amdgpu_device *a=
dev,
>                                                   uint32_t status);
>          uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush=
_type);
> +       void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
>   };
>
>   struct amdgpu_vmhub {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_trap.c
> index 623cac6781be..e913488ca3fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>
>          amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
>          adev->trap_info =3D no_free_ptr(trap_info);
> +       amdgpu_trap_program_kernel_vmids(adev);
>
>          return 0;
>   }
> @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
>          adev->trap_info =3D NULL;
>   }
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
>   static int amdgpu_trap_map_region(struct amdgpu_device *adev,
>                                    struct amdgpu_vm *vm,
>                                    struct amdgpu_trap_obj *cwsr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_trap.h
> index 7f83174a4742..9be5035abd1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> @@ -155,4 +155,11 @@ int amdgpu_trap_set_trap_debug_flag(struct amdgpu_de=
vice *adev,
>                                      struct amdgpu_trap_obj *cwsr_obj,
>                                      bool enabled);
>
> +/* Kernel queue trap handler =E2=80=94 per-VM TMA and register programmi=
ng */
> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev);
> +int  amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
> +                                struct amdgpu_vm *vm);
> +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
> +                               struct amdgpu_vm *vm);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index de3ef9ce2234..f5e228d4bfb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2640,6 +2640,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
>          if (r)
>                  goto error_free_root;
>
> +       if (amdgpu_trap_is_enabled(adev)) {
> +               r =3D amdgpu_trap_vm_kq_tma_alloc(adev, vm);
> +               if (r)
> +                       goto error_free_root;
> +       }
> +
>          r =3D amdgpu_vm_create_task_info(vm);
>          if (r)
>                  dev_dbg(adev->dev, "Failed to create task info for VM\n"=
);
> @@ -2774,6 +2780,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm)
>                  amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
>          }
>
> +       if (vm->kq_tma_bo)
> +               amdgpu_trap_vm_kq_tma_free(adev, vm);
> +
>          amdgpu_vm_pt_free_root(adev, vm);
>          amdgpu_bo_unreserve(root);
>          amdgpu_bo_unref(&root);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index dd825e179979..064f95a83790 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -25,6 +25,7 @@
>   #define __AMDGPU_VM_H__
>
>   #include <linux/idr.h>
> +#include <linux/iosys-map.h>
>   #include <linux/kfifo.h>
>   #include <linux/rbtree.h>
>   #include <drm/gpu_scheduler.h>
> @@ -488,6 +489,18 @@ struct amdgpu_vm {
>
>          /* cached fault info */
>          struct amdgpu_vm_fault_info fault_info;
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
>
> These should be the same for both user and kernel queues.  The only
> difference is who manages the vmids (driver vs MES).  They are per
> vmid so it doesn't matter whether it's a kernel queue or user queue.
>
> I would merge these patch sets.  The trap handling is the same for
> both kernel queues and user queues.  The only difference for kernel
> queues is that the driver has to set the TBA/TMA registers while
> MES/KIQ handles it for user queues.  At vm_init time, allocate the
> memory for the trap handler, copy the trap handler to the memory and
> add the mapping to the GPUVM address space.  Then in gfxhub init,
> program the TBA/TMA registers for the kernel managed vmids.  Finally,
> add the IOCTL to set/clear the second level trap handler and validate
> the user supplied GPU VA.
>
>
> Hi Alex,
>
> Thank you for the review. I have few questions before proceeding with the=
 implementation.
>
> I looked at how KFD handles this today in |kfd_process.c|:
>
> /* KFD writes second-level TBA/TMA into first-level TMA */
> iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
>               uint64_t, tba_addr);
> iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + sizeof(uint64_t),
>               uint64_t, tma_addr);
>
> Where |KFD_CWSR_TMA_OFFSET =3D AMDGPU_GPU_PAGE_SIZE + 2048 =3D 0x1800|. K=
FD uses physical GPU addresses for TBA/TMA registers, not VM virtual addres=
ses.
>
>
> KFD doesn't use physical adddress, it uses the below fixed virtual addres=
s.
>
> pdd->qpd.cwsr_base =3D AMDGPU_VA_RESERVED_TRAP_START(pdd->dev->adev)
>
> KFD mechanism is to allocate one BO which is mapped to the above virtual =
address. That BO accounts for both TMA and TBA size. TMA is located at KFD_=
CWSR_TMA_OFFSET within that BO.
>
> TBA region carries the first level handler code. It's not allowed to be o=
verridden by user. Hence when we moved to new design, TBA is kept common fo=
r all user VMs.
>
> TMA BO is the place through where user's second level TMA/TBA addresses a=
re passed and also the place where stack is saved.
>
>                 iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
>                              uint64_t, tba_addr);
>                 iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + sizeof=
(uint64_t),
>                              uint64_t, tma_addr);
>
> What this code does is to write the second level handler tba/tma addresse=
s in the TMA, which is located at KFD_CWSR_TMA_OFFSET within the BO.
>
>
> TMA region is the only variable thing per VM. First level handler code ex=
ecuted is the same for all VMs. So in the new design, we have a first level=
 TBA BO that is shared by all VMs, and that carries first level trap handle=
r code. The second level TBA is allocated per VM.
>
> I see Alex is saying the same thing which I asked through a different thr=
ead. There is no need to allocate separate BOs for kernel queues. All you n=
eed to do is program the fixed TBA/TMA first level virtual addresses for no=
n-KFD VMs during init.
>
> Regarding kernel queue draining - my understanding is that the condition =
is no work having that VMID is in progress during the change. So, it may no=
t be required to entirely drain kernel queue.
>
> Thanks,
> Lijo
>
> I would like to take a moment to summarize what has been agreed upon and =
share my thoughts on the remaining open points, to ensure we are all aligne=
d.
>
> What is agreed:
>
> Fixed VA =3D AMDGPU_VA_RESERVED_TRAP_START =E2=80=94 same as KFD
> TMA starts at offset 0x1800 from BO start =E2=80=94 matching KFD_CWSR_TMA=
_OFFSET
> SQ_SHADER_TBA/TMA registers programmed in gfxhub init =E2=80=94 kernel VM=
IDs only
> UQ and KQ series merged into one =E2=80=94 no separate kq_tba_bo/kq_tma_b=
o
> SET_L2_TRAP: evict user queues, ensure no VMID work in progress, write TM=
A, flush TL
>
> Open Point 1 =E2=80=94 Shared TBA or per-VM TBA copy?
>
> Alex said: "copy the trap handler to the memory at vm_init" =E2=86=92 sou=
nds like per-VM copy.
> Lijo said: "TBA is kept common for all user VMs" =E2=86=92 sounds like on=
e shared BO.
>
> IMO: The first-level handler code (ISA binary) is identical across all VM=
s for the same hardware. Based on this, one option is to keep a single shar=
ed device-level TBA BO (adev->trap_info->isa_bo) mapped into each VM at AMD=
GPU_VA_RESERVED_TRAP_START, and allocate only the TMA BO per-VM at vm_init.=
 This avoids duplicating the same ISA binary N times in memory. Please let =
me know if a per-VM TBA copy is preferred instead.
>

Yes, I think we can have 1 global TBA and a per VM TMAs.

> Open Point 2 =E2=80=94 What happens to AMDGPU_VA_RESERVED_TRAP_UQ_START?
>
> After merging, AMDGPU_VA_RESERVED_TRAP_START covers both UQ and KQ in one=
 buffer.
>
> IMO: Remove AMDGPU_VA_RESERVED_TRAP_UQ_START from the reserved VA space e=
ntirely since it is no longer needed.
>

As long as the sizes are correct.  We need to make sure we have the
sizes and the locations for the TBA and TMA correct.

> Open Point 3 =E2=80=94 When to set TRAP_EN?
>
> IMO: Set TRAP_EN at gfxhub init time. Since the per-VM TMA BO is always a=
llocated at vm_init before any work is submitted, AMDGPU_VA_RESERVED_TRAP_S=
TART is always valid when any shader executes. No need to defer.
>

Yes.

> Open Point 4 =E2=80=94 How to ensure no VMID work is in progress?
>
> When SET_L2_TRAP is called, the TMA slots must be written only when no GP=
U work is actively executing under that VMID. One option is to use amdgpu_v=
m_wait_idle() before writing the TMA slots, which waits for all pending GPU=
 work in the VM to complete. This is already used in the existing trap hand=
ler code for the same purpose. Please confirm if this is sufficient or if a=
 different mechanism is needed.
>

For user queues, we can just unmap the queues.  For kernel queues,
you'd need to wait for the VM to be idle and take the appropriate
locks to ensure that that VM doesn't get used while you are updating
the TMA.

Alex

> Please confirm or correct any of the above
>
> I would greatly appreciate it if anyone has a different perspective on an=
y of the above or anything missing to be included or added  =E2=80=94 so th=
at the design is aligned with everyone.
>
> Regards,
>
> Srini
>
> Question 1 =E2=80=94 Which fixed GPU virtual address for the merged buffe=
r?
>
> KFD uses physical addresses for the TBA/TMA registers. Our design maps th=
e buffer into each VM at a fixed virtual address for page table isolation. =
Should the merged per-VM buffer use | AMDGPU_VA_RESERVED_TRAP_UQ_START| as =
the fixed VA? Or a different address?
>
> Question 2 =E2=80=94 TMA offset inside the merged buffer =E2=80=94 0x1800=
 or 0x2000?
>
> KFD places the TMA section at offset |0x1800| from the TBA start (| KFD_C=
WSR_TMA_OFFSET|). The current UQ design uses offset |0x2000| (| AMDGPU_TRAP=
_TBA_MAX_SIZE|). After merging into one per-VM buffer, should TMA start at =
|0x1800| to match KFD's layout?
>
> Question 3 =E2=80=94 When should TRAP_EN be set?
>
> When programming |SQ_SHADER_TBA_HI| for kernel VMIDs, should |TRAP_EN| be=
 set only after the per-VM buffer is fully mapped? Or is it safe to set it =
at boot time since TMA slots start zeroed (meaning no second- level handler=
 installed yet)?
>
> Question 4 =E2=80=94 Drain kernel queues before writing second-level hand=
ler?
>
> When |SET_L2_TRAP| is called, user queues are evicted and TLB is flushed =
before writing. After the merge, kernel queue VMIDs also read from the same=
 TMA. Should kernel queue work be drained as well before writing the second=
-level handler addresses?
>
> Thanks,
> Srini
>
>
