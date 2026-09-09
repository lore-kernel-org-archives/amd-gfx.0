Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CD7C79FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 18:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579E110E15B;
	Wed,  9 Sep 2026 18:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PDUvMJLn";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7FE210E15B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 18:54:15 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39d67a9ae5bso113771a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 11:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788980055; cv=none;
 d=google.com; s=arc-20260327;
 b=mtyZ962RCZmmWNAuQAs2bPP6inIzWlyIzBSTfNWvQ/15m4eDE5sexxp5pLUySjkUNu
 oxulU3vaXg26BfTTfdU7Nytnr6Fq7+QaI7XvgioDFIZ16Lw/EJmo7kFJPdBQWBby0Ihh
 ZdieLsDOZDXZHIt3Wjueek4uRsn2ax/YGXp70h+2vkL8mG6+i9j9ReQHL8tulIdRw/3D
 fLb+y9Qcx4ZacTXfxdNZNnYcFA7FFAAUW5I4QHUYaltp82iGKQnSOhgwoNqacw55+wlU
 niWpQb31MBbPk29ahA5ZTmUIkVEA16IofyfGGHPCpJbpLO89kl3DvBdTtfeBsAhMDQD5
 Sycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8u/2dRCvE7wckejeAoL3k1ATiyuFZH3i+/K5Xxew/VU=;
 fh=eIfzQD8C0tFbnxeC7haRgk9zuGVdSfTk9SauP41yBvQ=;
 b=srXsYegU1ZUKclfiHc3Eqv6zDWE9XvxIe3jWI+P2M5Thsp5UiV0tzW55GKnQQsJ7Rt
 x6nUKqQ/ihO4a98z4Oqal/6Ihbic8fM87EcLRMa0U+1YNEv6TbBfopltuiHDdaKHudxs
 JxWK/pk3c1uf86d3jey70FS7W2nLVOvwYsIAbKreKYS46IXQU8XttzNx3lQoWQ/JPxsB
 vgDeU1NUVpyhMhFM21csj7cPylAYofOjL4ucHvtVOlUtzXWWygc1aCBwODPl8oEo2YlN
 b/74MzbVWjhQKQl3679AVv6LAqcV4F8W/TBRQDv+W3s/hY/mjpkZK/L1zUXwAh4JGFmB
 XL6A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788980055; x=1789584855; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8u/2dRCvE7wckejeAoL3k1ATiyuFZH3i+/K5Xxew/VU=;
 b=PDUvMJLn9t/0HdeM13pI7V05N2SSzQ98Wa8XieV+lcKAx3mzESEt0eoFIfwqZbeBVz
 UJh70W3vZvngQtGZR1gYKDWoKlBjiFL+hEDP6bQNOGbA4TaKOLZL69PNFvZojz3wovF0
 6snU6Wv/vgM4GdLw4xDo86vxzx5wqhfd+UT+3y6vNSTg4e4VxHfboO82dLH4TXhPWLyb
 XivZhJytDim1+s5fecDjyuz3dUCo5EDErWChLJpKn2x3d60ADNH7ESC0toDJ8vjuPc+e
 xlelmcorv12MpGDUA983sQ57zWfky8Ps+gPzl54R+d9Vxf/Pyyv6lmpsOZiwJlZk+dcM
 mbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788980055; x=1789584855;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8u/2dRCvE7wckejeAoL3k1ATiyuFZH3i+/K5Xxew/VU=;
 b=kf3KzYw//IuYRs4LC0viC0eOVfqXcbh+0TRYl3Xmh3h2QmyN4EpSuA3fprzpEkW+P/
 3RAQ15WkTvLgYRFC+tSWVNLXf/JDZiAfTrARzTu5eog6HfNVfvSSIy7mHrMyHUZ6nqpz
 Ly7Kq4pvmlSNXbBqp3HjzuxL38PZ/hqGokpK9rKKIEr48Kn+UBqyJ8MXn4SD3oLRdc0g
 uoE6R+j9ks7u9MaW8aiyz8FETBZeq8Ku/dFW3rYCzUEddrQrm+u5KsAnPl+8KW31iUzs
 DJhlLpQDAPzC/qx4nbU9N7tQ3WnLWKXldsxqe1ve6/Mw09nPKj7/UZYK9Y8ARMCt2dKo
 Makw==
X-Forwarded-Encrypted: i=1;
 AKwUvByb8B2g4h9PYEuQ7K/V1vvt9gZeX2VXUvIjk5t14xfSr4C7XVsmwkxVnxwpS4Yb+SgKMyVVVu0H@lists.freedesktop.org
X-Gm-Message-State: AFuF++nLbmgixbFUxWatBX3S22VsPUp6cQdwjlCJpyZlTsWnS0tUlCQJ
 kJNDIgB40Kn8tPzWywcjGrMuhEUHV9amIP5IYnkzoh8oD3fWXZH2E9M7BSlJ5wuiz7RePu8j1Ih
 e9JEQ2nTtxkAlmRXQJFpsKCOyqVkQdiiG5A==
