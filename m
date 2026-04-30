Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2845FF8873
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 13:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F98A10E7BE;
	Thu, 30 Apr 2026 13:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="duJtzIzg";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E498F10E278
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 13:26:17 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-12db2e9b3bcso81702c88.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 06:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777555577; cv=none;
 d=google.com; s=arc-20240605;
 b=ft6DBB94q5I2CMbuW8hTL1MMDsANDJCiqYp7n2IAnutgwwfX/hFHfm1w/9t4RfxmWc
 434ewVoUhg8mA9GR8Z6l051ul8jpgDCNtUW4/gASlaUMYEy1Lz2YD97ldf8nAW0um1Q4
 70bQ/ncHiDb6DeESD+m/pZUdJuZfBstWh9x6p9A8IapgsOrq5cx4U0DYrBNarnaYzOKw
 1DtknohX/Rvc30txPU3J8wKZJCWw/n7WNbIKMu9hlx90AhRXw4y81wz1FqJqLkIZcr2M
 0CJEBtMF7zXPhGqJbyhYzO2dsZy9qHrYEaHqMiYENH35FpKz50cdmSLsqQZb16T7i8RI
 A+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LAFvzdF4AKXZm4VB5j+OeVQOBYIg2JT9k6ZcqSNxFCE=;
 fh=CzR+CnXy5TtV/dC6NUmHGzUCqb/EE8ZcUtTBr8HPr2E=;
 b=TP+lnty8vop2SD5LzLGfS35HNH8K/lBq8+ktyUVnphHEQoK6HiJ+u03QuhRoM88UUQ
 CP9fH53cOjehKxYqghwecTFshkdgYhEw4mLl4g1lsu9CqZMFUcAn6q+EPhhgO03/STx9
 B65z+eFYvGJZXnt0vI0JmuhKBoFECcj+uPWrsBo8YjBVZ9pb+zjHvMyTmGkNi4LV8VER
 Os7CN0UqRHGz/uIkw4u4/lkk4uplxFY7NzJl7MITcWo3IrzXWUc+iWAlr+BP9DsgNnCB
 ITNPLA28wSoWuIOVQoU3QBy8Ozpob0+SqCixc6/xC79+cvBaWi/yyVQjA4MJaBP5BN6D
 kIhg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777555577; x=1778160377; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAFvzdF4AKXZm4VB5j+OeVQOBYIg2JT9k6ZcqSNxFCE=;
 b=duJtzIzgdChkR7gPZ5dw4qblmEd+1qe3lS9eYXErsDoixuoPC5HSam0zYOrrgN0SfV
 L9UIrUdNGRAiM1paDb2DvzeUvj3UMMpadyg5xGylvnPqTiB133cS80djhUgh7P77KWyG
 rAwDHNrEg1gjtFWO6jV4n1NJhCScaYEIIC8E3WC0vYgKBZ2UyaZdkZFqjRUESxBK2MAv
 ZRmTpBdvBf1cFydn8NjmQQejTj9S3xPPJWdT0Lc9vSaFbrA8WZwDuUOjzGcbfjuCldm6
 hWTBJg6j/IDXxVAlYXHH/cfjOQIRxoRtzPMDW5RJZFLwLE3tgCYIoGy8GajE1lIToMPA
 V5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777555577; x=1778160377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LAFvzdF4AKXZm4VB5j+OeVQOBYIg2JT9k6ZcqSNxFCE=;
 b=PZ49BeyAbFFmVr4Ar/irbwD+uYtf3hwcqnjg0K/aHtffMXN55e8tP3nVRAlQPBPuGu
 yP68ibGqSUedfjGh3YSkG5rIipApm51XU2hFvzVgyx9F1Ghqf8FlmUSX4lJzNz580l4d
 bZHUipNomExZOVU2tj0HJBZivvUMo23HQi/5uIgkVSZFkMJRg/4wOSZ1D1vW5bO9W2ey
 MFB17yuF0BwUhpDlCH1sH3iDP6ZKTN2+SWvDoIRS73STHf4cyoFEwitDkVYrv6hAUXtr
 8eLVLZQIbHF8553+CDXKNPkOg4JWYpW9ZsONd2BTtwP7TpA6LftLeHgrNmoYF1PnYF5e
 4MeA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rw7gBCQ/AqVUnqKqSDRFdWG0c3Eh6lPs3y1zYKbWyvQvne80F7FNLlP/zUBte3iModdoLDQXd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZXw88QFPAYdGhvzwWvVPhCkUGNEVwdqKQV4t0cU4pav9dp8wh
 5ItRBi8Our0TYBIzP5NB6P5onP0fU8t1qfMISOfVchMG+YIcqaACiKAMeMVuvFM2PS3SAQDVnm7
 cnwGB/Kv6wDkYWg9cuGVqHQtSikgrTbI=
