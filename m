Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A6DCD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 07:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7A51121E8;
	Mon,  8 Apr 2024 07:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=natalenko.name header.i=@natalenko.name header.b="syLOUL3f";
	dkim-atps=neutral
X-Greylist: delayed 567 seconds by postgrey-1.36 at gabe;
 Fri, 05 Apr 2024 14:50:48 UTC
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32BF510E04F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Apr 2024 14:50:48 +0000 (UTC)
Received: from spock.localnet (unknown [94.142.239.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by prime.voidband.net (Postfix) with ESMTPSA id 149D1635B07C;
 Fri,  5 Apr 2024 16:41:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1712328078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C6WJ1Th+gXaPPEluWh6/lUCtRQ0Dpr2DrQJAf3SqoZE=;
 b=syLOUL3fDJBMnNhV1arhLzsjp6vQvoMKnXCxwcyHBP/CmWvskgfb0+ajpzfTCTetp9vMGx
 q5LEID994CH8ou1nIk/0NTJUNkFn0S9XUpS0ea3Bj4oA98Gcq4F2o3K6oblPP9UoWDbKu8
 q+mydRXYEk68gVxSVp4y6xqxUjtW3a8=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: once more fix the call oder in
 amdgpu_ttm_move()
Date: Fri, 05 Apr 2024 16:41:05 +0200
Message-ID: <3288653.44csPzL39Z@natalenko.name>
In-Reply-To: <5d237fd2-4af4-4a4a-8c52-224b41f505f9@gmail.com>
References: <20240321124311.2279-1-christian.koenig@amd.com>
 <fbe52af7-4ebb-490d-9771-d0ee177307e5@ursulin.net>
 <5d237fd2-4af4-4a4a-8c52-224b41f505f9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8354854.T7Z3S40VBb";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Mailman-Approved-At: Mon, 08 Apr 2024 07:46:23 +0000
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

--nextPart8354854.T7Z3S40VBb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Date: Fri, 05 Apr 2024 16:41:05 +0200
Message-ID: <3288653.44csPzL39Z@natalenko.name>
In-Reply-To: <5d237fd2-4af4-4a4a-8c52-224b41f505f9@gmail.com>
MIME-Version: 1.0

Hello Christian.

On =C4=8Dtvrtek 21. b=C5=99ezna 2024 15:37:27, CEST Christian K=C3=B6nig wr=
ote:
> Am 21.03.24 um 15:12 schrieb Tvrtko Ursulin:
> >
> > On 21/03/2024 12:43, Christian K=C3=B6nig wrote:
> >> This reverts drm/amdgpu: fix ftrace event amdgpu_bo_move always move
> >> on same heap. The basic problem here is that after the move the old
> >> location is simply not available any more.
> >>
> >> Some fixes where suggested, but essentially we should call the move
> >> notification before actually moving things because only this way we ha=
ve
> >> the correct order for DMA-buf and VM move notifications as well.
> >>
> >> Also rework the statistic handling so that we don't update the eviction
> >> counter before the move.
> >>
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> > Don't forget:
> >
> > Fixes: 94aeb4117343 ("drm/amdgpu: fix ftrace event amdgpu_bo_move=20
> > always move on same heap")
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3171
>=20
> Ah, thanks. I already wanted to ask if there is any bug report about=20
> that as well.

Do you happen to know if there's some pre-requisite for this patch to also =
be picked while backporting your fix into v6.8? I've tried applying this si=
ngle patch on top of bare v6.8 and got lots of BUGs triggered:

```
BUG: unable to handle page fault for address: 00000000001001c0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 PID: 378 Comm: kworker/u68:0 Not tainted 6.8.0-pf3 #1 30fa7177996c08=
e3c7c351ca59508acf72424acd
Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS 4702 10/20/20=
23
Workqueue: ttm ttm_bo_delayed_delete [ttm]
RIP: 0010:amdgpu_vm_bo_invalidate+0x22/0x390 [amdgpu]
Code: 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 41 56 41 55 41 54 =
55 48 89 f5 53 48 8b 86 58 02 00 00 48 85 c0 74 16 31 c9 <83> b8 c0 01 00 0=
0 01 0f 84 cb 02 00 00 48 39 cd 48 0f 44 e8 48 8b
RSP: 0018:ffffa43440e47e00 EFLAGS: 00010246
RAX: 0000000000100000 RBX: ffff93419508ae00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff93419508ada8 RDI: ffff934195900000
RBP: ffff93419508ada8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: ffff934180a6ea80 R12: ffff93418302f060
R13: ffff93419508ada8 R14: ffff93418d30de05 R15: ffff93419508afb0
=46S:  0000000000000000(0000) GS:ffff93602eac0000(0000) knlGS:0000000000000=
000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000001001c0 CR3: 000000010a7ac000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 amdgpu_bo_move_notify+0x3a/0xf0 [amdgpu 84c82d766599797bed2ef6971fa457123a=
4823ba]
 ttm_bo_delayed_delete+0x59/0xd0 [ttm d0d6b8ddf810a50c01887c0fcb83d6ad65d08=
ff1]
 process_one_work+0x17b/0x340
 worker_thread+0x301/0x490
 kthread+0xe8/0x120
 ret_from_fork+0x34/0x50
 ret_from_fork_asm+0x1b/0x30
 </TASK>
```

Thank you.

> Regards,
> Christian.
>=20
> >
> > ;)
> >
> > Regards,
> >
> > Tvrtko
> >
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 15 +++----
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  4 +-
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 48 ++++++++++++--------=
=2D-
> >>   3 files changed, 37 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c=20
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> index 425cebcc5cbf..eb7d824763b9 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> @@ -1245,19 +1245,20 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo=20
> >> *bo, void *buffer,
> >>    * amdgpu_bo_move_notify - notification about a memory move
> >>    * @bo: pointer to a buffer object
> >>    * @evict: if this move is evicting the buffer from the graphics=20
> >> address space
> >> + * @new_mem: new resource for backing the BO
> >>    *
> >>    * Marks the corresponding &amdgpu_bo buffer object as invalid,=20
> >> also performs
> >>    * bookkeeping.
> >>    * TTM driver callback which is called when ttm moves a buffer.
> >>    */
> >> -void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
> >> +void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
> >> +               bool evict,
> >> +               struct ttm_resource *new_mem)
> >>   {
> >>       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->bdev);
> >> +    struct ttm_resource *old_mem =3D bo->resource;
> >>       struct amdgpu_bo *abo;
> >>   -    if (!amdgpu_bo_is_amdgpu_bo(bo))
> >> -        return;
> >> -
> >>       abo =3D ttm_to_amdgpu_bo(bo);
> >>       amdgpu_vm_bo_invalidate(adev, abo, evict);
> >>   @@ -1267,9 +1268,9 @@ void amdgpu_bo_move_notify(struct=20
> >> ttm_buffer_object *bo, bool evict)
> >>           bo->resource->mem_type !=3D TTM_PL_SYSTEM)
> >>           dma_buf_move_notify(abo->tbo.base.dma_buf);
> >>   -    /* remember the eviction */
> >> -    if (evict)
> >> -        atomic64_inc(&adev->num_evictions);
> >> +    /* move_notify is called before move happens */
> >> +    trace_amdgpu_bo_move(abo, new_mem ? new_mem->mem_type : -1,
> >> +                 old_mem ? old_mem->mem_type : -1);
> >>   }
> >>     void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h=20
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >> index a3ea8a82db23..d28e21baef16 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >> @@ -344,7 +344,9 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo,=
=20
> >> void *metadata,
> >>   int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
> >>                  size_t buffer_size, uint32_t *metadata_size,
> >>                  uint64_t *flags);
> >> -void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict);
> >> +void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
> >> +               bool evict,
> >> +               struct ttm_resource *new_mem);
> >>   void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
> >>   vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object=20
> >> *bo);
> >>   void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c=20
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> index a5ceec7820cf..460b23918bfc 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> @@ -471,14 +471,16 @@ static int amdgpu_bo_move(struct=20
> >> ttm_buffer_object *bo, bool evict,
> >>         if (!old_mem || (old_mem->mem_type =3D=3D TTM_PL_SYSTEM &&
> >>                bo->ttm =3D=3D NULL)) {
> >> +        amdgpu_bo_move_notify(bo, evict, new_mem);
> >>           ttm_bo_move_null(bo, new_mem);
> >> -        goto out;
> >> +        return 0;
> >>       }
> >>       if (old_mem->mem_type =3D=3D TTM_PL_SYSTEM &&
> >>           (new_mem->mem_type =3D=3D TTM_PL_TT ||
> >>            new_mem->mem_type =3D=3D AMDGPU_PL_PREEMPT)) {
> >> +        amdgpu_bo_move_notify(bo, evict, new_mem);
> >>           ttm_bo_move_null(bo, new_mem);
> >> -        goto out;
> >> +        return 0;
> >>       }
> >>       if ((old_mem->mem_type =3D=3D TTM_PL_TT ||
> >>            old_mem->mem_type =3D=3D AMDGPU_PL_PREEMPT) &&
> >> @@ -488,9 +490,10 @@ static int amdgpu_bo_move(struct=20
> >> ttm_buffer_object *bo, bool evict,
> >>               return r;
> >>             amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
> >> +        amdgpu_bo_move_notify(bo, evict, new_mem);
> >>           ttm_resource_free(bo, &bo->resource);
> >>           ttm_bo_assign_mem(bo, new_mem);
> >> -        goto out;
> >> +        return 0;
> >>       }
> >>         if (old_mem->mem_type =3D=3D AMDGPU_PL_GDS ||
> >> @@ -502,8 +505,9 @@ static int amdgpu_bo_move(struct=20
> >> ttm_buffer_object *bo, bool evict,
> >>           new_mem->mem_type =3D=3D AMDGPU_PL_OA ||
> >>           new_mem->mem_type =3D=3D AMDGPU_PL_DOORBELL) {
> >>           /* Nothing to save here */
> >> +        amdgpu_bo_move_notify(bo, evict, new_mem);
> >>           ttm_bo_move_null(bo, new_mem);
> >> -        goto out;
> >> +        return 0;
> >>       }
> >>         if (bo->type =3D=3D ttm_bo_type_device &&
> >> @@ -515,22 +519,23 @@ static int amdgpu_bo_move(struct=20
> >> ttm_buffer_object *bo, bool evict,
> >>           abo->flags &=3D ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> >>       }
> >>   -    if (adev->mman.buffer_funcs_enabled) {
> >> -        if (((old_mem->mem_type =3D=3D TTM_PL_SYSTEM &&
> >> -              new_mem->mem_type =3D=3D TTM_PL_VRAM) ||
> >> -             (old_mem->mem_type =3D=3D TTM_PL_VRAM &&
> >> -              new_mem->mem_type =3D=3D TTM_PL_SYSTEM))) {
> >> -            hop->fpfn =3D 0;
> >> -            hop->lpfn =3D 0;
> >> -            hop->mem_type =3D TTM_PL_TT;
> >> -            hop->flags =3D TTM_PL_FLAG_TEMPORARY;
> >> -            return -EMULTIHOP;
> >> -        }
> >> +    if (adev->mman.buffer_funcs_enabled &&
> >> +        ((old_mem->mem_type =3D=3D TTM_PL_SYSTEM &&
> >> +          new_mem->mem_type =3D=3D TTM_PL_VRAM) ||
> >> +         (old_mem->mem_type =3D=3D TTM_PL_VRAM &&
> >> +          new_mem->mem_type =3D=3D TTM_PL_SYSTEM))) {
> >> +        hop->fpfn =3D 0;
> >> +        hop->lpfn =3D 0;
> >> +        hop->mem_type =3D TTM_PL_TT;
> >> +        hop->flags =3D TTM_PL_FLAG_TEMPORARY;
> >> +        return -EMULTIHOP;
> >> +    }
> >>   +    amdgpu_bo_move_notify(bo, evict, new_mem);
> >> +    if (adev->mman.buffer_funcs_enabled)
> >>           r =3D amdgpu_move_blit(bo, evict, new_mem, old_mem);
> >> -    } else {
> >> +    else
> >>           r =3D -ENODEV;
> >> -    }
> >>         if (r) {
> >>           /* Check that all memory is CPU accessible */
> >> @@ -545,11 +550,10 @@ static int amdgpu_bo_move(struct=20
> >> ttm_buffer_object *bo, bool evict,
> >>               return r;
> >>       }
> >>   -    trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
> >> -out:
> >> -    /* update statistics */
> >> +    /* update statistics after the move */
> >> +    if (evict)
> >> +        atomic64_inc(&adev->num_evictions);
> >>       atomic64_add(bo->base.size, &adev->num_bytes_moved);
> >> -    amdgpu_bo_move_notify(bo, evict);
> >>       return 0;
> >>   }
> >>   @@ -1551,7 +1555,7 @@ static int amdgpu_ttm_access_memory(struct=20
> >> ttm_buffer_object *bo,
> >>   static void
> >>   amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
> >>   {
> >> -    amdgpu_bo_move_notify(bo, false);
> >> +    amdgpu_bo_move_notify(bo, false, NULL);
> >>   }
> >>     static struct ttm_device_funcs amdgpu_bo_driver =3D {
>=20
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart8354854.T7Z3S40VBb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmYQDYEACgkQil/iNcg8
M0tFthAAyM7YMMT96M9U25gXrbTkVn7+DGI4E3iNl9LCcpgz/A7prOdOar+8NI81
Wfd6B4K42SJlbA5pHCIYVKbC5MbhxM2kRKM8xHQTsIA2glBuffu2jtIDT+inI9Cf
AkXEhdIXwC1LwHZJICGSsHwWaTSLhpI83+jzIGCDoB+Tze7CVEjSOxKyH4YHvlrr
D73B4EGl5FypxrIecjFnA7Zdzv0CQcG65OSuhVZO/4cdjIbWHU3Twp7X/zib+EPW
YvhlwFM1zc+PYdlAMmW1uHcUBw3flvvlzC2ieX4NspobmSKglbZaaYCggXaEcZUg
0tYWoyiyrwYuv8k70XfWDkyGsEr2/n71htNKzr91HSCXettN0yb0lMILgic49bAD
lSSQmqjAjA61O5XRF2vLsGXQgFwRntXwABk62Ae31ppEpB7wtpCgAnO7E9p459X1
fZcAiqiDE6TY3tJZx2rF3MsKd2ceqU6pKougdQ7adCq/UorVDcjJ6CYgtMYWrMW/
VH+jArrnS7Oy7JiJfL062/i7qYXXCmDhK9uymLjPZtDnQB4OTm7XvX0ttMiN5OJl
Ofe6Wi0RA9hwcKWlzLIiA5HWc5TCvHTRIqKYjzliXk4rtr8tk9lRMSEBWHzaN/j1
UT8L5KEtVoWrWxJ1uQBHrNbvhOMxZLJBf7084zSJg+ymkFJ0I0o=
=Wjoq
-----END PGP SIGNATURE-----

--nextPart8354854.T7Z3S40VBb--



