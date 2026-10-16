Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07D5CC6B2D
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 03:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8288810E26B;
	Fri, 16 Oct 2026 03:25:45 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E323B10E26B
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 03:25:39 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6b1d8944cb0so6967717a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 20:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792121138; cv=none;
 d=google.com; s=arc-20260327;
 b=JiZgpUSVTWf1+30EN1FKWY2OYeVdXQkRMo8ER3I1atOwhZ1Z0vpSNn+KMTfxgmw0M6
 M55oNLsmJXc1WjinLSTF2HkTZJFzGi6g1ra49yi63jn41jDN/W0IGDnrjzXXwRJpJ96e
 i3Ya8zALKuy44juIVzjtMeg5fCf/zr5rQ/7izbl4tifUxqvIghxvx++0q9oKDKC690jB
 5cqB+cc92Q1aCGqIn9sRjohhVuZb/GwAoO7EEDTDqWtxXLFbnlEcSU/NzlWRgdrvyn3Q
 hTF6EiS5GwnF6qakd8iMWwbivKJyPQE+NgUWs9ihM/mpz1h8kawGKZl1m8hL2pA3q7fD
 BsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LBTssoM2mFnFxVDtlPbTRlVraone7Ifm/DBSAnH2w7Q=;
 fh=Grz8QArY2f48Ga98yM82yXGSpBlRDHeAV9afm3mfz+4=;
 b=Komw3bSg3J3g9oI0Eaca7Dyn+GUsUVfOSYxsOMxKTSQ76qpmrm5AEmfixTxrGH9sTH
 cIvGD/8dRDeWsvPr6XFMrHV80g5+ERcUdTI6DYNG6nWcmuXEiCpv8IlwLwnZrsc+/+KL
 EosJ8D0+RR/tuZIfVd4Rf4AQg2HayI3vDYmWUfo/IY9X8YR31ldTtIFUHDCWY0YWsaYe
 oSfCVzFmVuqZVIj59KKA7q8QwCIf+nrOeWeyvNXejc02I+4nStT/7a+VxM7e1DHxCxH8
 EHbnuHqnDvPNnYnqqcfx0PkCbO94nB8cJCCCao9UvvIeAKJM3Zo7sYsh9S59rdezxlQR
 M4Rg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792121138; x=1792725938; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LBTssoM2mFnFxVDtlPbTRlVraone7Ifm/DBSAnH2w7Q=;
 b=c8ZKZslMZZF4CNAIAaqyLwhBI2P7k0NWru7QMQbH13qeKIbghoBMCxKj4dCBA8CI0E
 /9upD+TvKuaxCQb/n5melDVzHNyE8rx3DULwpHuyywXV1PxG+D5PF9JVTfNZDbDoVfEw
 Imevfh/OUr1LoZvIUkdwQJG1kcnLmkixJthDVTdRf5sR0aHKrqFdU1OCQkoVZa7Bc9sG
 wCVgSV2KBrauW1tJTUWbL4BrhOxgRFVuYkogWLF9MhtzP6EoFVH9+voDb2/hnMwm5n+u
 B25WETGIDrIAa0xwFsQZD33Rrx0wpr9cXoBcuwKIT5TK0W4v8M39YWFYtNl2BY59+wR/
 jZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792121138; x=1792725938;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LBTssoM2mFnFxVDtlPbTRlVraone7Ifm/DBSAnH2w7Q=;
 b=R3kHK+qX/XhBSg7FjtudWYZqI0nR3qUm4st19OEp6U8/rMjOIpSfy5ZLeo0f6RbBtA
 cKUCOVqM+fOMNMH7g77mKmS5FaGeWJFsB+Bkf5pS+v1bK2CXi5L9fTI+gD457n5SHDY8
 Xu+vVOKIWH6c1sq+HjGv7KGtOn23F4qT7L6547bm0WXSjTbJMfzwO5S9mZnToRnRovBs
 VfHBctVc5m94FyOYbpWNYfoJ5JIgVifyhpHfrcnrzxfzNsJBi/Q7q6t7kcfqB0zaU1+z
 kbmdgIFS+mINsx1VYzyPJXr1W4af4cX2db0brMPPZduO2rjxvKPrb6TDBdH9+/rgpb+a
 jAgA==