X-Gm-Gg: AeBDievNj4rW4gdZ+7SbJd7bI2J5xkX93lGWWh1er2t//L3dhCr4OAtBDON3rt4+YVj
 0hw1iapX3Cl6eexT3oZq7Zi0e8ufuqpLDg7QsXWEGKVbyXR8vNilqiz9rMDG8CL4qDsQVlzxeOg
 TS0rYnX/DU5u9M12ijCKXrvmeDjCaMCsSmiS7gf9WuRWfcVLYzCD8jnkF1fQjTLl/W2gG/ETlOg
 DyXfoEkYZ7GF/XD4zVrxybn6iDMKs0Elb3sgEuQcS3xZGkEludDKe2kulLo4rQS1d5/SNKeyccM
 hi+NLFjZTpS501ndWrgc6CpH1evBZG7gu6rj9LNs5tbrZe5EY2c24kEoueUbIao3K8OZwHOdDTj
 fJhBh
X-Received: by 2002:a05:7022:6988:b0:12d:ea50:3655 with SMTP id
 a92af1059eb24-12deaccfea9mr540384c88.4.1777555577007; Thu, 30 Apr 2026
 06:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260429202042.21718-1-jbmoore61@gmail.com>
 <6266086d-15d4-476d-a992-503509032dd7@amd.com>
 <CAPUYzBf8EBynRij60SR+EFg1Kn22cyykSOOPxo709bq0xhjpLw@mail.gmail.com>
 <acb467cf-0b2d-4733-8df2-23f1ed18b4fd@amd.com>
In-Reply-To: <acb467cf-0b2d-4733-8df2-23f1ed18b4fd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Apr 2026 09:26:04 -0400
X-Gm-Features: AVHnY4K67295pjG_-i9zIQeVgG89hI-bpchZk3Qv8WElT-chlHKoof91ND4ryRQ
Message-ID: <CADnq5_O=Yt+NZLYykwmHSC6Q7p7G86hpDaFKm5TzRFxd_jndpA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx: extract compute wptr doorbell helpers to
 amdgpu_gfx.c
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: John Moore <jbmoore61@gmail.com>, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Thu, Apr 30, 2026 at 9:22=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Hi John,
>
> On 4/30/26 14:32, John Moore wrote:
> > Hi Christian,
> >
> > Thanks for the review. All points addressed below.
> >
> >> That should probably be readq() instead of this horrible and not
> >> portable cast to atomic64_t.
> >>
> >> Alternatively we could just normally read the pointer with a memory
> >> barrier since this is just system memory.
> >
> > I went with the second option =E2=80=94 this is system memory (writebac=
k via
> > GTT), not MMIO, so readq() felt semantically wrong. The v2 uses:
> >
> >   get:  wptr =3D READ_ONCE(*(u64 *)ring->wptr_cpu_addr);
> >         smp_rmb();
>
> This needs to be rmb() and not smp_rmb(); smp_rmb() is only for CPU<->CPU=
 synchronization but here we need CPU<->device synchronization.
>
> And it needs to come *before* the read!
>
> >
> >   set:  WRITE_ONCE(*(u64 *)ring->wptr_cpu_addr, ring->wptr);
> >         smp_wmb();
>
> Same here, but this time least the barrier ordering is correct.
>
> >         WDOORBELL64(ring->doorbell_index, ring->wptr);
> >
> > The alignment is safe =E2=80=94 amdgpu_device_wb_get() returns offsets =
in
> > multiples of 8 dwords (32 bytes), so the u64* cast always lands on
> > a naturally-aligned address.
> >
> > One question: READ_ONCE on a u64 is not atomic on 32-bit
> > architectures (unlike atomic64_read which uses cmpxchg8b). DRM_AMDGPU
> > has no formal CONFIG_64BIT dependency in Kconfig, though in practice
> > nobody runs it on 32-bit.
>
> We still have some people trying to use it on 32bit kernels. We should ma=
ybe consider to drop the 32bit support.

32 bit support is the reason we used the atomic stuff in the first place.

Alex

