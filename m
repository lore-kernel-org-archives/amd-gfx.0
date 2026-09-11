Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1374C88E50
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 14:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2C810E3C9;
	Fri, 11 Sep 2026 14:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KnaJX3/P";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2432D10E3C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 14:10:03 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39666bed442so157835a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 07:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789135802; cv=none;
 d=google.com; s=arc-20260327;
 b=ed5xP+/aD9I2i7+agVu7PNBK39PM/C/cd9y5EfwwDMwdgwGLCNHNqpNEzfOKGx5nfd
 TGrDg7kAxgJ0Vy1+aFQY1usakz0T9e1L+4hfqYFQNV6JTUPjmsx7jAWEnqUHdOG/TQ+7
 6P25C0s0+RdE9OgVoTEp37BX06xhwRCoHPOXjaGm/TLMRoVW3vayZOwuStzPMA0Gj4V8
 czA96/vbK3+5RdMA3aSY/G00ySHOBGwu6QRiZxUZEhXii2nv/VP7MgzDi+DDH6xo1ol/
 tcEmb4EBal+ZtlqwaBZ5Ck9qxi52uCXLTjaEyAI3ummYbYjMmrOQH7ltdVo/cTcnY/MG
 q3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mK7UZOz7AGei+cVJ5CnPJ3gICtIQcQxew8ssrClKBYo=;
 fh=iPGIILBmlML5qZAV29BF6HrE+mmYC0vjY4eHEaTX/Q4=;
 b=gPjnpV1xJSQ0LcRpTl9pNHXnHyQBga6oP4O4H5c3qZRXtkEzpjsBdim09x0hg/KZxn
 ftJvKShkBRRERTJAkRRdYvnrR917tUKU09r2Li2qiDdvctewH9K54CD1TopmKqci+bI7
 k6NRDhYiLPHTYhhvUQ/xYbnYBQmaWmn7SB6sEcW/TU/DhcVR+uvoQkt9s+1Av2craBpA
 eWzpbU0Di3Yj5dTZf54a+DUG0kSkFDPrwL690Af9YWBnezC/gA2YrCopRdWyIy6v7QsE
 a7IjtlpcdtSaAx63TpnQZRL7qrG8qFcd9MohaADljh9GDi6X3SA+YFSLMMtRZ7ns+Ux7
 Ce+A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789135802; x=1789740602; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mK7UZOz7AGei+cVJ5CnPJ3gICtIQcQxew8ssrClKBYo=;
 b=KnaJX3/PFNHqtNkFs5Eu9eQR0J14nQRTSJAIlPXrrLM9njOiPs6Wb7QTk4iNREUOAu
 EU+moAXd9m/LhLzRep9sMs9Nfhq/R+6y3UOAD7e5uWF4VrBc7ukCpwEyPLrhQNvT2aG7
 gKW1OmJP1/0UV5yNn3eWrPYmgzTshQMVZXdNRLNkZGjEadmnkKAnt/h5sYtsSUVJYdPc
 rYMimpRJObvb1ibrWPJlxe1aXGBkjNbrRjNS9vrjNalZsWPPixYALZ5hX2XgFvxnrom7
 uP7ryZ2VPTkXGSg9ueVgvKb3aeO0DpiLB4l8/BoNXb0BsdoZVaYiB7iSgE/CZ7+u42sX
 h81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789135802; x=1789740602;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mK7UZOz7AGei+cVJ5CnPJ3gICtIQcQxew8ssrClKBYo=;
 b=g3ARFA8i0m0B7c/zbW1mMQzCmwmVYj0C9f4pa7EW5boyItbqYb8BaPHT0IdqZtz6Rr
 YH2EqsZYXMRaKC12xmPZ+J6/N9ZKQEH26rp0m1Y35c3uNx0PGrj9hYLukhOPl/HVv80r
 NV6JHrDNfGuS4L7ZTHfdmpBI9d0P0wk4nNgb0mixLFFMTMnDf2hm9mOJpmlrnem+MFGO
 NZ1LJ98ScBgplcYtbuuyyCdA5p0UL4PdL/OqVtOvjlEHshsoIUrMMCpLQPlt91p5nc8N
 Wta9cxAmBKxK0Skphmt9MiGO09jRZ7Vf7d8QTLy31XazAWJlFJXQ+NlXKqPei5kQDFuA
 IjIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT5BtauazQm8KRo21U4/qsXvvF2lZAXMGKjvp6OO68ojvOYeEbowykcKXVKF4CxN5wRtGifHKw@lists.freedesktop.org