X-Gm-Message-State: AFq9FYLNQwLLikheAehLW3BmU7H0Bd+/cxZkaUXyukefj0tjwSumP4W/
 5I7hl05r8dXel6KXc+i7dV3hE6XFtsEZ5VkLpsCtra0efI2MroXAGxHcAdMc+tBr/qFoY/PYGJa
 tVijq7MdWsWefOnNQ5oAzvnbwvI2fMJU=
X-Gm-Gg: AYBFou1WTgw6y/I4IFgVZOtdMM9u07eavq5EJkxw4uyNtvKWnRnhGRMYRkRdLpCBr2H
 Xig6Lz6XpmKg7z+6/CwCSYS5L75n3QbTZgtZ6dw4eXO/5AuySxHLcZEWTcyN/ZfSyLTuE2JpMUM
 jKSxSIxCF6o3MSC32jUKQ0lx0O1GOCOabZEwY75HT62W8GkBh7uPH72sRJ83K9hgqSFmcgmO0R6
 fxIKGgpJR6yLjMqfVzThde0XW68wUagVxnnt6mXamkPW6HBIJkLh0HRMkGyzBX1aOIeWZVv9XIE
 xvpyzCsFFEJboSbpb8T5/z/TfRFcgxJvkHeR16yXZ3RmJOpOQywhBFHjM38sFR7H
X-Received: by 2002:a05:6402:2788:b0:6aa:9866:551f with SMTP id
 4fb4d7f45d1cf-6b17c2d755cmr18289668a12.45.1792121137956; Thu, 15 Oct 2026
 20:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261008204517.392180-1-jfisher84@gmail.com>
 <c64df6fa-6734-4c66-8f8b-52e5bd118cdb@amd.com>
In-Reply-To: <c64df6fa-6734-4c66-8f8b-52e5bd118cdb@amd.com>
From: John Fisher <jfisher84@gmail.com>
Date: Fri, 16 Oct 2026 16:25:26 +1300
X-Gm-Features: AclHuK8qA0Y5GArTBwCDOt3PjPocvVW2cHEUBULocqqscDY0UR0zbseYnJIw1eo
Message-ID: <CAC7wNSChWJ3nYY4GPT0Av+CDiudQ346hnxE_U0bfNLVvHdbozw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: wait for pending page table updates before
 switching a VM to CPU updates
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org, 
 Prike Liang <Prike.Liang@amd.com>
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

Thanks Christian. Since I don't have commit access, I assume that if
all looks good the commit will be passed on to be applied?

Thanks,
John