>
> > Is READ_ONCE acceptable here, or would you
> > prefer readq() to keep the atomicity guarantee?
>
> Yeah good question I don't really know what to do here.
>
> On the one hand you are right, writeq()/readq() are not correct because t=
his isn't MMIO but system memory.
>
> On the other hand I don't think Linux has an architecture independent way=
 to guarantee that a write to system memory is done as an atomic 64bit writ=
e.
>
> What we need to guarantee is that the device never sees an incomplete val=
ue because the write is done as two 32bit writes.  That is probably the rea=
son why we used the atomic64_t hack in the first place.
>
> Regards,
> Christian.
>
> >
> >> Pre-requisite/error checking first please.
> >> Make that a if (WARN_ON(!ring->use_doorbell)) return.
> >
> > Done. Both functions now have the guard at the top:
> >
> >   if (WARN_ON(!ring->use_doorbell))
> >       return 0;  /* or return; for set_wptr */
> >
> >> And please don't use WARN_ON_ONCE() that is just to reduce the
> >> amount of warnings printed into the logs on real HW errors.
> >>
> >> On functional coding errors like this one here it doesn't make sense
> >> and is often overlooked.
> >
> > Understood =E2=80=94 changed to WARN_ON.
> >
> >> Same here the case to atomic64_t is extremely questionable.
> >
> > Fixed in set_wptr as well, same READ_ONCE/WRITE_ONCE approach.
> >
> > v2 incoming once I hear back on the readq vs READ_ONCE question.
> >
> > Thanks,
> > John
> >
> > "I will not be pushed, filed, stamped, indexed, briefed, debriefed, or =
numbered."
> > ~ The Prisoner
> >
> >
> >
> >
> > On Thu, Apr 30, 2026 at 2:19=E2=80=AFAM Christian K=C3=B6nig <christian=
.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
> >
> >     On 4/29/26 22:20, John B. Moore wrote:
> >     > Move the duplicated doorbell-based get_wptr/set_wptr functions fr=
om
> >     > gfx_v9_0.c, gfx_v10_0.c, gfx_v11_0.c, and gfx_v12_0.c into common
> >     > helpers amdgpu_gfx_get_wptr_compute() and amdgpu_gfx_set_wptr_com=
pute()
> >     > in amdgpu_gfx.c.
> >     >
> >     > These functions are not HW generation dependent -- the doorbell p=
ath is
> >     > identical across all four GFX versions:
> >     >
> >     >   get: atomic64_read(ring->wptr_cpu_addr)
> >     >   set: atomic64_set(ring->wptr_cpu_addr) + WDOORBELL64()
> >     >
> >     > The non-doorbell fallback is replaced with WARN_ON_ONCE instead o=
f BUG()
> >     > since doorbell is the only supported method on gfx9+ compute ring=
s.
> >     >
> >     > Not touched: gfx_v7_0, gfx_v8_0, gfx_v9_4_3 -- these have differe=
nt
> >     > wptr access patterns (MMIO registers or wb.wb[] offsets).
> >     >
> >     > Suggested-by: Alex Deucher <alexander.deucher@amd.com <mailto:ale=
xander.deucher@amd.com>>
> >     > Signed-off-by: John Moore <jbmoore61@gmail.com <mailto:jbmoore61@=
gmail.com>>
> >     > ---
> >     >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39 +++++++++++++++++++=
++++++
> >     >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
> >     >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 33 +++----------------=
--
> >     >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 34 +++----------------=
--
> >     >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 34 +++----------------=
--
> >     >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 39 +++----------------=
------
> >     >  6 files changed, 58 insertions(+), 124 deletions(-)
> >     >
> >     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_gfx.c
> >     > index 77578ecc6..9e9c5cb81 100644
> >     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >     > @@ -2596,3 +2596,42 @@ void amdgpu_debugfs_compute_sched_mask_ini=
t(struct amdgpu_device *adev)
> >     >  #endif
> >     >  }
> >     >
> >     > +/**
> >     > + * amdgpu_gfx_get_wptr_compute - common get_wptr for compute rin=
gs using doorbells
> >     > + * @ring: amdgpu_ring pointer
> >     > + *
> >     > + * Read the write pointer from the doorbell-mapped writeback add=
ress.
> >     > + * This is HW-agnostic and shared across GFX generations that us=
e
> >     > + * doorbell-based compute queue management.
> >     > + */
> >     > +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring)
> >     > +{
> >     > +     /* XXX check if swapping is necessary on BE */
> >     > +     if (ring->use_doorbell)
> >     > +             return atomic64_read((atomic64_t *)ring->wptr_cpu_a=
ddr);
> >
> >     That should probably be readq() instead of this horrible and not po=
rtable cast to atomic64_t.
> >
> >     Alternatively we could just normally read the pointer with a memory=
 barrier since this is just system memory.
> >
> >     > +
> >     > +     WARN_ON_ONCE(1);
> >
> >     Pre-requisite/error checking first please.
> >
> >     Make that a if (WARN_ON(!ring->use_doorbell)) return.
> >
> >     And please don't use WARN_ON_ONCE() that is just to reduce the amou=
nt of warnings printed into the logs on real HW errors.
> >
> >     On functional coding errors like this one here it doesn't make sens=
e and is often overlooked.
> >
> >     > +     return 0;
> >     > +}
> >     > +
> >     > +/**
> >     > + * amdgpu_gfx_set_wptr_compute - common set_wptr for compute rin=
gs using doorbells
> >     > + * @ring: amdgpu_ring pointer
> >     > + *
> >     > + * Write the write pointer to the doorbell-mapped writeback addr=
ess and
> >     > + * ring the doorbell.  This is HW-agnostic and shared across GFX
> >     > + * generations that use doorbell-based compute queue management.
> >     > + */
> >     > +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring)
> >     > +{
> >     > +     struct amdgpu_device *adev =3D ring->adev;
> >     > +
> >     > +     /* XXX check if swapping is necessary on BE */
> >     > +     if (ring->use_doorbell) {
> >     > +             atomic64_set((atomic64_t *)ring->wptr_cpu_addr, rin=
g->wptr);
> >
> >     Same here the case to atomic64_t is extremely questionable.
> >
> >     Regards,
> >     Christian.
> >
> >     > +             WDOORBELL64(ring->doorbell_index, ring->wptr);
> >     > +     } else {
> >     > +             WARN_ON_ONCE(1);
> >     > +     }
> >     > +}
> >     > +
> >     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_gfx.h
> >     > index 585cc8e81..27f6beafb 100644
> >     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >     > @@ -653,6 +653,9 @@ u32 amdgpu_gfx_csb_preamble_start(u32 *buffer=
);
> >     >  u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, u32 *=
buffer, u32 count);
> >     >  void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
> >     >
> >     > +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring);
> >     > +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring);
> >     > +
> >     >  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *ad=
ev);
> >     >  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device=
 *adev);