X-Gm-Gg: AYBFou2+b9vpvPx8sT4YjSE6KCRQuDWoHcFYXYp2uUoraiXD1cqqrWpe1GUdEPWtIAf
 jIoiSlHTfn1xgxVt3YWryANFeyZIDoXgGH/jVFiysAgXNNAYHUMmr2O9GGyT4rCSvda7cT2ybCi
 bDS+nc3ebPw2Q1G3CBCVOOuFIEH3edYzowJOkHutfjhBVDE4zRObkKPCzsInbzTXLJ6KcG6MM3f
 bp7h6jPVJx7JFU05xwlnu6WX+BIJysD7Rg5NiNsxgH83vrvMBtp8U4HlSQMUUkJBpFkDcqH8w1j
 utlDAlYbvChTSd0NIijrGApZJYa/vqjx97K+usIvowt261ElLhon2xJuX4t+PQc1S5IG57OP9mN
 PVOE2qLRoB84PxJJBmLo+J3Phfasz/+dQUFHo1bE8aw==
X-Received: by 2002:a17:90b:562b:b0:396:d27b:86a4 with SMTP id
 98e67ed59e1d1-39b3d5f2c09mr29043619a91.2.1788980055089; Wed, 09 Sep 2026
 11:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
 <4f97a5e8-8bef-4353-9998-9e6daee499d2@amd.com>
 <b652b617-de17-4e11-9492-ffb003a9e51e@amd.com>
 <SA0PR12MB7091A430EEAB0FD042DF601597B02@SA0PR12MB7091.namprd12.prod.outlook.com>
In-Reply-To: <SA0PR12MB7091A430EEAB0FD042DF601597B02@SA0PR12MB7091.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Sep 2026 14:54:03 -0400
X-Gm-Features: AcwNN1VVHMjTVPnZox70kirMN0WjkX8cOED-vwJc-cfvFymCgFVFEuv8VcWt95U
Message-ID: <CADnq5_N38NE6Q8Bstcwx5aVh5Jfm8yCJO=ffD-vhBND9mZkisw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap
 handler infrastructure
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
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

On Wed, Sep 9, 2026 at 2:05=E2=80=AFPM Lazar, Lijo <Lijo.Lazar@amd.com> wro=
te:
>
> AMD General
>
>
> One generic question - I am assuming the overall purpose is to debug a us=
er job submitted to kernel queue. When user IBs are submitted to kernel que=
ue, those IBs carry VMID assigned to user. When wave submitted through such=
 a job encounters a trap, isn't it having the user VMID? If so, when is thi=
s kernel queue related TBA/TMA helpful or selected? If it's only for driver=
 submitted jobs, then this control to user is not required.

Each fpriv GPUVM will have a copy of the first level trap handler
mapped at the same GPU virtual address.  If the user requests a second
level trap handler, their copy of the first level trap handler will be
updated to point to the provided second level trap handler.

Alex

>
> Thanks,
> Lijo
> ________________________________
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Wednesday, 09 September 2026 18:32:03
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Timur =
Krist=C3=B3f <timur.kristof@gmail.com>; Samuel Pitoiset <hakzsam@gmail.com>=
; Natalie Vock <natalie.vock@gmx.de>
> Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level =
trap handler infrastructure
>
>
>
> On 9/9/2026 1:15 PM, Lazar, Lijo wrote:
>
>
>
> On 05-Sep-26 1:49 PM, Srinivasan Shanmugam wrote:
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
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alexander Deucher <alexander.deucher@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
>       void (*print_l2_protection_fault_status)(struct amdgpu_device *adev=
,
>                            uint32_t status);
>       uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush_ty=
pe);
> +    void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
>   };
>     struct amdgpu_vmhub {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_trap.c
> index 623cac6781be..e913488ca3fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>         amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
>       adev->trap_info =3D no_free_ptr(trap_info);
> +    amdgpu_trap_program_kernel_vmids(adev);
>         return 0;
>   }
> @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
>       adev->trap_info =3D NULL;
>   }
>   +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
> +{
> +    struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];
> +
> +    if (!amdgpu_trap_is_enabled(adev))
> +        return;
> +    if (!hub->vmhub_funcs || !hub->vmhub_funcs->program_kernel_trap_vmid=
s)
> +        return;
> +
> +    hub->vmhub_funcs->program_kernel_trap_vmids(adev);
> +}
> +
> +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
> +                struct amdgpu_vm *vm)
> +{
> +    void *cpu_addr;
> +    uint64_t va;
> +    int r;
> +
> +    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +
> +    r =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
> +                    AMDGPU_GEM_DOMAIN_GTT, &vm->kq_tma_bo,
> +                    NULL, &cpu_addr);
> +    if (r)
> +        return r;
> +
> +    if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
> +        iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
> +                      (void __iomem *)cpu_addr);
> +    else
> +        iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);
> +
> +    vm->kq_tma_va =3D amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
> +    if (!vm->kq_tma_va) {
> +        r =3D -ENOMEM;
> +        goto err_free_bo;
> +    }
> +
> +    va =3D AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK;
>
>
> Is this the same address used for mapping of TMA for user queues?
>
> No =E2=80=94 these are different, non-overlapping addresses in the reserv=
ed VA region:
>
> AMDGPU_VA_RESERVED_TRAP_UQ_START =3D TRAP_START =E2=88=92 12 KiB
> =E2=86=92 used for UQ first-level TBA (8 KiB) + TMA (4 KiB)
> AMDGPU_VA_RESERVED_TRAP_START =3D SEQ64_START =E2=88=92 64 KiB
> =E2=86=92 used for KQ per-VM TMA (this patch)
>
> The UQ region sits immediately below the KQ region in the reserved VA
> space. No collision between the two mappings in the same VM.
>
> Regards, Srini