On Fri, 9 Oct 2026 at 20:00, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> On 10/8/26 22:45, John Fisher wrote:
> > amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
> > updates when a KFD process acquires it. It syncs "with the last SDMA
> > update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
> > walks the reservation with DMA_RESV_USAGE_READ, and the clears of the
> > VM's page tables (the root PD from amdgpu_vm_init(), and the PDs/PTs
> > the seq64 mapping allocates at the render node's open) are added there
> > by amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP only:
> > amdgpu_vm_pt_clear() commits them with a NULL fence, so they do not
> > reach vm->last_update. The CPU path's own waits (amdgpu_vm_cpu_update()=
,
> > amdgpu_bo_kmap()) use DMA_RESV_USAGE_KERNEL. None of them waits for a
> > clear that is still queued.
> >
> > When one is, the CPU writes the first entries of the new compute VM (th=
e
> > KFD trap handler's TBA/TMA page at AMDGPU_VA_RESERVED_TRAP_START, mappe=
d
> > during ACQUIRE_VM) into a page directory the SDMA then clears. The
> > entries are gone, the handler's page is unmapped, and the first wave
> > save of any queue of the process faults in the SQC instruction fetch at
> > the handler's address (GCVM_L2_PROTECTION_FAULT_STATUS 0x008012B1,
> > PERMISSION_FAULTS 0xb). The MES then fails REMOVE_QUEUE and SUSPEND, an=
d
> > the device takes a MODE1 reset with VRAM lost on 7.2.9; on 7.3-rc6 the
> > queue is reset instead.
> >
> > The window is the time between the render node's open and ACQUIRE_VM.
> > ROCr spends milliseconds there and is practically never hit; a minimal
> > KFD client that opens the render node and acquires the VM at once is hi=
t
> > most of the time. On a Radeon AI PRO R9700 (gfx1201, Resizable BAR, so
> > vm_update_mode defaults to CPU updates for compute VMs), a wave reading
> > the trap handler's page right after queue creation found it unmapped in
> > 8 of 12 runs; a 5 ms sleep between the open and ACQUIRE_VM made that 0
> > of 9, and the same sleep after queue creation instead 3 of 3.
> >
> > The wait covered these jobs until commit 926c79ad6ecd ("drm/amdgpu:
> > promote the implicit sync to the dependent read fences") narrowed
> > amdgpu_sync_resv() from DMA_RESV_USAGE_BOOKKEEP to DMA_RESV_USAGE_READ;
> > the VM's page table jobs have been added with BOOKKEEP since commit
> > 4247084057cf ("drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2"), so from
> > v6.16 on the sync in amdgpu_vm_make_compute() waits for nothing of
> > them.
> >
> > Record the clears in vm->last_update, as amdgpu_vm_update_pdes() does
> > with its updates, and wait for it, uninterruptibly, before switching th=
e
> > update functions. The clears all go through vm->delayed, so the last on=
e
> > covers the earlier ones; immediate clears are not recorded, as before.
> >
> > With this, on 7.3-rc6 and on 7.2.9, the same client reads the handler
> > 10 of 10 times, 8 busy queues on the 4 compute slots complete in 5 of 5
> > runs on 7.3-rc6 and 3 of 3 on 7.2.9 (1 of 6 before), 16 and 32 queues
> > complete on 7.3-rc6, and two processes with 8 queues each complete
> > together on both, with no fault.
> >
> > Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the depe=
ndent read fences")
> > Cc: stable@vger.kernel.org # v6.16+
> > Cc: Prike Liang <Prike.Liang@amd.com>
> > Signed-off-by: John Fisher <jfisher84@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > v2: wait for vm->last_update, in which amdgpu_vm_pt_clear() now records
> >     the clears, instead of every BOOKKEEP fence on the root PD; wait
> >     uninterruptibly without checking the result; keep the original
> >     comment (Christian)
> > v1: https://lore.kernel.org/amd-gfx/20261007200345.417281-1-jfisher84@g=
mail.com/
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 5 +----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
> >  2 files changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 29187fabc..757a037ed 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2737,10 +2737,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device =
*adev, struct amdgpu_vm *vm)
> >
> >       if (vm->use_cpu_for_update) {
> >               /* Sync with last SDMA update/clear before switching to C=
PU */
> > -             r =3D amdgpu_bo_sync_wait(vm->root.bo,
> > -                                     AMDGPU_FENCE_OWNER_UNDEFINED, tru=
e);
> > -             if (r)
> > -                     goto unreserve_bo;
> > +             dma_fence_wait(vm->last_update, false);
> >
> >               vm->update_funcs =3D &amdgpu_vm_cpu_funcs;
> >               r =3D amdgpu_vm_pt_map_tables(adev, vm);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_pt.c
> > index c03327f12..cdbc2e931 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > @@ -427,7 +427,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
> >       if (r)
> >               goto exit;
> >
> > -     r =3D vm->update_funcs->commit(&params, NULL);
> > +     r =3D vm->update_funcs->commit(&params, &vm->last_update);
> >  exit:
> >       drm_dev_exit(idx);
> >       return r;
>