X-Gm-Message-State: AFuF++lAuGRmeR1AbRweupAjn7hEbfI5acylOqu/v8iDk/0/F6BR//nb
 /DkrSGm/YkkJwyZtG11cBw/Xp9Fh72oJC1M7e3QfMZMSlMK4SRnaVB6U83Pqb6yw1sdQFqqUWnh
 fqmwRyAQNVQPv7WETx3xc0OpI1HV9VnM=
X-Gm-Gg: AYBFou3OkiWNEWuGJeZUEoP6EJFb7kpFVrF2JZk2hz4eI3YAkPjzkE8AmTGI5aF74GV
 Y0LrllGsesWKKIsdtgmhuMYGpuI38f+edgA13lABNSEIxQNOymgqRtt1Fg2Yf+Wc9cnDuHWhwbX
 nt+MseZaI8aEdf4hQjZ/GUM9RzrcvgBWAWPSH1clLXso5Fl6HFrYONEXKkk811j8ukcWEGCDpx8
 8ZZtIUMukbEOKYjUBF73+OoYZ5NEihfYthvMZOA95PliGc2+iyvBEry7OOvbXUJhTurfvDGVBib
 sRWJgKqSSPIgKFTSBfACDuZ+K6Mir7Rqvj0yDxbWaQb6R/bby0ab84A4oHufucn1eWWbVRaxmv3
 CBugKVJFsrO87KkXNzhh1n6+3VzYOi7TYYz98jQpoWQ==
X-Received: by 2002:a17:90b:3904:b0:396:d27c:8696 with SMTP id
 98e67ed59e1d1-39d9c392a75mr4891489a91.4.1789135802461; Fri, 11 Sep 2026
 07:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
 <4f97a5e8-8bef-4353-9998-9e6daee499d2@amd.com>
 <b652b617-de17-4e11-9492-ffb003a9e51e@amd.com>
 <SA0PR12MB7091A430EEAB0FD042DF601597B02@SA0PR12MB7091.namprd12.prod.outlook.com>
 <CADnq5_N38NE6Q8Bstcwx5aVh5Jfm8yCJO=ffD-vhBND9mZkisw@mail.gmail.com>
 <SA0PR12MB7091203029CC7166AB28355597BF2@SA0PR12MB7091.namprd12.prod.outlook.com>
 <0d91c47d-086f-4fae-a92d-8b69f14410f0@amd.com>
 <CADnq5_Nya37VsLXL+X07HzOG1N9eGvOgCVR+=x_b0Xejh_6WCw@mail.gmail.com>
In-Reply-To: <CADnq5_Nya37VsLXL+X07HzOG1N9eGvOgCVR+=x_b0Xejh_6WCw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Sep 2026 10:09:50 -0400
X-Gm-Features: AcwNN1WIBTkX2RxBpAr8-yvSHQ-5NWUlyFf3sqQ80o-iVa-RMOJEUNBsKuAjLJM
Message-ID: <CADnq5_Pr1LCN_VL7504RMDo+q+MDw3Svj7bG4TS4LgcSSnm5wA@mail.gmail.com>
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

On Fri, Sep 11, 2026 at 10:07=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Thu, Sep 10, 2026 at 1:23=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> =
wrote:
> >
> >
> >
> > On 10-Sep-26 7:36 AM, Lazar, Lijo wrote:
> > > AMD General
> > >
> > >
> > > My question was slightly different context - The first level TMA is
> > > fetched based on VMID of execution context .
> > >
> > > If user waves are executed in IB VMID context (even though submitted
> > > through kernel queues), do we need to allow user to install handlers =
for
> > > kernel VMIDs?
> > >
> >
> >
> > To clarify -
> >
> > For other non-zero VMIDs, is there a need to allocate separate BOs like
> > kq_tba_bo/kq_tma_bo?
> >
> > Can't we keep just one set of tba/tma bo for first level? User handling
> > may always be through second level as the ioctl allows user to install
> > only second level ones. If separate handling is required based on queue
> > type (kq vs uq), I think trap handler can identify the queue based on
> > doorbell offset.
>
> Maybe I'm misunderstanding how the second level registration works.  I
> thought the pointer to the second level trap handler was changed in
> the first level trap handler when the user registers the second level
> trap handler. If so, we need a per VM BO for the first level trap
> handler.  Then the second level trap handler is either NULL or
> whatever the user registers for their GPU VM.
>

