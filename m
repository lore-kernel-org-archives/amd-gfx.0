Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB8ECD3427
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2026 07:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 042CB10E504;
	Fri,  1 May 2026 07:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dVFdMNs6";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD3F10E19A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 12:32:15 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c736261ee8dso289560a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 05:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777552334; cv=none;
 d=google.com; s=arc-20240605;
 b=KcgzF1rS7eLigMx+GB75DA9/F1epBWYJEYAO6EOQsBPO2VyRu/N6qvm1ugOeSXsyiQ
 qz1+cJ2YKH9f/y+a9rsyrx0Ym1AhtGmAczQYhywcHmSS9FZNZTPhvPhz6tALmd0jz4ir
 SpzVmCPFd33yur6o1KVbUvITs1rn1eA/BsohW3OCD8Iu6GQo4ZH49mnVq7/EUYwL5VF5
 Nrrk8+JLnnBNPRMymyUAx9P+jp3T80Ni92JDOAz4cQAcEhrhiUDosb2/dEf1EIkY7xek
 e83lgmnzSLyJI8POe8bagVMbtk5OPjG8spE6Z/7utoy9Bz4hWYx7wNWdVqIFVpO0wla+
 2E0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yZwPRf3/2LtR+0X01npQjnj1FwSHLZOB/7VvwZmV7Yg=;
 fh=iuCH//nNpWiqgxLCf2LpBMEc/dCo0z34xMB+vvMTAgY=;
 b=CWplgIK7XUcu+SSAarc6EoH3j1dELl1g1hE8/WTSf6hby1qIr7VOyu8V/u4sSjB1O2
 RzLgmOSQIUGn/DPFU8le0USBpRMX6pIQP6ViyVinLQyR50ZcdPMcwfmYJ3YSXZhoP4qx
 gq3oCSBKhdVkBvX4gANy6Wd/90zrnNkLJUzO2ED7Ks6xc6DmuO4q6atMxFhmxeZShA14
 Vv0B3ohv2oC+xyKQWp5sgY66kSj8dymkz6gxf9o3OuV4RNAnP3GJRawJeRvHKch6spw3
 GC1xuZqTxFYr5n4BoC/hn/pY6+x2TtHc0+TjXuSTShOJ0oABdG3pUxNzsy4Bk+0/tYXz
 RWag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777552334; x=1778157134; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yZwPRf3/2LtR+0X01npQjnj1FwSHLZOB/7VvwZmV7Yg=;
 b=dVFdMNs653p9GymXP4Ob7VUgxcNoSHI+LCJ4eHPWzCtyV6C6z5BdJNALa+SIouVOrI
 L3miW7bUPdoB10t33j7B+fBx9FIleAlfz1w/LSHYzPl8/MgOMByHOAskUdG10PyME4vB
 UB9Mk1kAzdOnAoU7qgX3FJp/wrVuha7pQOiZHLSLqTJG5Z0txoc58WRIsvLBLkkzbxie
 B7QWda7gSnjZURZTPp+0Q/uB76hrNSpP1l/7vJ+DPb6rhuSNCBQ4mClEyhxrUDp9F0tG
 swLx30SRyiOwvP6YMZXkJOmgu7o+9qqVQTsAd1bKgOc1FYHApYTY+0zhxcuGAwWd0EQT
 /kLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777552334; x=1778157134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZwPRf3/2LtR+0X01npQjnj1FwSHLZOB/7VvwZmV7Yg=;
 b=tRwsYExB4mToQrdazuEBUVjhhru1tGWFP/8Gu7X+tbp7eh9TkJ9laCgnqkEtc3IMHr
 B5xWKJb0ZA2xPzJ+35VVgiUq0IKFN3hZPctsHtbDyMcqU1WyemgmMkdmGaKRvca/Mahf
 TUbgt+YAgHk1aABbvuqTxaaxyDCZk2OvyQlhhdLXhAdl844LRCi9UgiuzuIF8S3q1Yxv
 A4fQwpRVmXTFhD+JOEngxgPg0IWLrqwTbXspvStkE5RDCIR59vpy6ek99JCutRQfTgVQ
 sJpKO5aBoDqnUtTNK5HHtLTcofyPc/Fqbqwz7pM5acFskmxlE7AP3ASRVrHKrCnNqZqw
 ES0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VZJsE3uO3tgSw17sc67tw+iFZ4TFdV/LzNoRUSZjZHX+fhb5mnAYCLhC+NO0r6rfZnH1NTS9Z@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywddp4RjUF0lST3qQ+bjrCKaSkE9zP/GeeAZfhGa5iRJl8wj/KH
 Dc3/i6rw5yL2l9W6fySz6VMCqCTuc7TSQf+lquI/oHkmYrEIiexp5vyn8B2WAvSlH7X2wHvY/JT
 FtyGYYT2dVHm+0bU/eKR0XoUNLqwzgdZykaNKiA==
