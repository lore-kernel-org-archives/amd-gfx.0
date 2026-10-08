Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31814CA600F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1033310FD63;
	Thu,  8 Oct 2026 09:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W4hPOrB1";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD40310FD5D
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 09:49:30 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6af9cc73235so1001537a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 02:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791452969; cv=none;
 d=google.com; s=arc-20260327;
 b=p4mf1/7VM3RpgOIDFWYps2jPFHzlIa02+9XjwkXjUIEXxGxyHq/nIDgSuKj+qEfYX1
 iEhN4WciMAzCuwQLWHK/tVGB/rhzMJ2xt7BGr8E8VgtE5fZpMAbVFr8knZ4NhKOlpyc9
 TfGU0poYfAFYLG7P87GjcS8RHYbr0mliKnCI9wKQ4oXPO3184GfVyxyWf2cWI4v5ey4+
 +cutqueZ76Ks68vA92b3tL/tIE+9XXex0iYjXeMwzaxVASTQByYeqy0hfDSxYnAEkN1g
 8SKqLnIt3ZtlWkbKOPZGwLJQhkKvp7RNZBfu6b6MuVeN3ojzVu0NiEIyPF9gL7MDoZFU
 djWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kFul20M1kAj6OL6A2UXelET2OX/eEgeEYys9+x/QKks=;
 fh=Grz8QArY2f48Ga98yM82yXGSpBlRDHeAV9afm3mfz+4=;
 b=onPhKQ6LZqjTm8ziLJLNAqkoXi3qCDSzFLa6cBE2+7TagJOAAz3AvLIe4/5HqKZ/9z
 cPS/CIWUaiMrD54MqMKNJZmnAuibpA0VNm/w1YqI8mLZw45zjlGoXG0acN8NWmL53LcS
 P1RYHQYB92JI/uqk5WyBGXjJUYU1znhNnxgPNgm4qriLoFos8M7Rgk6iSfaRhHWW+iNv
 5nQnJ1nj8OgISeORFN9DbCZf9oqLe5yCLWhCGOO2yk8l4C0FI8tdedum24oUXEBw5OoG
 dHKhbdtyZ62qceUgjfgVoIP2fP0KLbr3tj0EHP7VmJzKvYUiovt3pu99VYmphst2w6eQ
 tbHg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791452969; x=1792057769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kFul20M1kAj6OL6A2UXelET2OX/eEgeEYys9+x/QKks=;
 b=W4hPOrB17yiREqsP5JTQ2cvzil0QMlH7vcEOnwbFMqhCpW1uBMsqOKupKUg6jAvvUW
 QHCSk99PB0Ej9A8Cz30We4VQ24ui6CBaSE6qv4wB0sgRDv3Srf5ZxCNTMlw7olan6Pa+
 g6a58y6XvLSiYBHY1TSaAac/dZdIdpS5pJIzqCjjvkDzyhTydi7zBDQJbEeL4vxCMuUb
 OGM79LB6DUqlJDBRd2pvhkZsEpRVkkhoI24SMFk7dtfEnuApNyt9iNJUoQF1EgTHQzmE
 JQrpQKyUB4Q5cX9kYSGFhmXGiIBRoGcfsFCZMVC3p18Y16uasClWwqmPOTZFdrnhLV9n
 4QHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452969; x=1792057769;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kFul20M1kAj6OL6A2UXelET2OX/eEgeEYys9+x/QKks=;
 b=ihAtI1IzWZKymuoDPGRZGK+LPIj/6CVKO+dqjWHoUPD0452Gh2qnzttGpWRiNvDoMV
 it1qBmN2k/nE3HnZt47WzwFmS9zWj77TpD3W5mtV3x9HrXiarV59S50Yc5QUoytpKQhE
 T7diwODdJK396/5LPAE1RvycFkPaVk04i01vmXUyaLWgvH4dBXPbRG0HijvM3SdX2e6V
 8uIEwnC8Fzo72ANjVXjUlaol2QGpMiYPhwkSWCm1h0D+CsVINu5Ne4qvHkKSPkva2cuK
 yvQ4ekK14zjFU5asbNPH2S4iD+XzDkoY8/uPBfLueUma2ji5JXU6YSVSOlh3ROaeixPt
 nWbg==
X-Gm-Message-State: AFuF++mckeDPXDRBrmubDCPbRDDD+m0aFtcbJMXuURtg4ww9JKe5lH7P
 vHQVxk2sB14IZ5QY1VvULuB+zcpAvm5+vUEGZKo0K1nPwNK5ZnXL4ipCTr8a0w57mnzzxqYpr6B
 4Ly2QzBm9A+Tflo4EYCNAUjLjOfUxhn8=
X-Gm-Gg: AYBFou0RudMUh+iAHq51RNgRrDneJBMcAXafXMoNt77mPWDO6fr+2QeSfilRbsDxeCL
 Q9V660TJX/YmXjL4Fclm6dQvhB/xMdKkgOWOVNb3p1awmhE8oaYSQ5cjfdZUmDttl9x4HGf7Kbn
 hVjby8MpImNu1/0YAYmekilU0vZJ4bQgx3lZHGKef/LXO5tqoFy3zJRZR2ZfY4QpiRMvgUCc3Z5
 lmry9C+kmsVhWGrSH6JQAEkJDQw/RzYybXSYK2fU3rjeyTvdAhudcLwhgqCBhwAFVI60h3zsW83
 N2nlXG7eUQtK9u9Mrv4j/7dJY64k64DjT5qlr2nao+hPvhD2YhOX4Q==