I guess the TBA and TMA could be split and the TBA could be a common
allocation and the TMA could be per VM.  Was that what you were
getting at?

Alex

> Alex
>
> >
> > Thanks,
> > Lijo
> >
> > > Thanks,
> > > Lijo
> > > ---------------------------------------------------------------------=
---
> > > *From:* Alex Deucher <alexdeucher@gmail.com>
> > > *Sent:* Thursday, 10 September 2026 00:24:03
> > > *To:* Lazar, Lijo <Lijo.Lazar@amd.com>
> > > *Cc:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Koenig,
> > > Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org <amd-
> > > gfx@lists.freedesktop.org>; Timur Krist=C3=B3f <timur.kristof@gmail.c=
om>;
> > > Samuel Pitoiset <hakzsam@gmail.com>; Natalie Vock <natalie.vock@gmx.d=
e>
> > > *Subject:* Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-
> > > level trap handler infrastructure
> > > On Wed, Sep 9, 2026 at 2:05=E2=80=AFPM Lazar, Lijo <Lijo.Lazar@amd.co=
m> wrote:
> > >>
> > >> AMD General
> > >>
> > >>
> > >> One generic question - I am assuming the overall purpose is to debug=
 a user job submitted to kernel queue. When user IBs are submitted to kerne=
l queue, those IBs carry VMID assigned to user. When wave submitted through=
 such a job encounters a trap, isn't it having the user VMID? If so, when i=
s this kernel queue related TBA/
> > > TMA helpful or selected? If it's only for driver submitted jobs, then
> > > this control to user is not required.
> > >
> > > Each fpriv GPUVM will have a copy of the first level trap handler
> > > mapped at the same GPU virtual address.  If the user requests a secon=
d
> > > level trap handler, their copy of the first level trap handler will b=
e
> > > updated to point to the provided second level trap handler.
> > >
> > > Alex
> > >
> > >>
> > >> Thanks,
> > >> Lijo
> > >> ________________________________
> > >> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> > >> Sent: Wednesday, 09 September 2026 18:32:03
> > >> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.K=
oenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> > >> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; T=
imur Krist=C3=B3f <timur.kristof@gmail.com>; Samuel Pitoiset <hakzsam@gmail=
.com>; Natalie Vock <natalie.vock@gmx.de>
> > >> Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-l=
evel trap handler infrastructure
> > >>
> > >>
> > >>
> > >> On 9/9/2026 1:15 PM, Lazar, Lijo wrote:
> > >>
> > >>
> > >>
> > >> On 05-Sep-26 1:49 PM, Srinivasan Shanmugam wrote:
> > >>
> > >> MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not progr=
am
> > >> SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queue=
s
> > >> via ADD_QUEUE with map_legacy_kq=3D1 but does not set trap handler s=
tate.
> > >> On GFX10 and earlier HWS-based hardware, the driver programs trap
> > >> registers via SRBM select for KFD queues but no equivalent exists fo=
r
> > >> driver-managed kernel queue VMIDs.
> > >>
> > >> Add a vmhub callback program_kernel_trap_vmids() so each gfxhub vers=
ion
> > >> can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
> > >> device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
> > >> address AMDGPU_VA_RESERVED_TRAP_START =E2=80=94 each VM maps its own=
 kq_tma_bo