> >     >
> >     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu=
/drm/amd/amdgpu/gfx_v10_0.c
> >     > index 1893ceeeb..4c0272cba 100644
> >     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >     > @@ -8586,31 +8586,6 @@ static u64 gfx_v10_0_ring_get_rptr_compute=
(struct amdgpu_ring *ring)
> >     >       return *(uint32_t *)ring->rptr_cpu_addr;
> >     >  }
> >     >
> >     > -static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *r=
ing)
> >     > -{
> >     > -     u64 wptr;
> >     > -
> >     > -     /* XXX check if swapping is necessary on BE */
> >     > -     if (ring->use_doorbell)
> >     > -             wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu=
_addr);
> >     > -     else
> >     > -             BUG();
> >     > -     return wptr;
> >     > -}
> >     > -
> >     > -static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *=
ring)
> >     > -{
> >     > -     struct amdgpu_device *adev =3D ring->adev;
> >     > -
> >     > -     if (ring->use_doorbell) {
> >     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> >     > -                          ring->wptr);
> >     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
> >     > -     } else {
> >     > -             BUG(); /* only DOORBELL method supported on gfx10 n=
ow */
> >     > -     }
> >     > -}
> >     > -
> >     >  static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ri=
ng)
> >     >  {
> >     >       struct amdgpu_device *adev =3D ring->adev;
> >     > @@ -9881,8 +9856,8 @@ static const struct amdgpu_ring_funcs gfx_v=
10_0_ring_funcs_compute =3D {
> >     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >     >       .support_64bit_ptrs =3D true,
> >     >       .get_rptr =3D gfx_v10_0_ring_get_rptr_compute,
> >     > -     .get_wptr =3D gfx_v10_0_ring_get_wptr_compute,
> >     > -     .set_wptr =3D gfx_v10_0_ring_set_wptr_compute,
> >     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >     >       .emit_frame_size =3D
> >     >               20 + /* gfx_v10_0_ring_emit_gds_switch */
> >     >               7 + /* gfx_v10_0_ring_emit_hdp_flush */
> >     > @@ -9921,8 +9896,8 @@ static const struct amdgpu_ring_funcs gfx_v=
10_0_ring_funcs_kiq =3D {
> >     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >     >       .support_64bit_ptrs =3D true,
> >     >       .get_rptr =3D gfx_v10_0_ring_get_rptr_compute,
> >     > -     .get_wptr =3D gfx_v10_0_ring_get_wptr_compute,
> >     > -     .set_wptr =3D gfx_v10_0_ring_set_wptr_compute,
> >     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >     >       .emit_frame_size =3D
> >     >               20 + /* gfx_v10_0_ring_emit_gds_switch */
> >     >               7 + /* gfx_v10_0_ring_emit_hdp_flush */
> >     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu=
/drm/amd/amdgpu/gfx_v11_0.c
> >     > index 427975b5a..404604f2d 100644
> >     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >     > @@ -5818,32 +5818,6 @@ static u64 gfx_v11_0_ring_get_rptr_compute=
(struct amdgpu_ring *ring)
> >     >       return *(uint32_t *)ring->rptr_cpu_addr;
> >     >  }
> >     >
> >     > -static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring *r=
ing)
> >     > -{
> >     > -     u64 wptr;
> >     > -
> >     > -     /* XXX check if swapping is necessary on BE */
> >     > -     if (ring->use_doorbell)
> >     > -             wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu=
_addr);
> >     > -     else
> >     > -             BUG();
> >     > -     return wptr;
> >     > -}
> >     > -
> >     > -static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *=
ring)
> >     > -{
> >     > -     struct amdgpu_device *adev =3D ring->adev;
> >     > -
> >     > -     /* XXX check if swapping is necessary on BE */
> >     > -     if (ring->use_doorbell) {
> >     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> >     > -                          ring->wptr);
> >     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
> >     > -     } else {
> >     > -             BUG(); /* only DOORBELL method supported on gfx11 n=
ow */
> >     > -     }
> >     > -}
> >     > -
> >     >  static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ri=
ng)
> >     >  {
> >     >       struct amdgpu_device *adev =3D ring->adev;
> >     > @@ -7266,8 +7240,8 @@ static const struct amdgpu_ring_funcs gfx_v=
11_0_ring_funcs_compute =3D {
> >     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >     >       .support_64bit_ptrs =3D true,
> >     >       .get_rptr =3D gfx_v11_0_ring_get_rptr_compute,
> >     > -     .get_wptr =3D gfx_v11_0_ring_get_wptr_compute,
> >     > -     .set_wptr =3D gfx_v11_0_ring_set_wptr_compute,
> >     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >     >       .emit_frame_size =3D
> >     >               5 + /* update_spm_vmid */
> >     >               20 + /* gfx_v11_0_ring_emit_gds_switch */
> >     > @@ -7307,8 +7281,8 @@ static const struct amdgpu_ring_funcs gfx_v=
11_0_ring_funcs_kiq =3D {
> >     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >     >       .support_64bit_ptrs =3D true,
> >     >       .get_rptr =3D gfx_v11_0_ring_get_rptr_compute,
> >     > -     .get_wptr =3D gfx_v11_0_ring_get_wptr_compute,
> >     > -     .set_wptr =3D gfx_v11_0_ring_set_wptr_compute,
> >     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >     >       .emit_frame_size =3D
> >     >               20 + /* gfx_v11_0_ring_emit_gds_switch */
> >     >               7 + /* gfx_v11_0_ring_emit_hdp_flush */
> >     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu=
/drm/amd/amdgpu/gfx_v12_0.c
> >     > index 79ea1af36..7ba436444 100644
> >     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> >     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> >     > @@ -4363,32 +4363,6 @@ static u64 gfx_v12_0_ring_get_rptr_compute=
(struct amdgpu_ring *ring)
> >     >       return *(uint32_t *)ring->rptr_cpu_addr;
> >     >  }
> >     >
> >     > -static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring *r=
ing)
> >     > -{
> >     > -     u64 wptr;
> >     > -
> >     > -     /* XXX check if swapping is necessary on BE */
> >     > -     if (ring->use_doorbell)
> >     > -             wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu=
_addr);
> >     > -     else
> >     > -             BUG();
> >     > -     return wptr;
> >     > -}
> >     > -
> >     > -static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *=
ring)
> >     > -{
> >     > -     struct amdgpu_device *adev =3D ring->adev;
> >     > -
> >     > -     /* XXX check if swapping is necessary on BE */
> >     > -     if (ring->use_doorbell) {
> >     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> >     > -                          ring->wptr);
> >     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
> >     > -     } else {
> >     > -             BUG(); /* only DOORBELL method supported on gfx12 n=
ow */
> >     > -     }
> >     > -}
> >     > -
> >     >  static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ri=
ng)
> >     >  {
> >     >       struct amdgpu_device *adev =3D ring->adev;
> >     > @@ -5523,8 +5497,8 @@ static const struct amdgpu_ring_funcs gfx_v=
12_0_ring_funcs_compute =3D {
> >     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >     >       .support_64bit_ptrs =3D true,
> >     >       .get_rptr =3D gfx_v12_0_ring_get_rptr_compute,
> >     > -     .get_wptr =3D gfx_v12_0_ring_get_wptr_compute,
> >     > -     .set_wptr =3D gfx_v12_0_ring_set_wptr_compute,
> >     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >     >       .emit_frame_size =3D
> >     >               7 + /* gfx_v12_0_ring_emit_hdp_flush */
> >     >               5 + /* hdp invalidate */
> >     > @@ -5561,8 +5535,8 @@ static const struct amdgpu_ring_funcs gfx_v=
12_0_ring_funcs_kiq =3D {
> >     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >     >       .support_64bit_ptrs =3D true,
> >     >       .get_rptr =3D gfx_v12_0_ring_get_rptr_compute,
> >     > -     .get_wptr =3D gfx_v12_0_ring_get_wptr_compute,
> >     > -     .set_wptr =3D gfx_v12_0_ring_set_wptr_compute,
> >     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >     >       .emit_frame_size =3D
> >     >               7 + /* gfx_v12_0_ring_emit_hdp_flush */
> >     >               5 + /*hdp invalidate */
> >     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/=
drm/amd/amdgpu/gfx_v9_0.c
> >     > index 8249135d7..798f94bca 100644
> >     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >     > @@ -5640,37 +5640,6 @@ static u64 gfx_v9_0_ring_get_rptr_compute(=
struct amdgpu_ring *ring)
> >     >       return *ring->rptr_cpu_addr; /* gfx9 hardware is 32bit rptr=
 */
> >     >  }
> >     >
> >     > -static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ri=
ng)
> >     > -{
> >     > -     u64 wptr;
> >     > -
> >     > -     /* XXX check if swapping is necessary on BE */
> >     > -     if (ring->use_doorbell) {
> >     > -             wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu=
_addr);
> >     > -     } else {
> >     > -             WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr read on r=
ing %s, "
> >     > -                       "only doorbell method supported on gfx9\n=
",
> >     > -                       ring->name);
> >     > -             wptr =3D 0;
> >     > -     }
> >     > -     return wptr;
> >     > -}
> >     > -
> >     > -static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *r=
ing)
> >     > -{
> >     > -     struct amdgpu_device *adev =3D ring->adev;
> >     > -
> >     > -     /* XXX check if swapping is necessary on BE */
> >     > -     if (ring->use_doorbell) {
> >     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr, rin=
g->wptr);
> >     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
> >     > -     } else {
> >     > -             WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr write on =
ring %s, "
> >     > -                       "only doorbell method supported on gfx9\n=
",
> >     > -                       ring->name);
> >     > -     }
> >     > -}
> >     > -
> >     >  static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *rin=
g, u64 addr,
> >     >                                        u64 seq, unsigned int flag=
s)
> >     >  {
> >     > @@ -7627,8 +7596,8 @@ static const struct amdgpu_ring_funcs gfx_v=
9_0_ring_funcs_compute =3D {
> >     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >     >       .support_64bit_ptrs =3D true,
> >     >       .get_rptr =3D gfx_v9_0_ring_get_rptr_compute,
> >     > -     .get_wptr =3D gfx_v9_0_ring_get_wptr_compute,
> >     > -     .set_wptr =3D gfx_v9_0_ring_set_wptr_compute,
> >     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >     >       .emit_frame_size =3D
> >     >               20 + /* gfx_v9_0_ring_emit_gds_switch */
> >     >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> >     > @@ -7669,8 +7638,8 @@ static const struct amdgpu_ring_funcs gfx_v=
9_0_ring_funcs_kiq =3D {
> >     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >     >       .support_64bit_ptrs =3D true,
> >     >       .get_rptr =3D gfx_v9_0_ring_get_rptr_compute,
> >     > -     .get_wptr =3D gfx_v9_0_ring_get_wptr_compute,
> >     > -     .set_wptr =3D gfx_v9_0_ring_set_wptr_compute,
> >     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >     >       .emit_frame_size =3D
> >     >               20 + /* gfx_v9_0_ring_emit_gds_switch */
> >     >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> >
>