X-Gm-Gg: AeBDiestZhsAeA7jSdT8sLetzXmdQOfUzth5VOENfIfRkpAdfUkUWvDtugofn8g6tlu
 RTYsJbNZOKVUTGBo2vxHZyyv7v/I7CfYFlt2rtQ3xLHDy8q3L9pRdKNwpIDAR64NEevBchKhy6q
 JHXUhStp4w1CPtINF0P47UbKvlG+viHPZyXExEHq7qsapHP95EuZvoGL95HaoQA3jvlbT9OMVRk
 rDtoR9hDZQ+CeT/9f3mtU7aP/yr0infeabbXFdY+pKtXImxGu5KdqNmNB+G2rsaTlkVi9bsAUQh
 8/qHnKotH1UIGh2Ualrr8G4u+rXxd0gbBtbnhOISWmZ7ge23X7lphz6CkX24mn5MocrUhw33PHi
 ER4M=
X-Received: by 2002:a17:902:6b4b:b0:2b2:5256:9ce7 with SMTP id
 d9443c01a7336-2b9a2500e3cmr19703905ad.36.1777552333980; Thu, 30 Apr 2026
 05:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260429202042.21718-1-jbmoore61@gmail.com>
 <6266086d-15d4-476d-a992-503509032dd7@amd.com>
In-Reply-To: <6266086d-15d4-476d-a992-503509032dd7@amd.com>
From: John Moore <jbmoore61@gmail.com>
Date: Thu, 30 Apr 2026 07:32:03 -0500
X-Gm-Features: AVHnY4I8Eakx6Pzi_Cwxcqj1AfukQ5iwWC5T2s8D5leU6W2IMOWexElX1iWUBvU
Message-ID: <CAPUYzBf8EBynRij60SR+EFg1Kn22cyykSOOPxo709bq0xhjpLw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx: extract compute wptr doorbell helpers to
 amdgpu_gfx.c
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000006fc6f50650aca705"
X-Mailman-Approved-At: Fri, 01 May 2026 07:11:25 +0000
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

--0000000000006fc6f50650aca705
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

Thanks for the review. All points addressed below.

> That should probably be readq() instead of this horrible and not
> portable cast to atomic64_t.
>
> Alternatively we could just normally read the pointer with a memory
> barrier since this is just system memory.

I went with the second option =E2=80=94 this is system memory (writeback vi=
a
GTT), not MMIO, so readq() felt semantically wrong. The v2 uses:

  get:  wptr =3D READ_ONCE(*(u64 *)ring->wptr_cpu_addr);
        smp_rmb();

  set:  WRITE_ONCE(*(u64 *)ring->wptr_cpu_addr, ring->wptr);
        smp_wmb();
        WDOORBELL64(ring->doorbell_index, ring->wptr);

The alignment is safe =E2=80=94 amdgpu_device_wb_get() returns offsets in
multiples of 8 dwords (32 bytes), so the u64* cast always lands on
a naturally-aligned address.

One question: READ_ONCE on a u64 is not atomic on 32-bit
architectures (unlike atomic64_read which uses cmpxchg8b). DRM_AMDGPU
has no formal CONFIG_64BIT dependency in Kconfig, though in practice
nobody runs it on 32-bit. Is READ_ONCE acceptable here, or would you
prefer readq() to keep the atomicity guarantee?

> Pre-requisite/error checking first please.
> Make that a if (WARN_ON(!ring->use_doorbell)) return.

Done. Both functions now have the guard at the top:

  if (WARN_ON(!ring->use_doorbell))
      return 0;  /* or return; for set_wptr */

> And please don't use WARN_ON_ONCE() that is just to reduce the
> amount of warnings printed into the logs on real HW errors.
>
> On functional coding errors like this one here it doesn't make sense
> and is often overlooked.

Understood =E2=80=94 changed to WARN_ON.

> Same here the case to atomic64_t is extremely questionable.

Fixed in set_wptr as well, same READ_ONCE/WRITE_ONCE approach.

v2 incoming once I hear back on the readq vs READ_ONCE question.

Thanks,
John

"I will not be pushed, filed, stamped, indexed, briefed, debriefed, or
numbered."
~ The Prisoner




On Thu, Apr 30, 2026 at 2:19=E2=80=AFAM Christian K=C3=B6nig <christian.koe=
nig@amd.com>
wrote:

> On 4/29/26 22:20, John B. Moore wrote:
> > Move the duplicated doorbell-based get_wptr/set_wptr functions from
> > gfx_v9_0.c, gfx_v10_0.c, gfx_v11_0.c, and gfx_v12_0.c into common
> > helpers amdgpu_gfx_get_wptr_compute() and amdgpu_gfx_set_wptr_compute()
> > in amdgpu_gfx.c.
> >
> > These functions are not HW generation dependent -- the doorbell path is
> > identical across all four GFX versions:
> >
> >   get: atomic64_read(ring->wptr_cpu_addr)
> >   set: atomic64_set(ring->wptr_cpu_addr) + WDOORBELL64()
> >
> > The non-doorbell fallback is replaced with WARN_ON_ONCE instead of BUG(=
)
> > since doorbell is the only supported method on gfx9+ compute rings.
> >
> > Not touched: gfx_v7_0, gfx_v8_0, gfx_v9_4_3 -- these have different
> > wptr access patterns (MMIO registers or wb.wb[] offsets).
> >
> > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: John Moore <jbmoore61@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39 +++++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 33 +++------------------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 34 +++------------------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 34 +++------------------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 39 +++----------------------
> >  6 files changed, 58 insertions(+), 124 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index 77578ecc6..9e9c5cb81 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -2596,3 +2596,42 @@ void
> amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
> >  #endif
> >  }
> >
> > +/**
> > + * amdgpu_gfx_get_wptr_compute - common get_wptr for compute rings
> using doorbells
> > + * @ring: amdgpu_ring pointer
> > + *
> > + * Read the write pointer from the doorbell-mapped writeback address.
> > + * This is HW-agnostic and shared across GFX generations that use
> > + * doorbell-based compute queue management.
> > + */
> > +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring)
> > +{
> > +     /* XXX check if swapping is necessary on BE */
> > +     if (ring->use_doorbell)
> > +             return atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
>
> That should probably be readq() instead of this horrible and not portable
> cast to atomic64_t.
>
> Alternatively we could just normally read the pointer with a memory
> barrier since this is just system memory.
>
> > +
> > +     WARN_ON_ONCE(1);
>
> Pre-requisite/error checking first please.
>
> Make that a if (WARN_ON(!ring->use_doorbell)) return.
>
> And please don't use WARN_ON_ONCE() that is just to reduce the amount of
> warnings printed into the logs on real HW errors.
>
> On functional coding errors like this one here it doesn't make sense and
> is often overlooked.
>
> > +     return 0;
> > +}
> > +
> > +/**
> > + * amdgpu_gfx_set_wptr_compute - common set_wptr for compute rings
> using doorbells
> > + * @ring: amdgpu_ring pointer
> > + *
> > + * Write the write pointer to the doorbell-mapped writeback address an=
d
> > + * ring the doorbell.  This is HW-agnostic and shared across GFX
> > + * generations that use doorbell-based compute queue management.
> > + */
> > +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring)
> > +{
> > +     struct amdgpu_device *adev =3D ring->adev;
> > +
> > +     /* XXX check if swapping is necessary on BE */
> > +     if (ring->use_doorbell) {
> > +             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> ring->wptr);
>
> Same here the case to atomic64_t is extremely questionable.
>
> Regards,
> Christian.
>
> > +             WDOORBELL64(ring->doorbell_index, ring->wptr);
> > +     } else {
> > +             WARN_ON_ONCE(1);
> > +     }
> > +}
> > +
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index 585cc8e81..27f6beafb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -653,6 +653,9 @@ u32 amdgpu_gfx_csb_preamble_start(u32 *buffer);
> >  u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, u32 *buffer=
,
> u32 count);
> >  void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
> >
> > +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring);
> > +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring);
> > +
> >  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
> >  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev=
);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index 1893ceeeb..4c0272cba 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -8586,31 +8586,6 @@ static u64 gfx_v10_0_ring_get_rptr_compute(struc=
t
> amdgpu_ring *ring)
> >       return *(uint32_t *)ring->rptr_cpu_addr;
> >  }
> >
> > -static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> > -{
> > -     u64 wptr;
> > -
> > -     /* XXX check if swapping is necessary on BE */
> > -     if (ring->use_doorbell)
> > -             wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu_addr)=
;
> > -     else
> > -             BUG();
> > -     return wptr;
> > -}
> > -
> > -static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> > -{
> > -     struct amdgpu_device *adev =3D ring->adev;
> > -
> > -     if (ring->use_doorbell) {
> > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> > -                          ring->wptr);
> > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
> > -     } else {
> > -             BUG(); /* only DOORBELL method supported on gfx10 now */
> > -     }
> > -}
> > -
> >  static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > @@ -9881,8 +9856,8 @@ static const struct amdgpu_ring_funcs
> gfx_v10_0_ring_funcs_compute =3D {
> >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >       .support_64bit_ptrs =3D true,
> >       .get_rptr =3D gfx_v10_0_ring_get_rptr_compute,
> > -     .get_wptr =3D gfx_v10_0_ring_get_wptr_compute,
> > -     .set_wptr =3D gfx_v10_0_ring_set_wptr_compute,
> > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >       .emit_frame_size =3D
> >               20 + /* gfx_v10_0_ring_emit_gds_switch */
> >               7 + /* gfx_v10_0_ring_emit_hdp_flush */
> > @@ -9921,8 +9896,8 @@ static const struct amdgpu_ring_funcs
> gfx_v10_0_ring_funcs_kiq =3D {
> >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >       .support_64bit_ptrs =3D true,
> >       .get_rptr =3D gfx_v10_0_ring_get_rptr_compute,
> > -     .get_wptr =3D gfx_v10_0_ring_get_wptr_compute,
> > -     .set_wptr =3D gfx_v10_0_ring_set_wptr_compute,
> > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >       .emit_frame_size =3D
> >               20 + /* gfx_v10_0_ring_emit_gds_switch */
> >               7 + /* gfx_v10_0_ring_emit_hdp_flush */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > index 427975b5a..404604f2d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -5818,32 +5818,6 @@ static u64 gfx_v11_0_ring_get_rptr_compute(struc=
t
> amdgpu_ring *ring)
> >       return *(uint32_t *)ring->rptr_cpu_addr;
> >  }
> >
> > -static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> > -{
> > -     u64 wptr;
> > -
> > -     /* XXX check if swapping is necessary on BE */
> > -     if (ring->use_doorbell)
> > -             wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu_addr)=
;
> > -     else
> > -             BUG();
> > -     return wptr;
> > -}
> > -
> > -static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> > -{
> > -     struct amdgpu_device *adev =3D ring->adev;
> > -
> > -     /* XXX check if swapping is necessary on BE */
> > -     if (ring->use_doorbell) {
> > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> > -                          ring->wptr);
> > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
> > -     } else {
> > -             BUG(); /* only DOORBELL method supported on gfx11 now */
> > -     }
> > -}
> > -
> >  static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > @@ -7266,8 +7240,8 @@ static const struct amdgpu_ring_funcs
> gfx_v11_0_ring_funcs_compute =3D {
> >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >       .support_64bit_ptrs =3D true,
> >       .get_rptr =3D gfx_v11_0_ring_get_rptr_compute,
> > -     .get_wptr =3D gfx_v11_0_ring_get_wptr_compute,
> > -     .set_wptr =3D gfx_v11_0_ring_set_wptr_compute,
> > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >       .emit_frame_size =3D
> >               5 + /* update_spm_vmid */
> >               20 + /* gfx_v11_0_ring_emit_gds_switch */
> > @@ -7307,8 +7281,8 @@ static const struct amdgpu_ring_funcs
> gfx_v11_0_ring_funcs_kiq =3D {
> >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >       .support_64bit_ptrs =3D true,
> >       .get_rptr =3D gfx_v11_0_ring_get_rptr_compute,
> > -     .get_wptr =3D gfx_v11_0_ring_get_wptr_compute,
> > -     .set_wptr =3D gfx_v11_0_ring_set_wptr_compute,
> > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >       .emit_frame_size =3D
> >               20 + /* gfx_v11_0_ring_emit_gds_switch */
> >               7 + /* gfx_v11_0_ring_emit_hdp_flush */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > index 79ea1af36..7ba436444 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -4363,32 +4363,6 @@ static u64 gfx_v12_0_ring_get_rptr_compute(struc=
t
> amdgpu_ring *ring)
> >       return *(uint32_t *)ring->rptr_cpu_addr;
> >  }
> >
> > -static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> > -{
> > -     u64 wptr;
> > -
> > -     /* XXX check if swapping is necessary on BE */
> > -     if (ring->use_doorbell)
> > -             wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu_addr)=
;
> > -     else
> > -             BUG();
> > -     return wptr;
> > -}
> > -
> > -static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> > -{
> > -     struct amdgpu_device *adev =3D ring->adev;
> > -
> > -     /* XXX check if swapping is necessary on BE */
> > -     if (ring->use_doorbell) {
> > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> > -                          ring->wptr);
> > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
> > -     } else {
> > -             BUG(); /* only DOORBELL method supported on gfx12 now */
> > -     }
> > -}
> > -
> >  static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > @@ -5523,8 +5497,8 @@ static const struct amdgpu_ring_funcs
> gfx_v12_0_ring_funcs_compute =3D {
> >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >       .support_64bit_ptrs =3D true,
> >       .get_rptr =3D gfx_v12_0_ring_get_rptr_compute,
> > -     .get_wptr =3D gfx_v12_0_ring_get_wptr_compute,
> > -     .set_wptr =3D gfx_v12_0_ring_set_wptr_compute,
> > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >       .emit_frame_size =3D
> >               7 + /* gfx_v12_0_ring_emit_hdp_flush */
> >               5 + /* hdp invalidate */
> > @@ -5561,8 +5535,8 @@ static const struct amdgpu_ring_funcs
> gfx_v12_0_ring_funcs_kiq =3D {
> >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >       .support_64bit_ptrs =3D true,
> >       .get_rptr =3D gfx_v12_0_ring_get_rptr_compute,
> > -     .get_wptr =3D gfx_v12_0_ring_get_wptr_compute,
> > -     .set_wptr =3D gfx_v12_0_ring_set_wptr_compute,
> > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >       .emit_frame_size =3D
> >               7 + /* gfx_v12_0_ring_emit_hdp_flush */
> >               5 + /*hdp invalidate */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 8249135d7..798f94bca 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -5640,37 +5640,6 @@ static u64 gfx_v9_0_ring_get_rptr_compute(struct
> amdgpu_ring *ring)
> >       return *ring->rptr_cpu_addr; /* gfx9 hardware is 32bit rptr */
> >  }
> >
> > -static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> > -{
> > -     u64 wptr;
> > -
> > -     /* XXX check if swapping is necessary on BE */
> > -     if (ring->use_doorbell) {
> > -             wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu_addr)=
;
> > -     } else {
> > -             WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr read on ring %s=
,
> "
> > -                       "only doorbell method supported on gfx9\n",
> > -                       ring->name);
> > -             wptr =3D 0;
> > -     }
> > -     return wptr;
> > -}
> > -
> > -static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> > -{
> > -     struct amdgpu_device *adev =3D ring->adev;
> > -
> > -     /* XXX check if swapping is necessary on BE */
> > -     if (ring->use_doorbell) {
> > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> ring->wptr);
> > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
> > -     } else {
> > -             WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr write on ring
> %s, "
> > -                       "only doorbell method supported on gfx9\n",
> > -                       ring->name);
> > -     }
> > -}
> > -
> >  static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64
> addr,
> >                                        u64 seq, unsigned int flags)
> >  {
> > @@ -7627,8 +7596,8 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_ring_funcs_compute =3D {
> >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >       .support_64bit_ptrs =3D true,
> >       .get_rptr =3D gfx_v9_0_ring_get_rptr_compute,
> > -     .get_wptr =3D gfx_v9_0_ring_get_wptr_compute,
> > -     .set_wptr =3D gfx_v9_0_ring_set_wptr_compute,
> > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >       .emit_frame_size =3D
> >               20 + /* gfx_v9_0_ring_emit_gds_switch */
> >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> > @@ -7669,8 +7638,8 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_ring_funcs_kiq =3D {
> >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >       .support_64bit_ptrs =3D true,
> >       .get_rptr =3D gfx_v9_0_ring_get_rptr_compute,
> > -     .get_wptr =3D gfx_v9_0_ring_get_wptr_compute,
> > -     .set_wptr =3D gfx_v9_0_ring_set_wptr_compute,
> > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >       .emit_frame_size =3D
> >               20 + /* gfx_v9_0_ring_emit_gds_switch */
> >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
>
>

--0000000000006fc6f50650aca705
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Christian,<br><br>Thanks for the review. All point=
s addressed below.<br><br>&gt; That should probably be readq() instead of t=
his horrible and not<br>&gt; portable cast to atomic64_t.<br>&gt;<br>&gt; A=
lternatively we could just normally read the pointer with a memory<br>&gt; =
barrier since this is just system memory.<br><br>I went with the second opt=
ion =E2=80=94 this is system memory (writeback via<br>GTT), not MMIO, so re=
adq() felt semantically wrong. The v2 uses:<br><br>=C2=A0 get: =C2=A0wptr =
=3D READ_ONCE(*(u64 *)ring-&gt;wptr_cpu_addr);<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 smp_rmb();<br><br>=C2=A0 set: =C2=A0WRITE_ONCE(*(u64 *)ring-&gt;wptr_cp=
u_addr, ring-&gt;wptr);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_wmb();<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 WDOORBELL64(ring-&gt;doorbell_index, ring-&gt;wptr);<=
br><br>The alignment is safe =E2=80=94 amdgpu_device_wb_get() returns offse=
ts in<br>multiples of 8 dwords (32 bytes), so the u64* cast always lands on=
<br>a naturally-aligned address.<br><br>One question: READ_ONCE on a u64 is=
 not atomic on 32-bit<br>architectures (unlike atomic64_read which uses cmp=
xchg8b). DRM_AMDGPU<br>has no formal CONFIG_64BIT dependency in Kconfig, th=
ough in practice<br>nobody runs it on 32-bit. Is READ_ONCE acceptable here,=
 or would you<br>prefer readq() to keep the atomicity guarantee?<br><br>&gt=
; Pre-requisite/error checking first please.<br>&gt; Make that a if (WARN_O=
N(!ring-&gt;use_doorbell)) return.<br><br>Done. Both functions now have the=
 guard at the top:<br><br>=C2=A0 if (WARN_ON(!ring-&gt;use_doorbell))<br>=
=C2=A0 =C2=A0 =C2=A0 return 0; =C2=A0/* or return; for set_wptr */<br><br>&=
gt; And please don&#39;t use WARN_ON_ONCE() that is just to reduce the<br>&=
gt; amount of warnings printed into the logs on real HW errors.<br>&gt;<br>=
&gt; On functional coding errors like this one here it doesn&#39;t make sen=
se<br>&gt; and is often overlooked.<br><br>Understood =E2=80=94 changed to =
WARN_ON.<br><br>&gt; Same here the case to atomic64_t is extremely question=
able.<br><br>Fixed in set_wptr as well, same READ_ONCE/WRITE_ONCE approach.=
<br><br>v2 incoming once I hear back on the readq vs READ_ONCE question.<br=
><br>Thanks,<br>John</div><div><br></div><div><div dir=3D"ltr" class=3D"gma=
il_signature" data-smartmail=3D"gmail_signature">&quot;I will not be pushed=
, filed, stamped, indexed, briefed, debriefed, or numbered.&quot;<br>~ The =
Prisoner<br><br><br></div></div><br></div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 30, 2=
026 at 2:19=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=3D"mailto:christian=
.koenig@amd.com">christian.koenig@amd.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 4/29/26 22:20, John B. Moore wr=
ote:<br>
&gt; Move the duplicated doorbell-based get_wptr/set_wptr functions from<br=
>
&gt; gfx_v9_0.c, gfx_v10_0.c, gfx_v11_0.c, and gfx_v12_0.c into common<br>
&gt; helpers amdgpu_gfx_get_wptr_compute() and amdgpu_gfx_set_wptr_compute(=
)<br>
&gt; in amdgpu_gfx.c.<br>
&gt; <br>
&gt; These functions are not HW generation dependent -- the doorbell path i=
s<br>
&gt; identical across all four GFX versions:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0get: atomic64_read(ring-&gt;wptr_cpu_addr)<br>
&gt;=C2=A0 =C2=A0set: atomic64_set(ring-&gt;wptr_cpu_addr) + WDOORBELL64()<=
br>
&gt; <br>
&gt; The non-doorbell fallback is replaced with WARN_ON_ONCE instead of BUG=
()<br>
&gt; since doorbell is the only supported method on gfx9+ compute rings.<br=
>
&gt; <br>
&gt; Not touched: gfx_v7_0, gfx_v8_0, gfx_v9_4_3 -- these have different<br=
>
&gt; wptr access patterns (MMIO registers or wb.wb[] offsets).<br>
&gt; <br>
&gt; Suggested-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd=
.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt; Signed-off-by: John Moore &lt;<a href=3D"mailto:jbmoore61@gmail.com" t=
arget=3D"_blank">jbmoore61@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39 +++++++++++++++++++=
++++++<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |=C2=A0 3 ++<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c=C2=A0 | 33 +++-----------=
-------<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c=C2=A0 | 34 +++-----------=
-------<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c=C2=A0 | 34 +++-----------=
-------<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c=C2=A0 =C2=A0| 39 +++------=
----------------<br>
&gt;=C2=A0 6 files changed, 58 insertions(+), 124 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gfx.c<br>
&gt; index 77578ecc6..9e9c5cb81 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt; @@ -2596,3 +2596,42 @@ void amdgpu_debugfs_compute_sched_mask_init(str=
uct amdgpu_device *adev)<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +/**<br>
&gt; + * amdgpu_gfx_get_wptr_compute - common get_wptr for compute rings us=
ing doorbells<br>
&gt; + * @ring: amdgpu_ring pointer<br>
&gt; + *<br>
&gt; + * Read the write pointer from the doorbell-mapped writeback address.=
<br>
&gt; + * This is HW-agnostic and shared across GFX generations that use<br>
&gt; + * doorbell-based compute queue management.<br>
&gt; + */<br>
&gt; +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* XXX check if swapping is necessary on BE */<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_doorbell)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return atomic64_read(=
(atomic64_t *)ring-&gt;wptr_cpu_addr);<br>
<br>
That should probably be readq() instead of this horrible and not portable c=
ast to atomic64_t.<br>
<br>
Alternatively we could just normally read the pointer with a memory barrier=
 since this is just system memory.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WARN_ON_ONCE(1);<br>
<br>
Pre-requisite/error checking first please.<br>
<br>
Make that a if (WARN_ON(!ring-&gt;use_doorbell)) return.<br>
<br>
And please don&#39;t use WARN_ON_ONCE() that is just to reduce the amount o=
f warnings printed into the logs on real HW errors.<br>
<br>
On functional coding errors like this one here it doesn&#39;t make sense an=
d is often overlooked.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * amdgpu_gfx_set_wptr_compute - common set_wptr for compute rings us=
ing doorbells<br>
&gt; + * @ring: amdgpu_ring pointer<br>
&gt; + *<br>
&gt; + * Write the write pointer to the doorbell-mapped writeback address a=
nd<br>
&gt; + * ring the doorbell.=C2=A0 This is HW-agnostic and shared across GFX=
<br>
&gt; + * generations that use doorbell-based compute queue management.<br>
&gt; + */<br>
&gt; +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D ring-&gt;adev;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* XXX check if swapping is necessary on BE */<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_doorbell) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic64_set((atomic6=
4_t *)ring-&gt;wptr_cpu_addr, ring-&gt;wptr);<br>
<br>
Same here the case to atomic64_t is extremely questionable.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WDOORBELL64(ring-&gt;=
doorbell_index, ring-&gt;wptr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ON_ONCE(1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gfx.h<br>
&gt; index 585cc8e81..27f6beafb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt; @@ -653,6 +653,9 @@ u32 amdgpu_gfx_csb_preamble_start(u32 *buffer);<br=
>
&gt;=C2=A0 u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, u32 *=
buffer, u32 count);<br>
&gt;=C2=A0 void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);<br>
&gt;=C2=A0 <br>
&gt; +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring);<br>
&gt; +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring);<br>
&gt; +<br>
&gt;=C2=A0 void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *ad=
ev);<br>
&gt;=C2=A0 void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device=
 *adev);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v10_0.c<br>