X-Received: by 2002:a17:907:7245:b0:c25:f7dc:2dc with SMTP id
 a640c23a62f3a-c3191dec364mr163121366b.29.1791452968781; Thu, 08 Oct 2026
 02:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261007200345.417281-1-jfisher84@gmail.com>
 <e14295dd-c78e-4604-ba38-5a03c8ffa7c4@amd.com>
In-Reply-To: <e14295dd-c78e-4604-ba38-5a03c8ffa7c4@amd.com>
From: John Fisher <jfisher84@gmail.com>
Date: Thu, 8 Oct 2026 22:49:17 +1300
X-Gm-Features: AclHuK-uPsqmYPJBD7A5pjJcEwjLsuclLYCy70EmQi7g3sP-Mv8C_pd3-bIpL0E
Message-ID: <CAC7wNSAWKwwkKat=rGpVQPXMdp7vLERs8X7wE=LdmBX1bL8O4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: wait for pending page table updates before
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

Ok understood. Uninterruptible with no return value check.

Which fence should it wait on, though?

The jobs that race here are the PD/PT clears from the render node's
open, and as far as I can see their fences only end up as BOOKKEEP
fences on the root PD:
amdgpu_vm_pt_clear() commits with a NULL fence, so they never reach
vm->last_update.
Nothing else sets vm->last_update between amdgpu_vm_init() and
ACQUIRE_VM either: amdgpu_seq64_map() goes through
amdgpu_vm_bo_update(), which puts its fence in bo_va->last_pt_update
because the seq64 BO is not always valid; amdgpu_map_static_csa() only
maps; and the PDEs of the new tables stay on vm->kernel.needs_update.
So at this point vm->last_update is still the stub, and a
dma_fence_wait(vm->last_update, false) here would not close the race.

I think maybe two other ways to wait for the VM's own updates:

1. Have amdgpu_vm_pt_clear() commit with &vm->last_update instead of
NULL, and dma_fence_wait(vm->last_update, false) here before it is
dropped. The clears all go through vm->delayed, so the last one covers
the earlier ones.
2. Keep the clears as they are and wait here only for the fences on
the root PD whose owner is AMDGPU_FENCE_OWNER_VM (exporting
amdgpu_sync_get_owner() or adding a small helper to amdgpu_sync.c).


Which would you prefer, or did you have something else in mind?

I'll send a v2 once I've rerun the tests on it.

Thanks,
John


On Thu, 8 Oct 2026 at 21:13, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> On 10/7/26 22:03, John Fisher wrote:
> > amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
> > updates when a KFD process acquires it. It syncs "with the last SDMA
> > update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
> > walks the reservation with DMA_RESV_USAGE_READ, and the VM's own page
> > table jobs (the root clear from amdgpu_vm_init(), and the PD/PT clears
> > and the seq64 mapping from the render node's open) are added by
> > amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP. The CPU path's ow=
n
> > waits (amdgpu_vm_cpu_update(), amdgpu_bo_kmap()) use
> > DMA_RESV_USAGE_KERNEL. None of them waits for a clear that is still
> > queued.
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
> > Wait for every fence on the root PD's reservation before switching the
> > update functions. With this the same client reads the handler 10 of 10
> > times, 8 busy queues on the 4 compute slots complete in 5 of 5 runs
> > (1 of 6 before), and two processes with 8 queues each complete together=
,
> > with no fault.
> >
> > Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the depe=
ndent read fences")
> > Cc: stable@vger.kernel.org # v6.16+
> > Cc: Prike Liang <Prike.Liang@amd.com>
> > Signed-off-by: John Fisher <jfisher84@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 29187fabc..8d0c03a40 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2736,11 +2736,20 @@ int amdgpu_vm_make_compute(struct amdgpu_device=
 *adev, struct amdgpu_vm *vm)
> >                   "CPU update of VM recommended only for large BAR syst=
em\n");
> >
> >         if (vm->use_cpu_for_update) {
> > -               /* Sync with last SDMA update/clear before switching to=
 CPU */
> > -               r =3D amdgpu_bo_sync_wait(vm->root.bo,
> > -                                       AMDGPU_FENCE_OWNER_UNDEFINED, t=
rue);
> > -               if (r)
> > +               /*
> > +                * Sync with the last SDMA update/clear before switchin=
g to CPU
> > +                * updates. The VM's own page table updates are tracked=
 with
> > +                * DMA_RESV_USAGE_BOOKKEEP on the root PD, which
> > +                * amdgpu_bo_sync_wait() does not wait for: a clear of =
a PD still
> > +                * pending here lands after the CPU has written its ent=
ries.
>
> That comment is a bit superfluous, it describes the what and not the why.
>
> Just keep the "Sync with last SDMA update/clear before switching to CPU" =
or maybe change to "Sync with the last async SDMA update".
>
> > +                */
> > +               long t =3D dma_resv_wait_timeout(vm->root.bo->tbo.base.=
resv,
> > +                                              DMA_RESV_USAGE_BOOKKEEP,=
 true,
> > +                                              MAX_SCHEDULE_TIMEOUT);
>
> That is quite suboptimal, we don't want to wait for the BOOKKEEP fences h=
ere. And drop the return value checking and wait uninterruptible.
>
> Regards,
> Christian.
>
> > +               if (t < 0) {
> > +                       r =3D t;
> >                         goto unreserve_bo;
> > +               }
> >
> >                 vm->update_funcs =3D &amdgpu_vm_cpu_funcs;
> >                 r =3D amdgpu_vm_pt_map_tables(adev, vm);
> > --
> > 2.55.0
> >
>