> > >> there, so per-VM isolation is handled entirely by page tables withou=
t
> > >> needing to reprogram the register per job or per submission.
> > >>
> > >> The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
> > >> (parallel to page table allocation) and mapped read-only into the GP=
U VM
> > >> at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the second-l=
evel
> > >> handler address into it via kq_tma_map when userspace calls SET_L2_T=
RAP.
> > >> The first-level CWSR handler reads this address to chain to the
> > >> second-level handler when a shader exception fires.
> > >>
> > >> This design is:
> > >>    - Per-VM BO (not device-level) =E2=80=94 same model as page table=
s
> > >>    - Fixed VA in each VM's address space =E2=80=94 same VA, differen=
t physical BO
> > >>    - Read-only from GPU =E2=80=94 kernel CPU updates it via CPU mapp=
ing
> > >>    - Treat allocation/free lifecycle identical to page tables
> > >>
> > >> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >> Suggested-by: Alexander Deucher <alexander.deucher@amd.com>
> > >> Cc: Lijo Lazar <lijo.lazar@amd.com>
> > >> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > >> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> > >> Cc: Natalie Vock <natalie.vock@gmx.de>
> > >> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > >> Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
> > >> ---
> > >>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
> > >>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++++=
++++
> > >>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
> > >>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
> > >>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
> > >>   5 files changed, 110 insertions(+)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_gmc.h
> > >> index 3ca187f5ade8..5624a5ab5c62 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > >> @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
> > >>       void (*print_l2_protection_fault_status)(struct amdgpu_device =
*adev,
> > >>                            uint32_t status);
> > >>       uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flu=
sh_type);
> > >> +    void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
> > >>   };
> > >>     struct amdgpu_vmhub {
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_trap.c
> > >> index 623cac6781be..e913488ca3fa 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> > >> @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
> > >>         amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
> > >>       adev->trap_info =3D no_free_ptr(trap_info);
> > >> +    amdgpu_trap_program_kernel_vmids(adev);
> > >>         return 0;
> > >>   }
> > >> @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *ade=
v)
> > >>       adev->trap_info =3D NULL;
> > >>   }
> > >>   +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
> > >> +{
> > >> +    struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];
> > >> +
> > >> +    if (!amdgpu_trap_is_enabled(adev))
> > >> +        return;
> > >> +    if (!hub->vmhub_funcs || !hub->vmhub_funcs->program_kernel_trap=
_vmids)
> > >> +        return;
> > >> +
> > >> +    hub->vmhub_funcs->program_kernel_trap_vmids(adev);
> > >> +}
> > >> +
> > >> +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
> > >> +                struct amdgpu_vm *vm)
> > >> +{
> > >> +    void *cpu_addr;
> > >> +    uint64_t va;
> > >> +    int r;
> > >> +
> > >> +    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> > >> +
> > >> +    r =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_=
SIZE,
> > >> +                    AMDGPU_GEM_DOMAIN_GTT, &vm->kq_tma_bo,
> > >> +                    NULL, &cpu_addr);
> > >> +    if (r)
> > >> +        return r;
> > >> +
> > >> +    if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
> > >> +        iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
> > >> +                      (void __iomem *)cpu_addr);
> > >> +    else
> > >> +        iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);
> > >> +
> > >> +    vm->kq_tma_va =3D amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
> > >> +    if (!vm->kq_tma_va) {
> > >> +        r =3D -ENOMEM;
> > >> +        goto err_free_bo;
> > >> +    }
> > >> +
> > >> +    va =3D AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MA=
SK;
> > >>
> > >>
> > >> Is this the same address used for mapping of TMA for user queues?
> > >>
> > >> No =E2=80=94 these are different, non-overlapping addresses in the r=
eserved VA region:
> > >>
> > >> AMDGPU_VA_RESERVED_TRAP_UQ_START =3D TRAP_START =E2=88=92 12 KiB
> > >> =E2=86=92 used for UQ first-level TBA (8 KiB) + TMA (4 KiB)
> > >> AMDGPU_VA_RESERVED_TRAP_START =3D SEQ64_START =E2=88=92 64 KiB
> > >> =E2=86=92 used for KQ per-VM TMA (this patch)
> > >>
> > >> The UQ region sits immediately below the KQ region in the reserved V=
A
> > >> space. No collision between the two mappings in the same VM.
> > >>
> > >> Regards, Srini
> >