&gt; index 1893ceeeb..4c0272cba 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; @@ -8586,31 +8586,6 @@ static u64 gfx_v10_0_ring_get_rptr_compute(stru=
ct amdgpu_ring *ring)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return *(uint32_t *)ring-&gt;rptr_cpu_addr;<=
br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)<=
br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0u64 wptr;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if swapping is necessary on BE */<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_doorbell)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wptr =3D atomic64_rea=
d((atomic64_t *)ring-&gt;wptr_cpu_addr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return wptr;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)=
<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D ring-&gt;adev;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_doorbell) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic64_set((atomic6=
4_t *)ring-&gt;wptr_cpu_addr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ring-&gt;wptr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WDOORBELL64(ring-&gt;=
doorbell_index, ring-&gt;wptr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG(); /* only DOORBE=
LL method supported on gfx10 now */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ri=
ng)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D ring-&gt;adev=
;<br>
&gt; @@ -9881,8 +9856,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_=
ring_funcs_compute =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PACKET3(PACKET3_NOP, 0x3FFF),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64bit_ptrs =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =3D gfx_v10_0_ring_get_rptr_comput=
e,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx_v10_0_ring_get_wptr_compute,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx_v10_0_ring_set_wptr_compute,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amdgpu_gfx_get_wptr_compute,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amdgpu_gfx_set_wptr_compute,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_size =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 + /* gfx_v10_=
0_ring_emit_gds_switch */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 + /* gfx_v10_0=
_ring_emit_hdp_flush */<br>
&gt; @@ -9921,8 +9896,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_=
ring_funcs_kiq =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PACKET3(PACKET3_NOP, 0x3FFF),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64bit_ptrs =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =3D gfx_v10_0_ring_get_rptr_comput=
e,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx_v10_0_ring_get_wptr_compute,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx_v10_0_ring_set_wptr_compute,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amdgpu_gfx_get_wptr_compute,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amdgpu_gfx_set_wptr_compute,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_size =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 + /* gfx_v10_=
0_ring_emit_gds_switch */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 + /* gfx_v10_0=
_ring_emit_hdp_flush */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v11_0.c<br>
&gt; index 427975b5a..404604f2d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
&gt; @@ -5818,32 +5818,6 @@ static u64 gfx_v11_0_ring_get_rptr_compute(stru=
ct amdgpu_ring *ring)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return *(uint32_t *)ring-&gt;rptr_cpu_addr;<=
br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring *ring)<=
br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0u64 wptr;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if swapping is necessary on BE */<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_doorbell)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wptr =3D atomic64_rea=
d((atomic64_t *)ring-&gt;wptr_cpu_addr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return wptr;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)=
<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D ring-&gt;adev;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if swapping is necessary on BE */<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_doorbell) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic64_set((atomic6=
4_t *)ring-&gt;wptr_cpu_addr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ring-&gt;wptr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WDOORBELL64(ring-&gt;=
doorbell_index, ring-&gt;wptr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG(); /* only DOORBE=
LL method supported on gfx11 now */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ri=
ng)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D ring-&gt;adev=
;<br>
&gt; @@ -7266,8 +7240,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_=
ring_funcs_compute =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PACKET3(PACKET3_NOP, 0x3FFF),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64bit_ptrs =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =3D gfx_v11_0_ring_get_rptr_comput=
e,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx_v11_0_ring_get_wptr_compute,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx_v11_0_ring_set_wptr_compute,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amdgpu_gfx_get_wptr_compute,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amdgpu_gfx_set_wptr_compute,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_size =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05 + /* update_sp=
m_vmid */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 + /* gfx_v11_=
0_ring_emit_gds_switch */<br>
&gt; @@ -7307,8 +7281,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_=
ring_funcs_kiq =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PACKET3(PACKET3_NOP, 0x3FFF),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64bit_ptrs =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =3D gfx_v11_0_ring_get_rptr_comput=
e,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx_v11_0_ring_get_wptr_compute,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx_v11_0_ring_set_wptr_compute,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amdgpu_gfx_get_wptr_compute,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amdgpu_gfx_set_wptr_compute,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_size =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 + /* gfx_v11_=
0_ring_emit_gds_switch */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 + /* gfx_v11_0=
_ring_emit_hdp_flush */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v12_0.c<br>
&gt; index 79ea1af36..7ba436444 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
&gt; @@ -4363,32 +4363,6 @@ static u64 gfx_v12_0_ring_get_rptr_compute(stru=
ct amdgpu_ring *ring)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return *(uint32_t *)ring-&gt;rptr_cpu_addr;<=
br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring *ring)<=
br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0u64 wptr;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if swapping is necessary on BE */<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_doorbell)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wptr =3D atomic64_rea=
d((atomic64_t *)ring-&gt;wptr_cpu_addr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return wptr;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)=
<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D ring-&gt;adev;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if swapping is necessary on BE */<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_doorbell) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic64_set((atomic6=
4_t *)ring-&gt;wptr_cpu_addr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ring-&gt;wptr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WDOORBELL64(ring-&gt;=
doorbell_index, ring-&gt;wptr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG(); /* only DOORBE=
LL method supported on gfx12 now */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ri=
ng)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D ring-&gt;adev=
;<br>
&gt; @@ -5523,8 +5497,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_=
ring_funcs_compute =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PACKET3(PACKET3_NOP, 0x3FFF),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64bit_ptrs =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =3D gfx_v12_0_ring_get_rptr_comput=
e,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx_v12_0_ring_get_wptr_compute,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx_v12_0_ring_set_wptr_compute,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amdgpu_gfx_get_wptr_compute,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amdgpu_gfx_set_wptr_compute,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_size =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 + /* gfx_v12_0=
_ring_emit_hdp_flush */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05 + /* hdp inval=
idate */<br>
&gt; @@ -5561,8 +5535,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_=
ring_funcs_kiq =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PACKET3(PACKET3_NOP, 0x3FFF),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64bit_ptrs =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =3D gfx_v12_0_ring_get_rptr_comput=
e,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx_v12_0_ring_get_wptr_compute,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx_v12_0_ring_set_wptr_compute,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amdgpu_gfx_get_wptr_compute,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amdgpu_gfx_set_wptr_compute,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_size =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 + /* gfx_v12_0=
_ring_emit_hdp_flush */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05 + /*hdp invali=
date */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v9_0.c<br>
&gt; index 8249135d7..798f94bca 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; @@ -5640,37 +5640,6 @@ static u64 gfx_v9_0_ring_get_rptr_compute(struc=
t amdgpu_ring *ring)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return *ring-&gt;rptr_cpu_addr; /* gfx9 hard=
ware is 32bit rptr */<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)<b=
r>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0u64 wptr;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if swapping is necessary on BE */<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_doorbell) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wptr =3D atomic64_rea=
d((atomic64_t *)ring-&gt;wptr_cpu_addr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ONCE(1, &quot;gf=
x_v9_0: non-doorbell wptr read on ring %s, &quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&quot;only doorbell method supported on gfx9\n&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ring-&gt;name);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wptr =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return wptr;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)<=
br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D ring-&gt;adev;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if swapping is necessary on BE */<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_doorbell) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic64_set((atomic6=
4_t *)ring-&gt;wptr_cpu_addr, ring-&gt;wptr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WDOORBELL64(ring-&gt;=
doorbell_index, ring-&gt;wptr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ONCE(1, &quot;gf=
x_v9_0: non-doorbell wptr write on ring %s, &quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&quot;only doorbell method supported on gfx9\n&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ring-&gt;name);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *rin=
g, u64 addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 s=
eq, unsigned int flags)<br>
&gt;=C2=A0 {<br>
&gt; @@ -7627,8 +7596,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_r=
ing_funcs_compute =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PACKET3(PACKET3_NOP, 0x3FFF),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64bit_ptrs =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =3D gfx_v9_0_ring_get_rptr_compute=
,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx_v9_0_ring_get_wptr_compute,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx_v9_0_ring_set_wptr_compute,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amdgpu_gfx_get_wptr_compute,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amdgpu_gfx_set_wptr_compute,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_size =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 + /* gfx_v9_0=
_ring_emit_gds_switch */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 + /* gfx_v9_0_=
ring_emit_hdp_flush */<br>
&gt; @@ -7669,8 +7638,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_r=
ing_funcs_kiq =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PACKET3(PACKET3_NOP, 0x3FFF),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64bit_ptrs =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =3D gfx_v9_0_ring_get_rptr_compute=
,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx_v9_0_ring_get_wptr_compute,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx_v9_0_ring_set_wptr_compute,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amdgpu_gfx_get_wptr_compute,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amdgpu_gfx_set_wptr_compute,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_size =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 + /* gfx_v9_0=
_ring_emit_gds_switch */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 + /* gfx_v9_0_=
ring_emit_hdp_flush */<br>
<br>
</blockquote></div>

--0000000000006fc6f50650aca705--
