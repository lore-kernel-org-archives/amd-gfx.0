Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8690FF885A
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2026 07:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8291510E4BB;
	Fri,  1 May 2026 07:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s5q7qN+u";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0955F10ED07
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 13:57:23 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-35e576110adso706197a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 06:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777557443; cv=none;
 d=google.com; s=arc-20240605;
 b=Dm9OfBTYYC+5nN0SsPCTwCK1P8EeEOWEJcyPvUOdqWIpgl3USvhzVcF4pv0M7NM1Dn
 5YRRNDjsPCLcJqaD6GZh229cYpPgarv9F9CJEgrnYR9LPg0aWfjOl5rVLaKiUXIfyIqd
 8qlQyBacjGTKyTJyObbaUSu2AOwEJ+rE9xNb7ly2YKpi/Aaq6GnnJ4RSprYwrNYeIID/
 R8orfFF6DyTKAtbZK4zv22d9vCCwIWXPtrInFnzDK+BaXkloDzFpY2nRrwballkWWMdP
 8J3OojuOhuMEhRuaqecWyl+cS8RgeiKLkU+9J2vGtCEtGzl10rncgLup0NN8jcy9eCqz
 l/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XXKnX7EpVMaRomE5jykrWnevdMv+dWtNhNUGXr9SmRA=;
 fh=ERmXp5WWNp3AKAzbaf22Z7bs3Me/DinZuzVutm3DexM=;
 b=GEcoqkZ7uxhZZzuOgajOcLS7TLM+Gfxi4Jioqd7AUCvQl9pHPtHmwlXGi/WR8eHTw7
 VboVY+gR/Gze28KrSXc9fesJzGRP3N9e5z6PnYwD5aEuhZKw0gfmbMhvAPg+i+GIG4hG
 8F+MbMTEFFHAahgvBb/lOMrgEKZ/eShuL/jvIXeyCuvCGtdpKHOnFh+uvIwkVfShzskx
 PcNdn3Z/iv+t4n5C2g104O+YcXAx7pIp5h+fIFzqT4zFYQq2pFSdDG7pfDnF4EZYfcSi
 x5aK66Wa9xIvnuNzjUQrlSoK+UKKIdQMtOyAwey8xYukJJFwjEeaCvttxBwd6WTkptzL
 bJjw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777557443; x=1778162243; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XXKnX7EpVMaRomE5jykrWnevdMv+dWtNhNUGXr9SmRA=;
 b=s5q7qN+uHVOgw85ZiQ31oFwhHDe3ollOTs9WVxq9XzxgafH1I6Xce5OpGfFoIsIrBU
 0Fl+xfuI79p/P7Il0GyRm+ztUv+ef2qheLf93zcvLaGPejF37WCDOKxcVkh0UwCMvf78
 vPbjLN7djl9VrJtKS2cOkUdcpauijkPDlgZay7haVJaqe6n6O82Tnn7NVkDs6ug0ZTQc
 EDFUxF9TjP4BrIcCEX2jyhAI3RYVm80R4xqPsbQ9OXPpjGh4MdVCrU6/pW71+ULcT/ui
 /koW5RoSHP1pNBx0DxbSf1NG/303168fUK9Xk/vIGZIazn8bQNPwGfLvOdJBIYstan9y
 jlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777557443; x=1778162243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XXKnX7EpVMaRomE5jykrWnevdMv+dWtNhNUGXr9SmRA=;
 b=KoiKek4WTw2SiHZLRW0kdvNcoEKcAZLU1JVtO+Remx3Xv+KugUa1aUOWpmmsF7H7Zi
 +WOQg/lUgWi0INMt3RYdjZfRY+Qe4NRXxwH5SCtqDZTOfNxmibR4v85tBUSidI4LhHPn
 m+D5f5P0JwkfwFYSUFq0Uvv2VReuB5cUFEZmWqP9gALhNPglAl9mgEuhAB9u3JDfgMl1
 XBi/3N+SRKl/qOoJI7Zwa6tP7Yxjjs//Qx0mgh9Q11dCWo9bW6HXbl7oJlXB3zxUIgav
 pjbRVfkYl9GYQYXld0vtN00Zwfc5mqvtnljpLlNq4NXgIOuDlXuNI9Q03NEl7RU8KEk2
 mzpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ87+IyClMckY5ng7uuJbRL4p1dz2ONmCXOdf0/39ZPW8gx9QBGhw+eENIj9nl0a3nbbKrhfHstQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3/vFYo62fbwDNIAh/Ve9ydD6TpXDedna6sHw0CxLnbT6UP1GQ
 terL67aANUw+NHWm1olHy/NLqEZGfTKJ1cB2LlcqLQinYuXPf4e0jYXJpaPF7Rtw9V4ZdII53N7
 AubS9CaZ+DIjCuOkMGstCVhf9KYWysQ==
X-Gm-Gg: AeBDietrf10SlkT9LWpsMo/j1zrSyzg24Scx/jKUH9PF2YRwowjMkxXi8XJ16XffaBP
 Yh1TmgkTf2cx9e/XZP5Nxdai/xDgW0Ftb9dygRmgbY6IWLpJUDk3i+1hksGpGbMlsHGhAFGHUkE
 PbPFgXI75y4953LIWRGYsE3CEhkH9aBlcGiBbklGzhTu8NNnQGtRXSXEgPywjbSmeAvI9kieR2S
 FLeKpKzeFmuDklcZ9TzGsIfJ7u2ierwfmJI5PWUA6f9bQ2EXv6iPlgVwm34NNql36PpZcAAOLNE
 rTLn52AoJfENfbUG5mrurD9D8oK4O+rakdUJ/4Z9zpyMqL1hdyAFcHzcyZIUC5gS1CfrBV8QRsN
 JXiI=
X-Received: by 2002:a17:90b:254a:b0:364:a497:db8f with SMTP id
 98e67ed59e1d1-364c49a00b6mr2583957a91.9.1777557443216; Thu, 30 Apr 2026
 06:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260429202042.21718-1-jbmoore61@gmail.com>
 <6266086d-15d4-476d-a992-503509032dd7@amd.com>
 <CAPUYzBf8EBynRij60SR+EFg1Kn22cyykSOOPxo709bq0xhjpLw@mail.gmail.com>
 <acb467cf-0b2d-4733-8df2-23f1ed18b4fd@amd.com>
 <CADnq5_O=Yt+NZLYykwmHSC6Q7p7G86hpDaFKm5TzRFxd_jndpA@mail.gmail.com>
 <dfc8935f-99c7-4666-bb34-0d01ad3bb8a8@amd.com>
In-Reply-To: <dfc8935f-99c7-4666-bb34-0d01ad3bb8a8@amd.com>
From: John Moore <jbmoore61@gmail.com>
Date: Thu, 30 Apr 2026 08:57:11 -0500
X-Gm-Features: AVHnY4KPGjyYn-VSzc382ARVbj2yKekR6lToFZ6k5ymT5CZ8DjG72UWAA-g4AbM
Message-ID: <CAPUYzBdKXTnj1caAFMWz0dt7jsDTpNaunhC=rqOZEVHKW3--OQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx: extract compute wptr doorbell helpers to
 amdgpu_gfx.c
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="000000000000f89fc70650add7e2"
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

--000000000000f89fc70650add7e2
Content-Type: multipart/alternative; boundary="000000000000f89fc70650add7e0"

--000000000000f89fc70650add7e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

I completely understand the issue and that you are stuck due to the
hardware architectures.
Thanks for the corrections on the barriers =E2=80=94 both fixed:

  get:  rmb();
        wptr =3D <read>(ring->wptr_cpu_addr);

  set:  <write>(ring->wptr_cpu_addr, ring->wptr);
        wmb();
        WDOORBELL64(ring->doorbell_index, ring->wptr);

rmb()/wmb() for CPU<->device, and the read barrier now comes before
the read.

On the 32-bit atomicity question =E2=80=94 understood, that's exactly why
the atomic64_t hack exists.  Since there's no clean arch-independent
way to do atomic 64-bit writes to system memory, I've prepared both
options as complete patches against amd-staging-drm-next so you can
pick whichever you prefer:

  Option A (attached): Keep atomic64_set()/atomic64_read() with the
  cast hidden behind a static inline helper (wptr_as_atomic).
  Preserves 32-bit atomicity.  Not pretty, but honest.

  Option B (attached): Use writeq()/readq() instead.  Atomic on all
  architectures, but semantically these are MMIO accessors being
  used on system memory.  Documented in comments.

Both patches compile clean, address all your review feedback (WARN_ON
at top, rmb/wmb, no WARN_ON_ONCE), and are identical except for the
read/write mechanism.

Regards,
John
"I will not be pushed, filed, stamped, indexed, briefed, debriefed, or
numbered."
~ The Prisoner




On Thu, Apr 30, 2026 at 8:49=E2=80=AFAM Christian K=C3=B6nig <christian.koe=
nig@amd.com>
wrote:

> On 4/30/26 15:26, Alex Deucher wrote:
> > On Thu, Apr 30, 2026 at 9:22=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> Hi John,
> >>
> >> On 4/30/26 14:32, John Moore wrote:
> >>> Hi Christian,
> >>>
> >>> Thanks for the review. All points addressed below.
> >>>
> >>>> That should probably be readq() instead of this horrible and not
> >>>> portable cast to atomic64_t.
> >>>>
> >>>> Alternatively we could just normally read the pointer with a memory
> >>>> barrier since this is just system memory.
> >>>
> >>> I went with the second option =E2=80=94 this is system memory (writeb=
ack via
> >>> GTT), not MMIO, so readq() felt semantically wrong. The v2 uses:
> >>>
> >>>   get:  wptr =3D READ_ONCE(*(u64 *)ring->wptr_cpu_addr);
> >>>         smp_rmb();
> >>
> >> This needs to be rmb() and not smp_rmb(); smp_rmb() is only for
> CPU<->CPU synchronization but here we need CPU<->device synchronization.
> >>
> >> And it needs to come *before* the read!
> >>
> >>>
> >>>   set:  WRITE_ONCE(*(u64 *)ring->wptr_cpu_addr, ring->wptr);
> >>>         smp_wmb();
> >>
> >> Same here, but this time least the barrier ordering is correct.
> >>
> >>>         WDOORBELL64(ring->doorbell_index, ring->wptr);
> >>>
> >>> The alignment is safe =E2=80=94 amdgpu_device_wb_get() returns offset=
s in
> >>> multiples of 8 dwords (32 bytes), so the u64* cast always lands on
> >>> a naturally-aligned address.
> >>>
> >>> One question: READ_ONCE on a u64 is not atomic on 32-bit
> >>> architectures (unlike atomic64_read which uses cmpxchg8b). DRM_AMDGPU
> >>> has no formal CONFIG_64BIT dependency in Kconfig, though in practice
> >>> nobody runs it on 32-bit.
> >>
> >> We still have some people trying to use it on 32bit kernels. We should
> maybe consider to drop the 32bit support.
> >
> > 32 bit support is the reason we used the atomic stuff in the first plac=
e.
>
> Yeah the problem is that is just and extremely ugly hack.
>
> IIRC there are architecture who can't do 64bit writes at all, on those
> systems an atomic_64 is implemented by using a lock.
>
> On the other hand I don't think anybody would be able to use HW AMDGPU
> supports on a SPARC, Alpha or +20 year old MIPS system because of the lac=
k
> of PCIe bus.
>
> My educated guess is that the correct answer is to have a config
> dependency to prevent AMDGPU from even compiling on such architectures an=
d
> then using a WRITE_ONCE()/READ_ONCE() with appropriate memory barriers.
>
> But of hand I don't know how that stuff is abstracted on the architecture
> side and which config option to depend on.
>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >>
> >>> Is READ_ONCE acceptable here, or would you
> >>> prefer readq() to keep the atomicity guarantee?
> >>
> >> Yeah good question I don't really know what to do here.
> >>
> >> On the one hand you are right, writeq()/readq() are not correct becaus=
e
> this isn't MMIO but system memory.
> >>
> >> On the other hand I don't think Linux has an architecture independent
> way to guarantee that a write to system memory is done as an atomic 64bit
> write.
> >>
> >> What we need to guarantee is that the device never sees an incomplete
> value because the write is done as two 32bit writes.  That is probably th=
e
> reason why we used the atomic64_t hack in the first place.
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>>> Pre-requisite/error checking first please.
> >>>> Make that a if (WARN_ON(!ring->use_doorbell)) return.
> >>>
> >>> Done. Both functions now have the guard at the top:
> >>>
> >>>   if (WARN_ON(!ring->use_doorbell))
> >>>       return 0;  /* or return; for set_wptr */
> >>>
> >>>> And please don't use WARN_ON_ONCE() that is just to reduce the
> >>>> amount of warnings printed into the logs on real HW errors.
> >>>>
> >>>> On functional coding errors like this one here it doesn't make sense
> >>>> and is often overlooked.
> >>>
> >>> Understood =E2=80=94 changed to WARN_ON.
> >>>
> >>>> Same here the case to atomic64_t is extremely questionable.
> >>>
> >>> Fixed in set_wptr as well, same READ_ONCE/WRITE_ONCE approach.
> >>>
> >>> v2 incoming once I hear back on the readq vs READ_ONCE question.
> >>>
> >>> Thanks,
> >>> John
> >>>
> >>> "I will not be pushed, filed, stamped, indexed, briefed, debriefed, o=
r
> numbered."
> >>> ~ The Prisoner
> >>>
> >>>
> >>>
> >>>
> >>> On Thu, Apr 30, 2026 at 2:19=E2=80=AFAM Christian K=C3=B6nig <
> christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
> >>>
> >>>     On 4/29/26 22:20, John B. Moore wrote:
> >>>     > Move the duplicated doorbell-based get_wptr/set_wptr functions
> from
> >>>     > gfx_v9_0.c, gfx_v10_0.c, gfx_v11_0.c, and gfx_v12_0.c into comm=
on
> >>>     > helpers amdgpu_gfx_get_wptr_compute() and
> amdgpu_gfx_set_wptr_compute()
> >>>     > in amdgpu_gfx.c.
> >>>     >
> >>>     > These functions are not HW generation dependent -- the doorbell
> path is
> >>>     > identical across all four GFX versions:
> >>>     >
> >>>     >   get: atomic64_read(ring->wptr_cpu_addr)
> >>>     >   set: atomic64_set(ring->wptr_cpu_addr) + WDOORBELL64()
> >>>     >
> >>>     > The non-doorbell fallback is replaced with WARN_ON_ONCE instead
> of BUG()
> >>>     > since doorbell is the only supported method on gfx9+ compute
> rings.
> >>>     >
> >>>     > Not touched: gfx_v7_0, gfx_v8_0, gfx_v9_4_3 -- these have
> different
> >>>     > wptr access patterns (MMIO registers or wb.wb[] offsets).
> >>>     >
> >>>     > Suggested-by: Alex Deucher <alexander.deucher@amd.com <mailto:
> alexander.deucher@amd.com>>
> >>>     > Signed-off-by: John Moore <jbmoore61@gmail.com <mailto:
> jbmoore61@gmail.com>>
> >>>     > ---
> >>>     >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39
> +++++++++++++++++++++++++
> >>>     >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
> >>>     >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 33
> +++------------------
> >>>     >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 34
> +++------------------
> >>>     >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 34
> +++------------------
> >>>     >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 39
> +++----------------------
> >>>     >  6 files changed, 58 insertions(+), 124 deletions(-)
> >>>     >
> >>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >>>     > index 77578ecc6..9e9c5cb81 100644
> >>>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >>>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >>>     > @@ -2596,3 +2596,42 @@ void
> amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
> >>>     >  #endif
> >>>     >  }
> >>>     >
> >>>     > +/**
> >>>     > + * amdgpu_gfx_get_wptr_compute - common get_wptr for compute
> rings using doorbells
> >>>     > + * @ring: amdgpu_ring pointer
> >>>     > + *
> >>>     > + * Read the write pointer from the doorbell-mapped writeback
> address.
> >>>     > + * This is HW-agnostic and shared across GFX generations that
> use
> >>>     > + * doorbell-based compute queue management.
> >>>     > + */
> >>>     > +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring)
> >>>     > +{
> >>>     > +     /* XXX check if swapping is necessary on BE */
> >>>     > +     if (ring->use_doorbell)
> >>>     > +             return atomic64_read((atomic64_t
> *)ring->wptr_cpu_addr);
> >>>
> >>>     That should probably be readq() instead of this horrible and not
> portable cast to atomic64_t.
> >>>
> >>>     Alternatively we could just normally read the pointer with a
> memory barrier since this is just system memory.
> >>>
> >>>     > +
> >>>     > +     WARN_ON_ONCE(1);
> >>>
> >>>     Pre-requisite/error checking first please.
> >>>
> >>>     Make that a if (WARN_ON(!ring->use_doorbell)) return.
> >>>
> >>>     And please don't use WARN_ON_ONCE() that is just to reduce the
> amount of warnings printed into the logs on real HW errors.
> >>>
> >>>     On functional coding errors like this one here it doesn't make
> sense and is often overlooked.
> >>>
> >>>     > +     return 0;
> >>>     > +}
> >>>     > +
> >>>     > +/**
> >>>     > + * amdgpu_gfx_set_wptr_compute - common set_wptr for compute
> rings using doorbells
> >>>     > + * @ring: amdgpu_ring pointer
> >>>     > + *
> >>>     > + * Write the write pointer to the doorbell-mapped writeback
> address and
> >>>     > + * ring the doorbell.  This is HW-agnostic and shared across G=
FX
> >>>     > + * generations that use doorbell-based compute queue managemen=
t.
> >>>     > + */
> >>>     > +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring)
> >>>     > +{
> >>>     > +     struct amdgpu_device *adev =3D ring->adev;
> >>>     > +
> >>>     > +     /* XXX check if swapping is necessary on BE */
> >>>     > +     if (ring->use_doorbell) {
> >>>     > +             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> ring->wptr);
> >>>
> >>>     Same here the case to atomic64_t is extremely questionable.
> >>>
> >>>     Regards,
> >>>     Christian.
> >>>
> >>>     > +             WDOORBELL64(ring->doorbell_index, ring->wptr);
> >>>     > +     } else {
> >>>     > +             WARN_ON_ONCE(1);
> >>>     > +     }
> >>>     > +}
> >>>     > +
> >>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>>     > index 585cc8e81..27f6beafb 100644
> >>>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>>     > @@ -653,6 +653,9 @@ u32 amdgpu_gfx_csb_preamble_start(u32
> *buffer);
> >>>     >  u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, u32
> *buffer, u32 count);
> >>>     >  void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
> >>>     >
> >>>     > +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring);
> >>>     > +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring);
> >>>     > +
> >>>     >  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device
> *adev);
> >>>     >  void amdgpu_debugfs_compute_sched_mask_init(struct
> amdgpu_device *adev);
> >>>     >
> >>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>>     > index 1893ceeeb..4c0272cba 100644
> >>>     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>>     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>>     > @@ -8586,31 +8586,6 @@ static u64
> gfx_v10_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
> >>>     >       return *(uint32_t *)ring->rptr_cpu_addr;
> >>>     >  }
> >>>     >
> >>>     > -static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring
> *ring)
> >>>     > -{
> >>>     > -     u64 wptr;
> >>>     > -
> >>>     > -     /* XXX check if swapping is necessary on BE */
> >>>     > -     if (ring->use_doorbell)
> >>>     > -             wptr =3D atomic64_read((atomic64_t
> *)ring->wptr_cpu_addr);
> >>>     > -     else
> >>>     > -             BUG();
> >>>     > -     return wptr;
> >>>     > -}
> >>>     > -
> >>>     > -static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring
> *ring)
> >>>     > -{
> >>>     > -     struct amdgpu_device *adev =3D ring->adev;
> >>>     > -
> >>>     > -     if (ring->use_doorbell) {
> >>>     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> >>>     > -                          ring->wptr);
> >>>     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
> >>>     > -     } else {
> >>>     > -             BUG(); /* only DOORBELL method supported on gfx10
> now */
> >>>     > -     }
> >>>     > -}
> >>>     > -
> >>>     >  static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring
> *ring)
> >>>     >  {
> >>>     >       struct amdgpu_device *adev =3D ring->adev;
> >>>     > @@ -9881,8 +9856,8 @@ static const struct amdgpu_ring_funcs
> gfx_v10_0_ring_funcs_compute =3D {
> >>>     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >>>     >       .support_64bit_ptrs =3D true,
> >>>     >       .get_rptr =3D gfx_v10_0_ring_get_rptr_compute,
> >>>     > -     .get_wptr =3D gfx_v10_0_ring_get_wptr_compute,
> >>>     > -     .set_wptr =3D gfx_v10_0_ring_set_wptr_compute,
> >>>     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >>>     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >>>     >       .emit_frame_size =3D
> >>>     >               20 + /* gfx_v10_0_ring_emit_gds_switch */
> >>>     >               7 + /* gfx_v10_0_ring_emit_hdp_flush */
> >>>     > @@ -9921,8 +9896,8 @@ static const struct amdgpu_ring_funcs
> gfx_v10_0_ring_funcs_kiq =3D {
> >>>     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >>>     >       .support_64bit_ptrs =3D true,
> >>>     >       .get_rptr =3D gfx_v10_0_ring_get_rptr_compute,
> >>>     > -     .get_wptr =3D gfx_v10_0_ring_get_wptr_compute,
> >>>     > -     .set_wptr =3D gfx_v10_0_ring_set_wptr_compute,
> >>>     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >>>     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >>>     >       .emit_frame_size =3D
> >>>     >               20 + /* gfx_v10_0_ring_emit_gds_switch */
> >>>     >               7 + /* gfx_v10_0_ring_emit_hdp_flush */
> >>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>>     > index 427975b5a..404604f2d 100644
> >>>     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>>     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>>     > @@ -5818,32 +5818,6 @@ static u64
> gfx_v11_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
> >>>     >       return *(uint32_t *)ring->rptr_cpu_addr;
> >>>     >  }
> >>>     >
> >>>     > -static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring
> *ring)
> >>>     > -{
> >>>     > -     u64 wptr;
> >>>     > -
> >>>     > -     /* XXX check if swapping is necessary on BE */
> >>>     > -     if (ring->use_doorbell)
> >>>     > -             wptr =3D atomic64_read((atomic64_t
> *)ring->wptr_cpu_addr);
> >>>     > -     else
> >>>     > -             BUG();
> >>>     > -     return wptr;
> >>>     > -}
> >>>     > -
> >>>     > -static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring
> *ring)
> >>>     > -{
> >>>     > -     struct amdgpu_device *adev =3D ring->adev;
> >>>     > -
> >>>     > -     /* XXX check if swapping is necessary on BE */
> >>>     > -     if (ring->use_doorbell) {
> >>>     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> >>>     > -                          ring->wptr);
> >>>     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
> >>>     > -     } else {
> >>>     > -             BUG(); /* only DOORBELL method supported on gfx11
> now */
> >>>     > -     }
> >>>     > -}
> >>>     > -
> >>>     >  static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring
> *ring)
> >>>     >  {
> >>>     >       struct amdgpu_device *adev =3D ring->adev;
> >>>     > @@ -7266,8 +7240,8 @@ static const struct amdgpu_ring_funcs
> gfx_v11_0_ring_funcs_compute =3D {
> >>>     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >>>     >       .support_64bit_ptrs =3D true,
> >>>     >       .get_rptr =3D gfx_v11_0_ring_get_rptr_compute,
> >>>     > -     .get_wptr =3D gfx_v11_0_ring_get_wptr_compute,
> >>>     > -     .set_wptr =3D gfx_v11_0_ring_set_wptr_compute,
> >>>     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >>>     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >>>     >       .emit_frame_size =3D
> >>>     >               5 + /* update_spm_vmid */
> >>>     >               20 + /* gfx_v11_0_ring_emit_gds_switch */
> >>>     > @@ -7307,8 +7281,8 @@ static const struct amdgpu_ring_funcs
> gfx_v11_0_ring_funcs_kiq =3D {
> >>>     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >>>     >       .support_64bit_ptrs =3D true,
> >>>     >       .get_rptr =3D gfx_v11_0_ring_get_rptr_compute,
> >>>     > -     .get_wptr =3D gfx_v11_0_ring_get_wptr_compute,
> >>>     > -     .set_wptr =3D gfx_v11_0_ring_set_wptr_compute,
> >>>     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >>>     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >>>     >       .emit_frame_size =3D
> >>>     >               20 + /* gfx_v11_0_ring_emit_gds_switch */
> >>>     >               7 + /* gfx_v11_0_ring_emit_hdp_flush */
> >>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> >>>     > index 79ea1af36..7ba436444 100644
> >>>     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> >>>     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> >>>     > @@ -4363,32 +4363,6 @@ static u64
> gfx_v12_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
> >>>     >       return *(uint32_t *)ring->rptr_cpu_addr;
> >>>     >  }
> >>>     >
> >>>     > -static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring
> *ring)
> >>>     > -{
> >>>     > -     u64 wptr;
> >>>     > -
> >>>     > -     /* XXX check if swapping is necessary on BE */
> >>>     > -     if (ring->use_doorbell)
> >>>     > -             wptr =3D atomic64_read((atomic64_t
> *)ring->wptr_cpu_addr);
> >>>     > -     else
> >>>     > -             BUG();
> >>>     > -     return wptr;
> >>>     > -}
> >>>     > -
> >>>     > -static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring
> *ring)
> >>>     > -{
> >>>     > -     struct amdgpu_device *adev =3D ring->adev;
> >>>     > -
> >>>     > -     /* XXX check if swapping is necessary on BE */
> >>>     > -     if (ring->use_doorbell) {
> >>>     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> >>>     > -                          ring->wptr);
> >>>     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
> >>>     > -     } else {
> >>>     > -             BUG(); /* only DOORBELL method supported on gfx12
> now */
> >>>     > -     }
> >>>     > -}
> >>>     > -
> >>>     >  static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring
> *ring)
> >>>     >  {
> >>>     >       struct amdgpu_device *adev =3D ring->adev;
> >>>     > @@ -5523,8 +5497,8 @@ static const struct amdgpu_ring_funcs
> gfx_v12_0_ring_funcs_compute =3D {
> >>>     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >>>     >       .support_64bit_ptrs =3D true,
> >>>     >       .get_rptr =3D gfx_v12_0_ring_get_rptr_compute,
> >>>     > -     .get_wptr =3D gfx_v12_0_ring_get_wptr_compute,
> >>>     > -     .set_wptr =3D gfx_v12_0_ring_set_wptr_compute,
> >>>     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >>>     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >>>     >       .emit_frame_size =3D
> >>>     >               7 + /* gfx_v12_0_ring_emit_hdp_flush */
> >>>     >               5 + /* hdp invalidate */
> >>>     > @@ -5561,8 +5535,8 @@ static const struct amdgpu_ring_funcs
> gfx_v12_0_ring_funcs_kiq =3D {
> >>>     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >>>     >       .support_64bit_ptrs =3D true,
> >>>     >       .get_rptr =3D gfx_v12_0_ring_get_rptr_compute,
> >>>     > -     .get_wptr =3D gfx_v12_0_ring_get_wptr_compute,
> >>>     > -     .set_wptr =3D gfx_v12_0_ring_set_wptr_compute,
> >>>     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >>>     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >>>     >       .emit_frame_size =3D
> >>>     >               7 + /* gfx_v12_0_ring_emit_hdp_flush */
> >>>     >               5 + /*hdp invalidate */
> >>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >>>     > index 8249135d7..798f94bca 100644
> >>>     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >>>     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >>>     > @@ -5640,37 +5640,6 @@ static u64
> gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
> >>>     >       return *ring->rptr_cpu_addr; /* gfx9 hardware is 32bit
> rptr */
> >>>     >  }
> >>>     >
> >>>     > -static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring
> *ring)
> >>>     > -{
> >>>     > -     u64 wptr;
> >>>     > -
> >>>     > -     /* XXX check if swapping is necessary on BE */
> >>>     > -     if (ring->use_doorbell) {
> >>>     > -             wptr =3D atomic64_read((atomic64_t
> *)ring->wptr_cpu_addr);
> >>>     > -     } else {
> >>>     > -             WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr read on
> ring %s, "
> >>>     > -                       "only doorbell method supported on
> gfx9\n",
> >>>     > -                       ring->name);
> >>>     > -             wptr =3D 0;
> >>>     > -     }
> >>>     > -     return wptr;
> >>>     > -}
> >>>     > -
> >>>     > -static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring
> *ring)
> >>>     > -{
> >>>     > -     struct amdgpu_device *adev =3D ring->adev;
> >>>     > -
> >>>     > -     /* XXX check if swapping is necessary on BE */
> >>>     > -     if (ring->use_doorbell) {
> >>>     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> ring->wptr);
> >>>     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
> >>>     > -     } else {
> >>>     > -             WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr write o=
n
> ring %s, "
> >>>     > -                       "only doorbell method supported on
> gfx9\n",
> >>>     > -                       ring->name);
> >>>     > -     }
> >>>     > -}
> >>>     > -
> >>>     >  static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring
> *ring, u64 addr,
> >>>     >                                        u64 seq, unsigned int
> flags)
> >>>     >  {
> >>>     > @@ -7627,8 +7596,8 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_ring_funcs_compute =3D {
> >>>     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >>>     >       .support_64bit_ptrs =3D true,
> >>>     >       .get_rptr =3D gfx_v9_0_ring_get_rptr_compute,
> >>>     > -     .get_wptr =3D gfx_v9_0_ring_get_wptr_compute,
> >>>     > -     .set_wptr =3D gfx_v9_0_ring_set_wptr_compute,
> >>>     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >>>     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >>>     >       .emit_frame_size =3D
> >>>     >               20 + /* gfx_v9_0_ring_emit_gds_switch */
> >>>     >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> >>>     > @@ -7669,8 +7638,8 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_ring_funcs_kiq =3D {
> >>>     >       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> >>>     >       .support_64bit_ptrs =3D true,
> >>>     >       .get_rptr =3D gfx_v9_0_ring_get_rptr_compute,
> >>>     > -     .get_wptr =3D gfx_v9_0_ring_get_wptr_compute,
> >>>     > -     .set_wptr =3D gfx_v9_0_ring_set_wptr_compute,
> >>>     > +     .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> >>>     > +     .set_wptr =3D amdgpu_gfx_set_wptr_compute,
> >>>     >       .emit_frame_size =3D
> >>>     >               20 + /* gfx_v9_0_ring_emit_gds_switch */
> >>>     >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> >>>
> >>
>
>

--000000000000f89fc70650add7e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Christian,<br><br>I completely un=
derstand the issue and that you are stuck due to the hardware architectures=
.<br>Thanks for the corrections on the barriers =E2=80=94 both fixed:<br><b=
r>=C2=A0 get: =C2=A0rmb();<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 wptr =3D &lt;read=
&gt;(ring-&gt;wptr_cpu_addr);<br><br>=C2=A0 set: =C2=A0&lt;write&gt;(ring-&=
gt;wptr_cpu_addr, ring-&gt;wptr);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 wmb();<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 WDOORBELL64(ring-&gt;doorbell_index, ring-&gt;w=
ptr);<br><br>rmb()/wmb() for CPU&lt;-&gt;device, and the read barrier now c=
omes before<br>the read.<br><br>On the 32-bit atomicity question =E2=80=94 =
understood, that&#39;s exactly why<br>the atomic64_t hack exists.=C2=A0 Sin=
ce there&#39;s no clean arch-independent<br>way to do atomic 64-bit writes =
to system memory, I&#39;ve prepared both<br>options as complete patches aga=
inst amd-staging-drm-next so you can<br>pick whichever you prefer:<br><br>=
=C2=A0 Option A (attached): Keep atomic64_set()/atomic64_read() with the<br=
>=C2=A0 cast hidden behind a static inline helper (wptr_as_atomic).<br>=C2=
=A0 Preserves 32-bit atomicity.=C2=A0 Not pretty, but honest.<br><br>=C2=A0=
 Option B (attached): Use writeq()/readq() instead.=C2=A0 Atomic on all<br>=
=C2=A0 architectures, but semantically these are MMIO accessors being<br>=
=C2=A0 used on system memory.=C2=A0 Documented in comments.<br><br>Both pat=
ches compile clean, address all your review feedback (WARN_ON<br>at top, rm=
b/wmb, no WARN_ON_ONCE), and are identical except for the<br>read/write mec=
hanism.<br><br>Regards,<br>John</div><div><div dir=3D"ltr" class=3D"gmail_s=
ignature">&quot;I will not be pushed, filed, stamped, indexed, briefed, deb=
riefed, or numbered.&quot;<br>~ The Prisoner<br><br><br></div></div><br></d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Thu, Apr 30, 2026 at 8:49=E2=80=AFAM Christian K=C3=
=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.com">christian.koenig@amd=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 4/30/26 15:26, Alex Deucher wrote:<br>
&gt; On Thu, Apr 30, 2026 at 9:22=E2=80=AFAM Christian K=C3=B6nig<br>
&gt; &lt;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">chri=
stian.koenig@amd.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi John,<br>
&gt;&gt;<br>
&gt;&gt; On 4/30/26 14:32, John Moore wrote:<br>
&gt;&gt;&gt; Hi Christian,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks for the review. All points addressed below.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; That should probably be readq() instead of this horrible a=
nd not<br>
&gt;&gt;&gt;&gt; portable cast to atomic64_t.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Alternatively we could just normally read the pointer with=
 a memory<br>
&gt;&gt;&gt;&gt; barrier since this is just system memory.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I went with the second option =E2=80=94 this is system memory =
(writeback via<br>
&gt;&gt;&gt; GTT), not MMIO, so readq() felt semantically wrong. The v2 use=
s:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0get:=C2=A0 wptr =3D READ_ONCE(*(u64 *)ring-&gt;wpt=
r_cpu_addr);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smp_rmb();<br>
&gt;&gt;<br>
&gt;&gt; This needs to be rmb() and not smp_rmb(); smp_rmb() is only for CP=
U&lt;-&gt;CPU synchronization but here we need CPU&lt;-&gt;device synchroni=
zation.<br>
&gt;&gt;<br>
&gt;&gt; And it needs to come *before* the read!<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0set:=C2=A0 WRITE_ONCE(*(u64 *)ring-&gt;wptr_cpu_ad=
dr, ring-&gt;wptr);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smp_wmb();<br>
&gt;&gt;<br>
&gt;&gt; Same here, but this time least the barrier ordering is correct.<br=
>
&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WDOORBELL64(ring-&gt;doorbell=
_index, ring-&gt;wptr);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The alignment is safe =E2=80=94 amdgpu_device_wb_get() returns=
 offsets in<br>
&gt;&gt;&gt; multiples of 8 dwords (32 bytes), so the u64* cast always land=
s on<br>
&gt;&gt;&gt; a naturally-aligned address.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; One question: READ_ONCE on a u64 is not atomic on 32-bit<br>
&gt;&gt;&gt; architectures (unlike atomic64_read which uses cmpxchg8b). DRM=
_AMDGPU<br>
&gt;&gt;&gt; has no formal CONFIG_64BIT dependency in Kconfig, though in pr=
actice<br>
&gt;&gt;&gt; nobody runs it on 32-bit.<br>
&gt;&gt;<br>
&gt;&gt; We still have some people trying to use it on 32bit kernels. We sh=
ould maybe consider to drop the 32bit support.<br>
&gt; <br>
&gt; 32 bit support is the reason we used the atomic stuff in the first pla=
ce.<br>
<br>
Yeah the problem is that is just and extremely ugly hack.<br>
<br>
IIRC there are architecture who can&#39;t do 64bit writes at all, on those =
systems an atomic_64 is implemented by using a lock.<br>
<br>
On the other hand I don&#39;t think anybody would be able to use HW AMDGPU =
supports on a SPARC, Alpha or +20 year old MIPS system because of the lack =
of PCIe bus.<br>
<br>
My educated guess is that the correct answer is to have a config dependency=
 to prevent AMDGPU from even compiling on such architectures and then using=
 a WRITE_ONCE()/READ_ONCE() with appropriate memory barriers.<br>
<br>
But of hand I don&#39;t know how that stuff is abstracted on the architectu=
re side and which config option to depend on.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; <br>
&gt; Alex<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt;&gt; Is READ_ONCE acceptable here, or would you<br>
&gt;&gt;&gt; prefer readq() to keep the atomicity guarantee?<br>
&gt;&gt;<br>
&gt;&gt; Yeah good question I don&#39;t really know what to do here.<br>
&gt;&gt;<br>
&gt;&gt; On the one hand you are right, writeq()/readq() are not correct be=
cause this isn&#39;t MMIO but system memory.<br>
&gt;&gt;<br>
&gt;&gt; On the other hand I don&#39;t think Linux has an architecture inde=
pendent way to guarantee that a write to system memory is done as an atomic=
 64bit write.<br>
&gt;&gt;<br>
&gt;&gt; What we need to guarantee is that the device never sees an incompl=
ete value because the write is done as two 32bit writes.=C2=A0 That is prob=
ably the reason why we used the atomic64_t hack in the first place.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Pre-requisite/error checking first please.<br>
&gt;&gt;&gt;&gt; Make that a if (WARN_ON(!ring-&gt;use_doorbell)) return.<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Done. Both functions now have the guard at the top:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0if (WARN_ON(!ring-&gt;use_doorbell))<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;=C2=A0 /* or return; for se=
t_wptr */<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; And please don&#39;t use WARN_ON_ONCE() that is just to re=
duce the<br>
&gt;&gt;&gt;&gt; amount of warnings printed into the logs on real HW errors=
.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On functional coding errors like this one here it doesn&#3=
9;t make sense<br>
&gt;&gt;&gt;&gt; and is often overlooked.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Understood =E2=80=94 changed to WARN_ON.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Same here the case to atomic64_t is extremely questionable=
.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Fixed in set_wptr as well, same READ_ONCE/WRITE_ONCE approach.=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v2 incoming once I hear back on the readq vs READ_ONCE questio=
n.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; John<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &quot;I will not be pushed, filed, stamped, indexed, briefed, =
debriefed, or numbered.&quot;<br>
&gt;&gt;&gt; ~ The Prisoner<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Thu, Apr 30, 2026 at 2:19=E2=80=AFAM Christian K=C3=B6nig &=
lt;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.=
koenig@amd.com</a> &lt;mailto:<a href=3D"mailto:christian.koenig@amd.com" t=
arget=3D"_blank">christian.koenig@amd.com</a>&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0On 4/29/26 22:20, John B. Moore wrote:<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Move the duplicated doorbell-based get=
_wptr/set_wptr functions from<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; gfx_v9_0.c, gfx_v10_0.c, gfx_v11_0.c, =
and gfx_v12_0.c into common<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; helpers amdgpu_gfx_get_wptr_compute() =
and amdgpu_gfx_set_wptr_compute()<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; in amdgpu_gfx.c.<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; These functions are not HW generation =
dependent -- the doorbell path is<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; identical across all four GFX versions=
:<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0get: atomic64_read(ring-&g=
t;wptr_cpu_addr)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0set: atomic64_set(ring-&gt=
;wptr_cpu_addr) + WDOORBELL64()<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; The non-doorbell fallback is replaced =
with WARN_ON_ONCE instead of BUG()<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; since doorbell is the only supported m=
ethod on gfx9+ compute rings.<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Not touched: gfx_v7_0, gfx_v8_0, gfx_v=
9_4_3 -- these have different<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; wptr access patterns (MMIO registers o=
r wb.wb[] offsets).<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Suggested-by: Alex Deucher &lt;<a href=
=3D"mailto:alexander.deucher@amd.com" target=3D"_blank">alexander.deucher@a=
md.com</a> &lt;mailto:<a href=3D"mailto:alexander.deucher@amd.com" target=
=3D"_blank">alexander.deucher@amd.com</a>&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: John Moore &lt;<a href=
=3D"mailto:jbmoore61@gmail.com" target=3D"_blank">jbmoore61@gmail.com</a> &=
lt;mailto:<a href=3D"mailto:jbmoore61@gmail.com" target=3D"_blank">jbmoore6=
1@gmail.com</a>&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgp=
u_gfx.c | 39 +++++++++++++++++++++++++<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgp=
u_gfx.h |=C2=A0 3 ++<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v=
10_0.c=C2=A0 | 33 +++------------------<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v=
11_0.c=C2=A0 | 34 +++------------------<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v=
12_0.c=C2=A0 | 34 +++------------------<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v=
9_0.c=C2=A0 =C2=A0| 39 +++----------------------<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 6 files changed, 58 insertions(+=
), 124 deletions(-)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/drivers/gpu/drm/amd/amdgp=
u/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 77578ecc6..9e9c5cb81 100644<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgp=
u_gfx.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_gfx.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -2596,3 +2596,42 @@ void amdgpu_deb=
ugfs_compute_sched_mask_init(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 #endif<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 }<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +/**<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * amdgpu_gfx_get_wptr_compute - comm=
on get_wptr for compute rings using doorbells<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * @ring: amdgpu_ring pointer<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + *<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * Read the write pointer from the do=
orbell-mapped writeback address.<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * This is HW-agnostic and shared acr=
oss GFX generations that use<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * doorbell-based compute queue manag=
ement.<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +u64 amdgpu_gfx_get_wptr_compute(struc=
t amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +{<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0/* XXX check if s=
wapping is necessary on BE */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_=
doorbell)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return atomic64_read((atomic64_t *)ring-&gt;wptr_cpu_addr);<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0That should probably be readq() instead of =
this horrible and not portable cast to atomic64_t.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Alternatively we could just normally read t=
he pointer with a memory barrier since this is just system memory.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0WARN_ON_ONCE(1);<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Pre-requisite/error checking first please.<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Make that a if (WARN_ON(!ring-&gt;use_doorb=
ell)) return.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0And please don&#39;t use WARN_ON_ONCE() tha=
t is just to reduce the amount of warnings printed into the logs on real HW=
 errors.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0On functional coding errors like this one h=
ere it doesn&#39;t make sense and is often overlooked.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +/**<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * amdgpu_gfx_set_wptr_compute - comm=
on set_wptr for compute rings using doorbells<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * @ring: amdgpu_ring pointer<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + *<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * Write the write pointer to the doo=
rbell-mapped writeback address and<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * ring the doorbell.=C2=A0 This is H=
W-agnostic and shared across GFX<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * generations that use doorbell-base=
d compute queue management.<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +void amdgpu_gfx_set_wptr_compute(stru=
ct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +{<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_dev=
ice *adev =3D ring-&gt;adev;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0/* XXX check if s=
wapping is necessary on BE */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_=
doorbell) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0atomic64_set((atomic64_t *)ring-&gt;wptr_cpu_addr, ring-&gt;wp=
tr);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Same here the case to atomic64_t is extreme=
ly questionable.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Regards,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Christian.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0WDOORBELL64(ring-&gt;doorbell_index, ring-&gt;wptr);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0WARN_ON_ONCE(1);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/drivers/gpu/drm/amd/amdgp=
u/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 585cc8e81..27f6beafb 100644<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgp=
u_gfx.h<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_gfx.h<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -653,6 +653,9 @@ u32 amdgpu_gfx_csb=
_preamble_start(u32 *buffer);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 u32 amdgpu_gfx_csb_data_parser(s=
truct amdgpu_device *adev, u32 *buffer, u32 count);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 void amdgpu_gfx_csb_preamble_end=
(u32 *buffer, u32 count);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +u64 amdgpu_gfx_get_wptr_compute(struc=
t amdgpu_ring *ring);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +void amdgpu_gfx_set_wptr_compute(stru=
ct amdgpu_ring *ring);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 void amdgpu_debugfs_gfx_sched_ma=
sk_init(struct amdgpu_device *adev);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 void amdgpu_debugfs_compute_sche=
d_mask_init(struct amdgpu_device *adev);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/drivers/gpu/drm/amd/amdgp=
u/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 1893ceeeb..4c0272cba 100644<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v=
10_0.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v=
10_0.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -8586,31 +8586,6 @@ static u64 gfx_=
v10_0_ring_get_rptr_compute(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return *(uin=
t32_t *)ring-&gt;rptr_cpu_addr;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 }<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -static u64 gfx_v10_0_ring_get_wptr_co=
mpute(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -{<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0u64 wptr;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if s=
wapping is necessary on BE */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_=
doorbell)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0wptr =3D atomic64_read((atomic64_t *)ring-&gt;wptr_cpu_addr);<=
br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0else<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BUG();<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0return wptr;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -static void gfx_v10_0_ring_set_wptr_c=
ompute(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -{<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0struct amdgpu_dev=
ice *adev =3D ring-&gt;adev;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_=
doorbell) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0atomic64_set((atomic64_t *)ring-&gt;wptr_cpu_addr,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring-&gt;wptr);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0WDOORBELL64(ring-&gt;doorbell_index, ring-&gt;wptr);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BUG(); /* only DOORBELL method supported on gfx10 now */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 static void gfx_v10_0_ring_emit_=
hdp_flush(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgp=
u_device *adev =3D ring-&gt;adev;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -9881,8 +9856,8 @@ static const str=
uct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute =3D {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PAC=
KET3(PACKET3_NOP, 0x3FFF),<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64b=
it_ptrs =3D true,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =
=3D gfx_v10_0_ring_get_rptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx=
_v10_0_ring_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx=
_v10_0_ring_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amd=
gpu_gfx_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amd=
gpu_gfx_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_=
size =3D<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A020 + /* gfx_v10_0_ring_emit_gds_switch */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A07 + /* gfx_v10_0_ring_emit_hdp_flush */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -9921,8 +9896,8 @@ static const str=
uct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq =3D {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PAC=
KET3(PACKET3_NOP, 0x3FFF),<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64b=
it_ptrs =3D true,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =
=3D gfx_v10_0_ring_get_rptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx=
_v10_0_ring_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx=
_v10_0_ring_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amd=
gpu_gfx_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amd=
gpu_gfx_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_=
size =3D<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A020 + /* gfx_v10_0_ring_emit_gds_switch */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A07 + /* gfx_v10_0_ring_emit_hdp_flush */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/drivers/gpu/drm/amd/amdgp=
u/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 427975b5a..404604f2d 100644<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v=
11_0.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v=
11_0.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -5818,32 +5818,6 @@ static u64 gfx_=
v11_0_ring_get_rptr_compute(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return *(uin=
t32_t *)ring-&gt;rptr_cpu_addr;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 }<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -static u64 gfx_v11_0_ring_get_wptr_co=
mpute(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -{<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0u64 wptr;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if s=
wapping is necessary on BE */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_=
doorbell)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0wptr =3D atomic64_read((atomic64_t *)ring-&gt;wptr_cpu_addr);<=
br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0else<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BUG();<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0return wptr;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -static void gfx_v11_0_ring_set_wptr_c=
ompute(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -{<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0struct amdgpu_dev=
ice *adev =3D ring-&gt;adev;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if s=
wapping is necessary on BE */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_=
doorbell) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0atomic64_set((atomic64_t *)ring-&gt;wptr_cpu_addr,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring-&gt;wptr);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0WDOORBELL64(ring-&gt;doorbell_index, ring-&gt;wptr);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BUG(); /* only DOORBELL method supported on gfx11 now */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 static void gfx_v11_0_ring_emit_=
hdp_flush(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgp=
u_device *adev =3D ring-&gt;adev;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -7266,8 +7240,8 @@ static const str=
uct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute =3D {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PAC=
KET3(PACKET3_NOP, 0x3FFF),<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64b=
it_ptrs =3D true,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =
=3D gfx_v11_0_ring_get_rptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx=
_v11_0_ring_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx=
_v11_0_ring_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amd=
gpu_gfx_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amd=
gpu_gfx_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_=
size =3D<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A05 + /* update_spm_vmid */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A020 + /* gfx_v11_0_ring_emit_gds_switch */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -7307,8 +7281,8 @@ static const str=
uct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq =3D {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PAC=
KET3(PACKET3_NOP, 0x3FFF),<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64b=
it_ptrs =3D true,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =
=3D gfx_v11_0_ring_get_rptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx=
_v11_0_ring_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx=
_v11_0_ring_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amd=
gpu_gfx_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amd=
gpu_gfx_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_=
size =3D<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A020 + /* gfx_v11_0_ring_emit_gds_switch */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A07 + /* gfx_v11_0_ring_emit_hdp_flush */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/drivers/gpu/drm/amd/amdgp=
u/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 79ea1af36..7ba436444 100644<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v=
12_0.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v=
12_0.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -4363,32 +4363,6 @@ static u64 gfx_=
v12_0_ring_get_rptr_compute(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return *(uin=
t32_t *)ring-&gt;rptr_cpu_addr;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 }<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -static u64 gfx_v12_0_ring_get_wptr_co=
mpute(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -{<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0u64 wptr;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if s=
wapping is necessary on BE */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_=
doorbell)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0wptr =3D atomic64_read((atomic64_t *)ring-&gt;wptr_cpu_addr);<=
br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0else<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BUG();<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0return wptr;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -static void gfx_v12_0_ring_set_wptr_c=
ompute(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -{<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0struct amdgpu_dev=
ice *adev =3D ring-&gt;adev;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if s=
wapping is necessary on BE */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_=
doorbell) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0atomic64_set((atomic64_t *)ring-&gt;wptr_cpu_addr,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring-&gt;wptr);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0WDOORBELL64(ring-&gt;doorbell_index, ring-&gt;wptr);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BUG(); /* only DOORBELL method supported on gfx12 now */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 static void gfx_v12_0_ring_emit_=
hdp_flush(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgp=
u_device *adev =3D ring-&gt;adev;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -5523,8 +5497,8 @@ static const str=
uct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute =3D {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PAC=
KET3(PACKET3_NOP, 0x3FFF),<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64b=
it_ptrs =3D true,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =
=3D gfx_v12_0_ring_get_rptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx=
_v12_0_ring_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx=
_v12_0_ring_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amd=
gpu_gfx_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amd=
gpu_gfx_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_=
size =3D<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A07 + /* gfx_v12_0_ring_emit_hdp_flush */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A05 + /* hdp invalidate */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -5561,8 +5535,8 @@ static const str=
uct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq =3D {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PAC=
KET3(PACKET3_NOP, 0x3FFF),<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64b=
it_ptrs =3D true,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =
=3D gfx_v12_0_ring_get_rptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx=
_v12_0_ring_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx=
_v12_0_ring_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amd=
gpu_gfx_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amd=
gpu_gfx_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_=
size =3D<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A07 + /* gfx_v12_0_ring_emit_hdp_flush */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A05 + /*hdp invalidate */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/drivers/gpu/drm/amd/amdgp=
u/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 8249135d7..798f94bca 100644<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v=
9_0.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v=
9_0.c<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -5640,37 +5640,6 @@ static u64 gfx_=
v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return *ring=
-&gt;rptr_cpu_addr; /* gfx9 hardware is 32bit rptr */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 }<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -static u64 gfx_v9_0_ring_get_wptr_com=
pute(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -{<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0u64 wptr;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if s=
wapping is necessary on BE */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_=
doorbell) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0wptr =3D atomic64_read((atomic64_t *)ring-&gt;wptr_cpu_addr);<=
br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0WARN_ONCE(1, &quot;gfx_v9_0: non-doorbell wptr read on ring %s=
, &quot;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;only doorbell method =
supported on gfx9\n&quot;,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring-&gt;name);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0wptr =3D 0;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0return wptr;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -static void gfx_v9_0_ring_set_wptr_co=
mpute(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -{<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0struct amdgpu_dev=
ice *adev =3D ring-&gt;adev;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0/* XXX check if s=
wapping is necessary on BE */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0if (ring-&gt;use_=
doorbell) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0atomic64_set((atomic64_t *)ring-&gt;wptr_cpu_addr, ring-&gt;wp=
tr);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0WDOORBELL64(ring-&gt;doorbell_index, ring-&gt;wptr);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0WARN_ONCE(1, &quot;gfx_v9_0: non-doorbell wptr write on ring %=
s, &quot;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;only doorbell method =
supported on gfx9\n&quot;,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring-&gt;name);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 static void gfx_v9_0_ring_emit_f=
ence_kiq(struct amdgpu_ring *ring, u64 addr,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 seq, unsigned int flags)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -7627,8 +7596,8 @@ static const str=
uct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute =3D {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PAC=
KET3(PACKET3_NOP, 0x3FFF),<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64b=
it_ptrs =3D true,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =
=3D gfx_v9_0_ring_get_rptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx=
_v9_0_ring_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx=
_v9_0_ring_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amd=
gpu_gfx_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amd=
gpu_gfx_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_=
size =3D<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A020 + /* gfx_v9_0_ring_emit_gds_switch */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A07 + /* gfx_v9_0_ring_emit_hdp_flush */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -7669,8 +7638,8 @@ static const str=
uct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq =3D {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.nop =3D PAC=
KET3(PACKET3_NOP, 0x3FFF),<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.support_64b=
it_ptrs =3D true,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_rptr =
=3D gfx_v9_0_ring_get_rptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.get_wptr =3D gfx=
_v9_0_ring_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0.set_wptr =3D gfx=
_v9_0_ring_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.get_wptr =3D amd=
gpu_gfx_get_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0.set_wptr =3D amd=
gpu_gfx_set_wptr_compute,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_frame_=
size =3D<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A020 + /* gfx_v9_0_ring_emit_gds_switch */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A07 + /* gfx_v9_0_ring_emit_hdp_flush */<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div></div>

--000000000000f89fc70650add7e0--

--000000000000f89fc70650add7e2
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amdgpu-gfx-extract-compute-wptr-doorbell-helpers.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-gfx-extract-compute-wptr-doorbell-helpers.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_moljrtok0>
X-Attachment-Id: f_moljrtok0

RnJvbSA4N2VlNmY2MTI4OTZkZjdmODY2NWFiZTdkYTFhNjg2MjhmOGJhMzc5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSm9obiBCLiBNb29yZSIgPGpibW9vcmU2MUBnbWFpbC5jb20+
CkRhdGU6IFRodSwgMzAgQXByIDIwMjYgMDg6NDc6MDkgLTA1MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1L2dmeDogZXh0cmFjdCBjb21wdXRlIHdwdHIgZG9vcmJlbGwgaGVscGVycyB0bwog
YW1kZ3B1X2dmeC5jCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsg
Y2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpNb3ZlIHRoZSBk
dXBsaWNhdGVkIGRvb3JiZWxsLWJhc2VkIGdldF93cHRyL3NldF93cHRyIGZ1bmN0aW9ucyBmcm9t
CmdmeF92OV8wLmMsIGdmeF92MTBfMC5jLCBnZnhfdjExXzAuYywgYW5kIGdmeF92MTJfMC5jIGlu
dG8gY29tbW9uCmhlbHBlcnMgYW1kZ3B1X2dmeF9nZXRfd3B0cl9jb21wdXRlKCkgYW5kIGFtZGdw
dV9nZnhfc2V0X3dwdHJfY29tcHV0ZSgpCmluIGFtZGdwdV9nZnguYy4KClRoZXNlIGZ1bmN0aW9u
cyBhcmUgbm90IEhXIGdlbmVyYXRpb24gZGVwZW5kZW50IC0tIHRoZSBkb29yYmVsbCBwYXRoIGlz
CmlkZW50aWNhbCBhY3Jvc3MgYWxsIGZvdXIgR0ZYIHZlcnNpb25zLgoKVGhlIGF0b21pYzY0X3Qg
Y2FzdCBpcyByZXRhaW5lZCB2aWEgYSBzdGF0aWMgaW5saW5lIGhlbHBlcgood3B0cl9hc19hdG9t
aWMpIHRvIHByZXNlcnZlIDMyLWJpdCBhdG9taWNpdHkgZ3VhcmFudGVlcywgc2luY2UKRFJNX0FN
REdQVSBzdGlsbCBzdXBwb3J0cyAzMi1iaXQga2VybmVscyB3aGVyZSBhIHBsYWluIDY0LWJpdAp3
cml0ZSB3b3VsZCB0ZWFyIGludG8gdHdvIDMyLWJpdCB3cml0ZXMuCgpDaGFuZ2VzIGZyb20gdjEg
KENocmlzdGlhbiBLw7ZuaWcgcmV2aWV3KToKICAtIE1vdmUgZG9vcmJlbGwgcHJlcmVxdWlzaXRl
IGNoZWNrIHRvIHRoZSB0b3Agb2YgZWFjaCBmdW5jdGlvbiBhcwogICAgaWYgKFdBUk5fT04oIXJp
bmctPnVzZV9kb29yYmVsbCkpIHJldHVybgogIC0gVXNlIFdBUk5fT04sIG5vdCBXQVJOX09OX09O
Q0UgLS0gdGhpcyBpcyBhIGZ1bmN0aW9uYWwgY29kaW5nCiAgICBlcnJvciwgbm90IGEgSFcgZXJy
b3IgdGhhdCB3b3VsZCBzcGFtIGxvZ3MKICAtIFVzZSBybWIoKS93bWIoKSBmb3IgQ1BVPC0+ZGV2
aWNlIG9yZGVyaW5nLCBub3Qgc21wX3JtYigpL3NtcF93bWIoKQogICAgd2hpY2ggYXJlIENQVTwt
PkNQVSBvbmx5CiAgLSBQbGFjZSBybWIoKSBiZWZvcmUgdGhlIHJlYWQsIG5vdCBhZnRlcgogIC0g
V3JhcCB0aGUgYXRvbWljNjRfdCBjYXN0IGluIGEgaGVscGVyIHRvIGNvbnRhaW4gdGhlIHVnbGlu
ZXNzCgpOb3QgdG91Y2hlZDogZ2Z4X3Y3XzAsIGdmeF92OF8wLCBnZnhfdjlfNF8zIC0tIHRoZXNl
IGhhdmUgZGlmZmVyZW50CndwdHIgYWNjZXNzIHBhdHRlcm5zIChNTUlPIHJlZ2lzdGVycyBvciB3
Yi53YltdIG9mZnNldHMpLgoKU3VnZ2VzdGVkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEpvaG4gTW9vcmUgPGpibW9vcmU2MUBnbWFp
bC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIHwgNTUg
KysrKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dmeC5oIHwgIDMgKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5j
ICB8IDMzICsrLS0tLS0tLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Yx
MV8wLmMgIHwgMzQgKystLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjEyXzAuYyAgfCAzNCArKy0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMgICB8IDMxICsrLS0tLS0tLS0tLS0tCiA2IGZpbGVzIGNoYW5nZWQsIDc0
IGluc2VydGlvbnMoKyksIDExNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ2Z4LmMKaW5kZXggYjhjYTg3NjY5Li5lYjAzYmFmNWIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMKQEAgLTI2ODYsMyArMjY4Niw1OCBAQCB2b2lkIGFt
ZGdwdV9kZWJ1Z2ZzX2NvbXB1dGVfc2NoZWRfbWFza19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQogI2VuZGlmCiB9CiAKKy8qCisgKiBIZWxwZXIgdG8gY2FzdCB0aGUgdTMyICp3cHRy
X2NwdV9hZGRyIHRvIGF0b21pYzY0X3QgKiBmb3IgNjQtYml0CisgKiBhdG9taWMgYWNjZXNzLiAg
V2UgbmVlZCBhdG9taWMgNjQtYml0IGxvYWRzL3N0b3JlcyBoZXJlIGJlY2F1c2UgdGhlCisgKiBH
UFUgcmVhZHMvd3JpdGVzIHRoaXMgdmFsdWUgY29uY3VycmVudGx5IGFuZCBvbiAzMi1iaXQga2Vy
bmVscyBhCisgKiBwbGFpbiA2NC1iaXQgd3JpdGUgd291bGQgdGVhciBpbnRvIHR3byAzMi1iaXQg
d3JpdGVzLgorICovCitzdGF0aWMgaW5saW5lIGF0b21pYzY0X3QgKndwdHJfYXNfYXRvbWljKHN0
cnVjdCBhbWRncHVfcmluZyAqcmluZykKK3sKKwlyZXR1cm4gKGF0b21pYzY0X3QgKilyaW5nLT53
cHRyX2NwdV9hZGRyOworfQorCisvKioKKyAqIGFtZGdwdV9nZnhfZ2V0X3dwdHJfY29tcHV0ZSAt
IGNvbW1vbiBnZXRfd3B0ciBmb3IgY29tcHV0ZSByaW5ncyB1c2luZyBkb29yYmVsbHMKKyAqIEBy
aW5nOiBhbWRncHVfcmluZyBwb2ludGVyCisgKgorICogUmVhZCB0aGUgd3JpdGUgcG9pbnRlciBm
cm9tIHRoZSBkb29yYmVsbC1tYXBwZWQgd3JpdGViYWNrIGFkZHJlc3MuCisgKiBUaGlzIGlzIEhX
LWFnbm9zdGljIGFuZCBzaGFyZWQgYWNyb3NzIEdGWCBnZW5lcmF0aW9ucyB0aGF0IHVzZQorICog
ZG9vcmJlbGwtYmFzZWQgY29tcHV0ZSBxdWV1ZSBtYW5hZ2VtZW50LgorICovCit1NjQgYW1kZ3B1
X2dmeF9nZXRfd3B0cl9jb21wdXRlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKK3sKKwlpZiAo
V0FSTl9PTighcmluZy0+dXNlX2Rvb3JiZWxsKSkKKwkJcmV0dXJuIDA7CisKKwkvKiBFbnN1cmUg
d2Ugc2VlIHRoZSBsYXRlc3QgdmFsdWUgd3JpdHRlbiBieSB0aGUgZGV2aWNlICovCisJcm1iKCk7
CisKKwkvKiBYWFggY2hlY2sgaWYgc3dhcHBpbmcgaXMgbmVjZXNzYXJ5IG9uIEJFICovCisJcmV0
dXJuIGF0b21pYzY0X3JlYWQod3B0cl9hc19hdG9taWMocmluZykpOworfQorCisvKioKKyAqIGFt
ZGdwdV9nZnhfc2V0X3dwdHJfY29tcHV0ZSAtIGNvbW1vbiBzZXRfd3B0ciBmb3IgY29tcHV0ZSBy
aW5ncyB1c2luZyBkb29yYmVsbHMKKyAqIEByaW5nOiBhbWRncHVfcmluZyBwb2ludGVyCisgKgor
ICogV3JpdGUgdGhlIHdyaXRlIHBvaW50ZXIgdG8gdGhlIGRvb3JiZWxsLW1hcHBlZCB3cml0ZWJh
Y2sgYWRkcmVzcyBhbmQKKyAqIHJpbmcgdGhlIGRvb3JiZWxsLiAgVGhpcyBpcyBIVy1hZ25vc3Rp
YyBhbmQgc2hhcmVkIGFjcm9zcyBHRlgKKyAqIGdlbmVyYXRpb25zIHRoYXQgdXNlIGRvb3JiZWxs
LWJhc2VkIGNvbXB1dGUgcXVldWUgbWFuYWdlbWVudC4KKyAqLwordm9pZCBhbWRncHVfZ2Z4X3Nl
dF93cHRyX2NvbXB1dGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQoreworCXN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsKKworCWlmIChXQVJOX09OKCFyaW5nLT51c2Vf
ZG9vcmJlbGwpKQorCQlyZXR1cm47CisKKwkvKiBYWFggY2hlY2sgaWYgc3dhcHBpbmcgaXMgbmVj
ZXNzYXJ5IG9uIEJFICovCisJYXRvbWljNjRfc2V0KHdwdHJfYXNfYXRvbWljKHJpbmcpLCByaW5n
LT53cHRyKTsKKworCS8qIEVuc3VyZSB0aGUgd3B0ciB3cml0ZSBpcyB2aXNpYmxlIHRvIHRoZSBk
ZXZpY2UgYmVmb3JlIHJpbmdpbmcgdGhlIGRvb3JiZWxsICovCisJd21iKCk7CisKKwlXRE9PUkJF
TEw2NChyaW5nLT5kb29yYmVsbF9pbmRleCwgcmluZy0+d3B0cik7Cit9CisKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaAppbmRleCBhMGNmMGEzYjQuLjdiZjE3N2Q1YSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaApAQCAtNjYxLDYgKzY2MSw5IEBA
IHUzMiBhbWRncHVfZ2Z4X2NzYl9wcmVhbWJsZV9zdGFydCh1MzIgKmJ1ZmZlcik7CiB1MzIgYW1k
Z3B1X2dmeF9jc2JfZGF0YV9wYXJzZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiAq
YnVmZmVyLCB1MzIgY291bnQpOwogdm9pZCBhbWRncHVfZ2Z4X2NzYl9wcmVhbWJsZV9lbmQodTMy
ICpidWZmZXIsIHUzMiBjb3VudCk7CiAKK3U2NCBhbWRncHVfZ2Z4X2dldF93cHRyX2NvbXB1dGUo
c3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKTsKK3ZvaWQgYW1kZ3B1X2dmeF9zZXRfd3B0cl9jb21w
dXRlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyk7CisKIHZvaWQgYW1kZ3B1X2RlYnVnZnNfZ2Z4
X3NjaGVkX21hc2tfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiB2b2lkIGFtZGdw
dV9kZWJ1Z2ZzX2NvbXB1dGVfc2NoZWRfbWFza19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwppbmRleCA1OGM2OWRj
YjUuLjRlZTdiNWE5MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3YxMF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKQEAg
LTg1OTEsMzEgKzg1OTEsNiBAQCBzdGF0aWMgdTY0IGdmeF92MTBfMF9yaW5nX2dldF9ycHRyX2Nv
bXB1dGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQogCXJldHVybiAqKHVpbnQzMl90ICopcmlu
Zy0+cnB0cl9jcHVfYWRkcjsKIH0KIAotc3RhdGljIHU2NCBnZnhfdjEwXzBfcmluZ19nZXRfd3B0
cl9jb21wdXRlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKLXsKLQl1NjQgd3B0cjsKLQotCS8q
IFhYWCBjaGVjayBpZiBzd2FwcGluZyBpcyBuZWNlc3Nhcnkgb24gQkUgKi8KLQlpZiAocmluZy0+
dXNlX2Rvb3JiZWxsKQotCQl3cHRyID0gYXRvbWljNjRfcmVhZCgoYXRvbWljNjRfdCAqKXJpbmct
PndwdHJfY3B1X2FkZHIpOwotCWVsc2UKLQkJQlVHKCk7Ci0JcmV0dXJuIHdwdHI7Ci19Ci0KLXN0
YXRpYyB2b2lkIGdmeF92MTBfMF9yaW5nX3NldF93cHRyX2NvbXB1dGUoc3RydWN0IGFtZGdwdV9y
aW5nICpyaW5nKQotewotCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsK
LQotCWlmIChyaW5nLT51c2VfZG9vcmJlbGwpIHsKLQkJYXRvbWljNjRfc2V0KChhdG9taWM2NF90
ICopcmluZy0+d3B0cl9jcHVfYWRkciwKLQkJCSAgICAgcmluZy0+d3B0cik7Ci0JCVdET09SQkVM
TDY0KHJpbmctPmRvb3JiZWxsX2luZGV4LCByaW5nLT53cHRyKTsKLQl9IGVsc2UgewotCQlCVUco
KTsgLyogb25seSBET09SQkVMTCBtZXRob2Qgc3VwcG9ydGVkIG9uIGdmeDEwIG5vdyAqLwotCX0K
LX0KLQogc3RhdGljIHZvaWQgZ2Z4X3YxMF8wX3JpbmdfZW1pdF9oZHBfZmx1c2goc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nKQogewogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+
YWRldjsKQEAgLTk4ODYsOCArOTg2MSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3Jp
bmdfZnVuY3MgZ2Z4X3YxMF8wX3JpbmdfZnVuY3NfY29tcHV0ZSA9IHsKIAkubm9wID0gUEFDS0VU
MyhQQUNLRVQzX05PUCwgMHgzRkZGKSwKIAkuc3VwcG9ydF82NGJpdF9wdHJzID0gdHJ1ZSwKIAku
Z2V0X3JwdHIgPSBnZnhfdjEwXzBfcmluZ19nZXRfcnB0cl9jb21wdXRlLAotCS5nZXRfd3B0ciA9
IGdmeF92MTBfMF9yaW5nX2dldF93cHRyX2NvbXB1dGUsCi0JLnNldF93cHRyID0gZ2Z4X3YxMF8w
X3Jpbmdfc2V0X3dwdHJfY29tcHV0ZSwKKwkuZ2V0X3dwdHIgPSBhbWRncHVfZ2Z4X2dldF93cHRy
X2NvbXB1dGUsCisJLnNldF93cHRyID0gYW1kZ3B1X2dmeF9zZXRfd3B0cl9jb21wdXRlLAogCS5l
bWl0X2ZyYW1lX3NpemUgPQogCQkyMCArIC8qIGdmeF92MTBfMF9yaW5nX2VtaXRfZ2RzX3N3aXRj
aCAqLwogCQk3ICsgLyogZ2Z4X3YxMF8wX3JpbmdfZW1pdF9oZHBfZmx1c2ggKi8KQEAgLTk5MjYs
OCArOTkwMSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3MgZ2Z4X3Yx
MF8wX3JpbmdfZnVuY3Nfa2lxID0gewogCS5ub3AgPSBQQUNLRVQzKFBBQ0tFVDNfTk9QLCAweDNG
RkYpLAogCS5zdXBwb3J0XzY0Yml0X3B0cnMgPSB0cnVlLAogCS5nZXRfcnB0ciA9IGdmeF92MTBf
MF9yaW5nX2dldF9ycHRyX2NvbXB1dGUsCi0JLmdldF93cHRyID0gZ2Z4X3YxMF8wX3JpbmdfZ2V0
X3dwdHJfY29tcHV0ZSwKLQkuc2V0X3dwdHIgPSBnZnhfdjEwXzBfcmluZ19zZXRfd3B0cl9jb21w
dXRlLAorCS5nZXRfd3B0ciA9IGFtZGdwdV9nZnhfZ2V0X3dwdHJfY29tcHV0ZSwKKwkuc2V0X3dw
dHIgPSBhbWRncHVfZ2Z4X3NldF93cHRyX2NvbXB1dGUsCiAJLmVtaXRfZnJhbWVfc2l6ZSA9CiAJ
CTIwICsgLyogZ2Z4X3YxMF8wX3JpbmdfZW1pdF9nZHNfc3dpdGNoICovCiAJCTcgKyAvKiBnZnhf
djEwXzBfcmluZ19lbWl0X2hkcF9mbHVzaCAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djExXzAuYwppbmRleCAyYzZmMWUyNWMuLmMwNjliNzAwMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMV8wLmMKQEAgLTU4OTEsMzIgKzU4OTEsNiBAQCBzdGF0aWMgdTY0IGdmeF92
MTFfMF9yaW5nX2dldF9ycHRyX2NvbXB1dGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQogCXJl
dHVybiAqKHVpbnQzMl90ICopcmluZy0+cnB0cl9jcHVfYWRkcjsKIH0KIAotc3RhdGljIHU2NCBn
ZnhfdjExXzBfcmluZ19nZXRfd3B0cl9jb21wdXRlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykK
LXsKLQl1NjQgd3B0cjsKLQotCS8qIFhYWCBjaGVjayBpZiBzd2FwcGluZyBpcyBuZWNlc3Nhcnkg
b24gQkUgKi8KLQlpZiAocmluZy0+dXNlX2Rvb3JiZWxsKQotCQl3cHRyID0gYXRvbWljNjRfcmVh
ZCgoYXRvbWljNjRfdCAqKXJpbmctPndwdHJfY3B1X2FkZHIpOwotCWVsc2UKLQkJQlVHKCk7Ci0J
cmV0dXJuIHdwdHI7Ci19Ci0KLXN0YXRpYyB2b2lkIGdmeF92MTFfMF9yaW5nX3NldF93cHRyX2Nv
bXB1dGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQotewotCXN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2ID0gcmluZy0+YWRldjsKLQotCS8qIFhYWCBjaGVjayBpZiBzd2FwcGluZyBpcyBuZWNl
c3Nhcnkgb24gQkUgKi8KLQlpZiAocmluZy0+dXNlX2Rvb3JiZWxsKSB7Ci0JCWF0b21pYzY0X3Nl
dCgoYXRvbWljNjRfdCAqKXJpbmctPndwdHJfY3B1X2FkZHIsCi0JCQkgICAgIHJpbmctPndwdHIp
OwotCQlXRE9PUkJFTEw2NChyaW5nLT5kb29yYmVsbF9pbmRleCwgcmluZy0+d3B0cik7Ci0JfSBl
bHNlIHsKLQkJQlVHKCk7IC8qIG9ubHkgRE9PUkJFTEwgbWV0aG9kIHN1cHBvcnRlZCBvbiBnZngx
MSBub3cgKi8KLQl9Ci19Ci0KIHN0YXRpYyB2b2lkIGdmeF92MTFfMF9yaW5nX2VtaXRfaGRwX2Zs
dXNoKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IHJpbmctPmFkZXY7CkBAIC03MzMxLDggKzczMDUsOCBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdmeF92MTFfMF9yaW5nX2Z1bmNzX2NvbXB1dGUgPSB7CiAJ
Lm5vcCA9IFBBQ0tFVDMoUEFDS0VUM19OT1AsIDB4M0ZGRiksCiAJLnN1cHBvcnRfNjRiaXRfcHRy
cyA9IHRydWUsCiAJLmdldF9ycHRyID0gZ2Z4X3YxMV8wX3JpbmdfZ2V0X3JwdHJfY29tcHV0ZSwK
LQkuZ2V0X3dwdHIgPSBnZnhfdjExXzBfcmluZ19nZXRfd3B0cl9jb21wdXRlLAotCS5zZXRfd3B0
ciA9IGdmeF92MTFfMF9yaW5nX3NldF93cHRyX2NvbXB1dGUsCisJLmdldF93cHRyID0gYW1kZ3B1
X2dmeF9nZXRfd3B0cl9jb21wdXRlLAorCS5zZXRfd3B0ciA9IGFtZGdwdV9nZnhfc2V0X3dwdHJf
Y29tcHV0ZSwKIAkuZW1pdF9mcmFtZV9zaXplID0KIAkJNSArIC8qIHVwZGF0ZV9zcG1fdm1pZCAq
LwogCQkyMCArIC8qIGdmeF92MTFfMF9yaW5nX2VtaXRfZ2RzX3N3aXRjaCAqLwpAQCAtNzM3Miw4
ICs3MzQ2LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjEx
XzBfcmluZ19mdW5jc19raXEgPSB7CiAJLm5vcCA9IFBBQ0tFVDMoUEFDS0VUM19OT1AsIDB4M0ZG
RiksCiAJLnN1cHBvcnRfNjRiaXRfcHRycyA9IHRydWUsCiAJLmdldF9ycHRyID0gZ2Z4X3YxMV8w
X3JpbmdfZ2V0X3JwdHJfY29tcHV0ZSwKLQkuZ2V0X3dwdHIgPSBnZnhfdjExXzBfcmluZ19nZXRf
d3B0cl9jb21wdXRlLAotCS5zZXRfd3B0ciA9IGdmeF92MTFfMF9yaW5nX3NldF93cHRyX2NvbXB1
dGUsCisJLmdldF93cHRyID0gYW1kZ3B1X2dmeF9nZXRfd3B0cl9jb21wdXRlLAorCS5zZXRfd3B0
ciA9IGFtZGdwdV9nZnhfc2V0X3dwdHJfY29tcHV0ZSwKIAkuZW1pdF9mcmFtZV9zaXplID0KIAkJ
MjAgKyAvKiBnZnhfdjExXzBfcmluZ19lbWl0X2dkc19zd2l0Y2ggKi8KIAkJNyArIC8qIGdmeF92
MTFfMF9yaW5nX2VtaXRfaGRwX2ZsdXNoICovCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjEyXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
MTJfMC5jCmluZGV4IDZiYWFjNTMzYS4uMTc1OGE2MDUxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjEyXzAuYwpAQCAtNDQwMSwzMiArNDQwMSw2IEBAIHN0YXRpYyB1NjQgZ2Z4X3Yx
Ml8wX3JpbmdfZ2V0X3JwdHJfY29tcHV0ZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCiAJcmV0
dXJuICoodWludDMyX3QgKilyaW5nLT5ycHRyX2NwdV9hZGRyOwogfQogCi1zdGF0aWMgdTY0IGdm
eF92MTJfMF9yaW5nX2dldF93cHRyX2NvbXB1dGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQot
ewotCXU2NCB3cHRyOwotCi0JLyogWFhYIGNoZWNrIGlmIHN3YXBwaW5nIGlzIG5lY2Vzc2FyeSBv
biBCRSAqLwotCWlmIChyaW5nLT51c2VfZG9vcmJlbGwpCi0JCXdwdHIgPSBhdG9taWM2NF9yZWFk
KChhdG9taWM2NF90ICopcmluZy0+d3B0cl9jcHVfYWRkcik7Ci0JZWxzZQotCQlCVUcoKTsKLQly
ZXR1cm4gd3B0cjsKLX0KLQotc3RhdGljIHZvaWQgZ2Z4X3YxMl8wX3Jpbmdfc2V0X3dwdHJfY29t
cHV0ZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCi17Ci0Jc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYgPSByaW5nLT5hZGV2OwotCi0JLyogWFhYIGNoZWNrIGlmIHN3YXBwaW5nIGlzIG5lY2Vz
c2FyeSBvbiBCRSAqLwotCWlmIChyaW5nLT51c2VfZG9vcmJlbGwpIHsKLQkJYXRvbWljNjRfc2V0
KChhdG9taWM2NF90ICopcmluZy0+d3B0cl9jcHVfYWRkciwKLQkJCSAgICAgcmluZy0+d3B0cik7
Ci0JCVdET09SQkVMTDY0KHJpbmctPmRvb3JiZWxsX2luZGV4LCByaW5nLT53cHRyKTsKLQl9IGVs
c2UgewotCQlCVUcoKTsgLyogb25seSBET09SQkVMTCBtZXRob2Qgc3VwcG9ydGVkIG9uIGdmeDEy
IG5vdyAqLwotCX0KLX0KLQogc3RhdGljIHZvaWQgZ2Z4X3YxMl8wX3JpbmdfZW1pdF9oZHBfZmx1
c2goc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQogewogCXN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gcmluZy0+YWRldjsKQEAgLTU1NTMsOCArNTUyNyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgYW1kZ3B1X3JpbmdfZnVuY3MgZ2Z4X3YxMl8wX3JpbmdfZnVuY3NfY29tcHV0ZSA9IHsKIAku
bm9wID0gUEFDS0VUMyhQQUNLRVQzX05PUCwgMHgzRkZGKSwKIAkuc3VwcG9ydF82NGJpdF9wdHJz
ID0gdHJ1ZSwKIAkuZ2V0X3JwdHIgPSBnZnhfdjEyXzBfcmluZ19nZXRfcnB0cl9jb21wdXRlLAot
CS5nZXRfd3B0ciA9IGdmeF92MTJfMF9yaW5nX2dldF93cHRyX2NvbXB1dGUsCi0JLnNldF93cHRy
ID0gZ2Z4X3YxMl8wX3Jpbmdfc2V0X3dwdHJfY29tcHV0ZSwKKwkuZ2V0X3dwdHIgPSBhbWRncHVf
Z2Z4X2dldF93cHRyX2NvbXB1dGUsCisJLnNldF93cHRyID0gYW1kZ3B1X2dmeF9zZXRfd3B0cl9j
b21wdXRlLAogCS5lbWl0X2ZyYW1lX3NpemUgPQogCQk3ICsgLyogZ2Z4X3YxMl8wX3JpbmdfZW1p
dF9oZHBfZmx1c2ggKi8KIAkJNSArIC8qIGhkcCBpbnZhbGlkYXRlICovCkBAIC01NTkxLDggKzU1
NjUsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdmeF92MTJfMF9y
aW5nX2Z1bmNzX2tpcSA9IHsKIAkubm9wID0gUEFDS0VUMyhQQUNLRVQzX05PUCwgMHgzRkZGKSwK
IAkuc3VwcG9ydF82NGJpdF9wdHJzID0gdHJ1ZSwKIAkuZ2V0X3JwdHIgPSBnZnhfdjEyXzBfcmlu
Z19nZXRfcnB0cl9jb21wdXRlLAotCS5nZXRfd3B0ciA9IGdmeF92MTJfMF9yaW5nX2dldF93cHRy
X2NvbXB1dGUsCi0JLnNldF93cHRyID0gZ2Z4X3YxMl8wX3Jpbmdfc2V0X3dwdHJfY29tcHV0ZSwK
KwkuZ2V0X3dwdHIgPSBhbWRncHVfZ2Z4X2dldF93cHRyX2NvbXB1dGUsCisJLnNldF93cHRyID0g
YW1kZ3B1X2dmeF9zZXRfd3B0cl9jb21wdXRlLAogCS5lbWl0X2ZyYW1lX3NpemUgPQogCQk3ICsg
LyogZ2Z4X3YxMl8wX3JpbmdfZW1pdF9oZHBfZmx1c2ggKi8KIAkJNSArIC8qaGRwIGludmFsaWRh
dGUgKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCmluZGV4IDJlYjMyZjkyYS4u
ZDUwMDE2ZTlhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKQEAgLTU2MzQs
MzAgKzU2MzQsNyBAQCBzdGF0aWMgdTY0IGdmeF92OV8wX3JpbmdfZ2V0X3JwdHJfY29tcHV0ZShz
dHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCiAJcmV0dXJuICpyaW5nLT5ycHRyX2NwdV9hZGRyOyAv
KiBnZng5IGhhcmR3YXJlIGlzIDMyYml0IHJwdHIgKi8KIH0KIAotc3RhdGljIHU2NCBnZnhfdjlf
MF9yaW5nX2dldF93cHRyX2NvbXB1dGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQotewotCXU2
NCB3cHRyOwotCi0JLyogWFhYIGNoZWNrIGlmIHN3YXBwaW5nIGlzIG5lY2Vzc2FyeSBvbiBCRSAq
LwotCWlmIChyaW5nLT51c2VfZG9vcmJlbGwpCi0JCXdwdHIgPSBhdG9taWM2NF9yZWFkKChhdG9t
aWM2NF90ICopcmluZy0+d3B0cl9jcHVfYWRkcik7Ci0JZWxzZQotCQlCVUcoKTsKLQlyZXR1cm4g
d3B0cjsKLX0KIAotc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfcmluZ19zZXRfd3B0cl9jb21wdXRlKHN0
cnVjdCBhbWRncHVfcmluZyAqcmluZykKLXsKLQlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9
IHJpbmctPmFkZXY7Ci0KLQkvKiBYWFggY2hlY2sgaWYgc3dhcHBpbmcgaXMgbmVjZXNzYXJ5IG9u
IEJFICovCi0JaWYgKHJpbmctPnVzZV9kb29yYmVsbCkgewotCQlhdG9taWM2NF9zZXQoKGF0b21p
YzY0X3QgKilyaW5nLT53cHRyX2NwdV9hZGRyLCByaW5nLT53cHRyKTsKLQkJV0RPT1JCRUxMNjQo
cmluZy0+ZG9vcmJlbGxfaW5kZXgsIHJpbmctPndwdHIpOwotCX0gZWxzZXsKLQkJQlVHKCk7IC8q
IG9ubHkgRE9PUkJFTEwgbWV0aG9kIHN1cHBvcnRlZCBvbiBnZng5IG5vdyAqLwotCX0KLX0KIAog
c3RhdGljIHZvaWQgZ2Z4X3Y5XzBfcmluZ19lbWl0X2ZlbmNlX2tpcShzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmcsIHU2NCBhZGRyLAogCQkJCQkgdTY0IHNlcSwgdW5zaWduZWQgaW50IGZsYWdzKQpA
QCAtNzYxNCw4ICs3NTkxLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5j
cyBnZnhfdjlfMF9yaW5nX2Z1bmNzX2NvbXB1dGUgPSB7CiAJLm5vcCA9IFBBQ0tFVDMoUEFDS0VU
M19OT1AsIDB4M0ZGRiksCiAJLnN1cHBvcnRfNjRiaXRfcHRycyA9IHRydWUsCiAJLmdldF9ycHRy
ID0gZ2Z4X3Y5XzBfcmluZ19nZXRfcnB0cl9jb21wdXRlLAotCS5nZXRfd3B0ciA9IGdmeF92OV8w
X3JpbmdfZ2V0X3dwdHJfY29tcHV0ZSwKLQkuc2V0X3dwdHIgPSBnZnhfdjlfMF9yaW5nX3NldF93
cHRyX2NvbXB1dGUsCisJLmdldF93cHRyID0gYW1kZ3B1X2dmeF9nZXRfd3B0cl9jb21wdXRlLAor
CS5zZXRfd3B0ciA9IGFtZGdwdV9nZnhfc2V0X3dwdHJfY29tcHV0ZSwKIAkuZW1pdF9mcmFtZV9z
aXplID0KIAkJMjAgKyAvKiBnZnhfdjlfMF9yaW5nX2VtaXRfZ2RzX3N3aXRjaCAqLwogCQk3ICsg
LyogZ2Z4X3Y5XzBfcmluZ19lbWl0X2hkcF9mbHVzaCAqLwpAQCAtNzY1Niw4ICs3NjMzLDggQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjlfMF9yaW5nX2Z1bmNz
X2tpcSA9IHsKIAkubm9wID0gUEFDS0VUMyhQQUNLRVQzX05PUCwgMHgzRkZGKSwKIAkuc3VwcG9y
dF82NGJpdF9wdHJzID0gdHJ1ZSwKIAkuZ2V0X3JwdHIgPSBnZnhfdjlfMF9yaW5nX2dldF9ycHRy
X2NvbXB1dGUsCi0JLmdldF93cHRyID0gZ2Z4X3Y5XzBfcmluZ19nZXRfd3B0cl9jb21wdXRlLAot
CS5zZXRfd3B0ciA9IGdmeF92OV8wX3Jpbmdfc2V0X3dwdHJfY29tcHV0ZSwKKwkuZ2V0X3dwdHIg
PSBhbWRncHVfZ2Z4X2dldF93cHRyX2NvbXB1dGUsCisJLnNldF93cHRyID0gYW1kZ3B1X2dmeF9z
ZXRfd3B0cl9jb21wdXRlLAogCS5lbWl0X2ZyYW1lX3NpemUgPQogCQkyMCArIC8qIGdmeF92OV8w
X3JpbmdfZW1pdF9nZHNfc3dpdGNoICovCiAJCTcgKyAvKiBnZnhfdjlfMF9yaW5nX2VtaXRfaGRw
X2ZsdXNoICovCi0tIAoyLjQzLjAKCg==
--000000000000f89fc70650add7e2
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amdgpu-gfx-extract-compute-wptr-doorbel-option-b.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-gfx-extract-compute-wptr-doorbel-option-b.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_moljry8n1>
X-Attachment-Id: f_moljry8n1

RnJvbSBiM2JhZDNiYzA3MjA0MWNkN2ZkZWJkYWQ3ODMxZTVlNzA0NTRlYzY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSm9obiBCLiBNb29yZSIgPGpibW9vcmU2MUBnbWFpbC5jb20+
CkRhdGU6IFRodSwgMzAgQXByIDIwMjYgMDg6NDk6MzggLTA1MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1L2dmeDogZXh0cmFjdCBjb21wdXRlIHdwdHIgZG9vcmJlbGwgaGVscGVycyB0bwog
YW1kZ3B1X2dmeC5jCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsg
Y2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpNb3ZlIHRoZSBk
dXBsaWNhdGVkIGRvb3JiZWxsLWJhc2VkIGdldF93cHRyL3NldF93cHRyIGZ1bmN0aW9ucyBmcm9t
CmdmeF92OV8wLmMsIGdmeF92MTBfMC5jLCBnZnhfdjExXzAuYywgYW5kIGdmeF92MTJfMC5jIGlu
dG8gY29tbW9uCmhlbHBlcnMgYW1kZ3B1X2dmeF9nZXRfd3B0cl9jb21wdXRlKCkgYW5kIGFtZGdw
dV9nZnhfc2V0X3dwdHJfY29tcHV0ZSgpCmluIGFtZGdwdV9nZnguYy4KClRoZXNlIGZ1bmN0aW9u
cyBhcmUgbm90IEhXIGdlbmVyYXRpb24gZGVwZW5kZW50IC0tIHRoZSBkb29yYmVsbCBwYXRoIGlz
CmlkZW50aWNhbCBhY3Jvc3MgYWxsIGZvdXIgR0ZYIHZlcnNpb25zLgoKcmVhZHEoKS93cml0ZXEo
KSBhcmUgdXNlZCBkZXNwaXRlIHRoaXMgYmVpbmcgc3lzdGVtIG1lbW9yeSAobm90IE1NSU8pCmJl
Y2F1c2Ugd2UgbmVlZCBhdG9taWMgNjQtYml0IHJlYWRzL3dyaXRlcyB0aGF0IHdpbGwgbm90IHRl
YXIgb24KMzItYml0IGtlcm5lbHMuICBUaGUgc2VtYW50aWMgbWlzbWF0Y2ggd2l0aCBNTUlPIGFj
Y2Vzc29ycyBpcwpkb2N1bWVudGVkIGluIHRoZSBmdW5jdGlvbiBjb21tZW50cy4KCkNoYW5nZXMg
ZnJvbSB2MSAoQ2hyaXN0aWFuIEvDtm5pZyByZXZpZXcpOgogIC0gTW92ZSBkb29yYmVsbCBwcmVy
ZXF1aXNpdGUgY2hlY2sgdG8gdGhlIHRvcCBvZiBlYWNoIGZ1bmN0aW9uIGFzCiAgICBpZiAoV0FS
Tl9PTighcmluZy0+dXNlX2Rvb3JiZWxsKSkgcmV0dXJuCiAgLSBVc2UgV0FSTl9PTiwgbm90IFdB
Uk5fT05fT05DRSAtLSB0aGlzIGlzIGEgZnVuY3Rpb25hbCBjb2RpbmcKICAgIGVycm9yLCBub3Qg
YSBIVyBlcnJvciB0aGF0IHdvdWxkIHNwYW0gbG9ncwogIC0gVXNlIHJtYigpL3dtYigpIGZvciBD
UFU8LT5kZXZpY2Ugb3JkZXJpbmcsIG5vdCBzbXBfcm1iKCkvc21wX3dtYigpCiAgICB3aGljaCBh
cmUgQ1BVPC0+Q1BVIG9ubHkKICAtIFBsYWNlIHJtYigpIGJlZm9yZSB0aGUgcmVhZCwgbm90IGFm
dGVyCiAgLSBSZXBsYWNlIGF0b21pYzY0X3QgY2FzdCB3aXRoIHJlYWRxKCkvd3JpdGVxKCkKCk5v
dCB0b3VjaGVkOiBnZnhfdjdfMCwgZ2Z4X3Y4XzAsIGdmeF92OV80XzMgLS0gdGhlc2UgaGF2ZSBk
aWZmZXJlbnQKd3B0ciBhY2Nlc3MgcGF0dGVybnMgKE1NSU8gcmVnaXN0ZXJzIG9yIHdiLndiW10g
b2Zmc2V0cykuCgpTdWdnZXN0ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogSm9obiBNb29yZSA8amJtb29yZTYxQGdtYWlsLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgfCA1MiArKysrKysr
KysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4
LmggfCAgMyArKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgIHwgMzMg
KystLS0tLS0tLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMg
IHwgMzQgKystLS0tLS0tLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Yx
Ml8wLmMgIHwgMzQgKystLS0tLS0tLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYyAgIHwgMzMgKystLS0tLS0tLS0tLS0tLQogNiBmaWxlcyBjaGFuZ2VkLCA3MSBp
bnNlcnRpb25zKCspLCAxMTggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dmeC5jCmluZGV4IGI4Y2E4NzY2OS4uZjgxMjM1YTJjIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jCkBAIC0yNjg2LDMgKzI2ODYsNTUgQEAgdm9pZCBhbWRn
cHVfZGVidWdmc19jb21wdXRlX3NjaGVkX21hc2tfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKICNlbmRpZgogfQogCisvKioKKyAqIGFtZGdwdV9nZnhfZ2V0X3dwdHJfY29tcHV0ZSAt
IGNvbW1vbiBnZXRfd3B0ciBmb3IgY29tcHV0ZSByaW5ncyB1c2luZyBkb29yYmVsbHMKKyAqIEBy
aW5nOiBhbWRncHVfcmluZyBwb2ludGVyCisgKgorICogUmVhZCB0aGUgd3JpdGUgcG9pbnRlciBm
cm9tIHRoZSBkb29yYmVsbC1tYXBwZWQgd3JpdGViYWNrIGFkZHJlc3MuCisgKiBUaGlzIGlzIEhX
LWFnbm9zdGljIGFuZCBzaGFyZWQgYWNyb3NzIEdGWCBnZW5lcmF0aW9ucyB0aGF0IHVzZQorICog
ZG9vcmJlbGwtYmFzZWQgY29tcHV0ZSBxdWV1ZSBtYW5hZ2VtZW50LgorICoKKyAqIE5vdGU6IHJl
YWRxKCkgaXMgdXNlZCBkZXNwaXRlIHRoaXMgYmVpbmcgc3lzdGVtIG1lbW9yeSAobm90IE1NSU8p
CisgKiBiZWNhdXNlIHdlIG5lZWQgYW4gYXRvbWljIDY0LWJpdCByZWFkIHRoYXQgd29uJ3QgdGVh
ciBvbiAzMi1iaXQKKyAqIGtlcm5lbHMuCisgKi8KK3U2NCBhbWRncHVfZ2Z4X2dldF93cHRyX2Nv
bXB1dGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQoreworCWlmIChXQVJOX09OKCFyaW5nLT51
c2VfZG9vcmJlbGwpKQorCQlyZXR1cm4gMDsKKworCS8qIEVuc3VyZSB3ZSBzZWUgdGhlIGxhdGVz
dCB2YWx1ZSB3cml0dGVuIGJ5IHRoZSBkZXZpY2UgKi8KKwlybWIoKTsKKworCS8qIFhYWCBjaGVj
ayBpZiBzd2FwcGluZyBpcyBuZWNlc3Nhcnkgb24gQkUgKi8KKwlyZXR1cm4gcmVhZHEoKHZvaWQg
X19pb21lbSAqKXJpbmctPndwdHJfY3B1X2FkZHIpOworfQorCisvKioKKyAqIGFtZGdwdV9nZnhf
c2V0X3dwdHJfY29tcHV0ZSAtIGNvbW1vbiBzZXRfd3B0ciBmb3IgY29tcHV0ZSByaW5ncyB1c2lu
ZyBkb29yYmVsbHMKKyAqIEByaW5nOiBhbWRncHVfcmluZyBwb2ludGVyCisgKgorICogV3JpdGUg
dGhlIHdyaXRlIHBvaW50ZXIgdG8gdGhlIGRvb3JiZWxsLW1hcHBlZCB3cml0ZWJhY2sgYWRkcmVz
cyBhbmQKKyAqIHJpbmcgdGhlIGRvb3JiZWxsLiAgVGhpcyBpcyBIVy1hZ25vc3RpYyBhbmQgc2hh
cmVkIGFjcm9zcyBHRlgKKyAqIGdlbmVyYXRpb25zIHRoYXQgdXNlIGRvb3JiZWxsLWJhc2VkIGNv
bXB1dGUgcXVldWUgbWFuYWdlbWVudC4KKyAqCisgKiBOb3RlOiB3cml0ZXEoKSBpcyB1c2VkIGRl
c3BpdGUgdGhpcyBiZWluZyBzeXN0ZW0gbWVtb3J5IChub3QgTU1JTykKKyAqIGJlY2F1c2Ugd2Ug
bmVlZCBhbiBhdG9taWMgNjQtYml0IHdyaXRlIHRoYXQgd29uJ3QgdGVhciBvbiAzMi1iaXQKKyAq
IGtlcm5lbHMuCisgKi8KK3ZvaWQgYW1kZ3B1X2dmeF9zZXRfd3B0cl9jb21wdXRlKHN0cnVjdCBh
bWRncHVfcmluZyAqcmluZykKK3sKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJpbmct
PmFkZXY7CisKKwlpZiAoV0FSTl9PTighcmluZy0+dXNlX2Rvb3JiZWxsKSkKKwkJcmV0dXJuOwor
CisJLyogWFhYIGNoZWNrIGlmIHN3YXBwaW5nIGlzIG5lY2Vzc2FyeSBvbiBCRSAqLworCXdyaXRl
cShyaW5nLT53cHRyLCAodm9pZCBfX2lvbWVtICopcmluZy0+d3B0cl9jcHVfYWRkcik7CisKKwkv
KiBFbnN1cmUgdGhlIHdwdHIgd3JpdGUgaXMgdmlzaWJsZSB0byB0aGUgZGV2aWNlIGJlZm9yZSBy
aW5naW5nIHRoZSBkb29yYmVsbCAqLworCXdtYigpOworCisJV0RPT1JCRUxMNjQocmluZy0+ZG9v
cmJlbGxfaW5kZXgsIHJpbmctPndwdHIpOworfQorCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ2Z4LmgKaW5kZXggYTBjZjBhM2I0Li43YmYxNzdkNWEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaAorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmgKQEAgLTY2MSw2ICs2NjEsOSBAQCB1MzIgYW1kZ3B1X2dm
eF9jc2JfcHJlYW1ibGVfc3RhcnQodTMyICpidWZmZXIpOwogdTMyIGFtZGdwdV9nZnhfY3NiX2Rh
dGFfcGFyc2VyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1MzIgKmJ1ZmZlciwgdTMyIGNv
dW50KTsKIHZvaWQgYW1kZ3B1X2dmeF9jc2JfcHJlYW1ibGVfZW5kKHUzMiAqYnVmZmVyLCB1MzIg
Y291bnQpOwogCit1NjQgYW1kZ3B1X2dmeF9nZXRfd3B0cl9jb21wdXRlKHN0cnVjdCBhbWRncHVf
cmluZyAqcmluZyk7Cit2b2lkIGFtZGdwdV9nZnhfc2V0X3dwdHJfY29tcHV0ZShzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcpOworCiB2b2lkIGFtZGdwdV9kZWJ1Z2ZzX2dmeF9zY2hlZF9tYXNrX2lu
aXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogdm9pZCBhbWRncHVfZGVidWdmc19jb21w
dXRlX3NjaGVkX21hc2tfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiAKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKaW5kZXggNThjNjlkY2I1Li40ZWU3YjVhOTIg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC04NTkxLDMxICs4NTkx
LDYgQEAgc3RhdGljIHU2NCBnZnhfdjEwXzBfcmluZ19nZXRfcnB0cl9jb21wdXRlKHN0cnVjdCBh
bWRncHVfcmluZyAqcmluZykKIAlyZXR1cm4gKih1aW50MzJfdCAqKXJpbmctPnJwdHJfY3B1X2Fk
ZHI7CiB9CiAKLXN0YXRpYyB1NjQgZ2Z4X3YxMF8wX3JpbmdfZ2V0X3dwdHJfY29tcHV0ZShzdHJ1
Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCi17Ci0JdTY0IHdwdHI7Ci0KLQkvKiBYWFggY2hlY2sgaWYg
c3dhcHBpbmcgaXMgbmVjZXNzYXJ5IG9uIEJFICovCi0JaWYgKHJpbmctPnVzZV9kb29yYmVsbCkK
LQkJd3B0ciA9IGF0b21pYzY0X3JlYWQoKGF0b21pYzY0X3QgKilyaW5nLT53cHRyX2NwdV9hZGRy
KTsKLQllbHNlCi0JCUJVRygpOwotCXJldHVybiB3cHRyOwotfQotCi1zdGF0aWMgdm9pZCBnZnhf
djEwXzBfcmluZ19zZXRfd3B0cl9jb21wdXRlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKLXsK
LQlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJpbmctPmFkZXY7Ci0KLQlpZiAocmluZy0+
dXNlX2Rvb3JiZWxsKSB7Ci0JCWF0b21pYzY0X3NldCgoYXRvbWljNjRfdCAqKXJpbmctPndwdHJf
Y3B1X2FkZHIsCi0JCQkgICAgIHJpbmctPndwdHIpOwotCQlXRE9PUkJFTEw2NChyaW5nLT5kb29y
YmVsbF9pbmRleCwgcmluZy0+d3B0cik7Ci0JfSBlbHNlIHsKLQkJQlVHKCk7IC8qIG9ubHkgRE9P
UkJFTEwgbWV0aG9kIHN1cHBvcnRlZCBvbiBnZngxMCBub3cgKi8KLQl9Ci19Ci0KIHN0YXRpYyB2
b2lkIGdmeF92MTBfMF9yaW5nX2VtaXRfaGRwX2ZsdXNoKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZykKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJpbmctPmFkZXY7CkBAIC05ODg2
LDggKzk4NjEsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdmeF92
MTBfMF9yaW5nX2Z1bmNzX2NvbXB1dGUgPSB7CiAJLm5vcCA9IFBBQ0tFVDMoUEFDS0VUM19OT1As
IDB4M0ZGRiksCiAJLnN1cHBvcnRfNjRiaXRfcHRycyA9IHRydWUsCiAJLmdldF9ycHRyID0gZ2Z4
X3YxMF8wX3JpbmdfZ2V0X3JwdHJfY29tcHV0ZSwKLQkuZ2V0X3dwdHIgPSBnZnhfdjEwXzBfcmlu
Z19nZXRfd3B0cl9jb21wdXRlLAotCS5zZXRfd3B0ciA9IGdmeF92MTBfMF9yaW5nX3NldF93cHRy
X2NvbXB1dGUsCisJLmdldF93cHRyID0gYW1kZ3B1X2dmeF9nZXRfd3B0cl9jb21wdXRlLAorCS5z
ZXRfd3B0ciA9IGFtZGdwdV9nZnhfc2V0X3dwdHJfY29tcHV0ZSwKIAkuZW1pdF9mcmFtZV9zaXpl
ID0KIAkJMjAgKyAvKiBnZnhfdjEwXzBfcmluZ19lbWl0X2dkc19zd2l0Y2ggKi8KIAkJNyArIC8q
IGdmeF92MTBfMF9yaW5nX2VtaXRfaGRwX2ZsdXNoICovCkBAIC05OTI2LDggKzk5MDEsOCBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdmeF92MTBfMF9yaW5nX2Z1bmNz
X2tpcSA9IHsKIAkubm9wID0gUEFDS0VUMyhQQUNLRVQzX05PUCwgMHgzRkZGKSwKIAkuc3VwcG9y
dF82NGJpdF9wdHJzID0gdHJ1ZSwKIAkuZ2V0X3JwdHIgPSBnZnhfdjEwXzBfcmluZ19nZXRfcnB0
cl9jb21wdXRlLAotCS5nZXRfd3B0ciA9IGdmeF92MTBfMF9yaW5nX2dldF93cHRyX2NvbXB1dGUs
Ci0JLnNldF93cHRyID0gZ2Z4X3YxMF8wX3Jpbmdfc2V0X3dwdHJfY29tcHV0ZSwKKwkuZ2V0X3dw
dHIgPSBhbWRncHVfZ2Z4X2dldF93cHRyX2NvbXB1dGUsCisJLnNldF93cHRyID0gYW1kZ3B1X2dm
eF9zZXRfd3B0cl9jb21wdXRlLAogCS5lbWl0X2ZyYW1lX3NpemUgPQogCQkyMCArIC8qIGdmeF92
MTBfMF9yaW5nX2VtaXRfZ2RzX3N3aXRjaCAqLwogCQk3ICsgLyogZ2Z4X3YxMF8wX3JpbmdfZW1p
dF9oZHBfZmx1c2ggKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMKaW5kZXgg
MmM2ZjFlMjVjLi5jMDY5YjcwMDEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTFfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFf
MC5jCkBAIC01ODkxLDMyICs1ODkxLDYgQEAgc3RhdGljIHU2NCBnZnhfdjExXzBfcmluZ19nZXRf
cnB0cl9jb21wdXRlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKIAlyZXR1cm4gKih1aW50MzJf
dCAqKXJpbmctPnJwdHJfY3B1X2FkZHI7CiB9CiAKLXN0YXRpYyB1NjQgZ2Z4X3YxMV8wX3Jpbmdf
Z2V0X3dwdHJfY29tcHV0ZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCi17Ci0JdTY0IHdwdHI7
Ci0KLQkvKiBYWFggY2hlY2sgaWYgc3dhcHBpbmcgaXMgbmVjZXNzYXJ5IG9uIEJFICovCi0JaWYg
KHJpbmctPnVzZV9kb29yYmVsbCkKLQkJd3B0ciA9IGF0b21pYzY0X3JlYWQoKGF0b21pYzY0X3Qg
KilyaW5nLT53cHRyX2NwdV9hZGRyKTsKLQllbHNlCi0JCUJVRygpOwotCXJldHVybiB3cHRyOwot
fQotCi1zdGF0aWMgdm9pZCBnZnhfdjExXzBfcmluZ19zZXRfd3B0cl9jb21wdXRlKHN0cnVjdCBh
bWRncHVfcmluZyAqcmluZykKLXsKLQlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJpbmct
PmFkZXY7Ci0KLQkvKiBYWFggY2hlY2sgaWYgc3dhcHBpbmcgaXMgbmVjZXNzYXJ5IG9uIEJFICov
Ci0JaWYgKHJpbmctPnVzZV9kb29yYmVsbCkgewotCQlhdG9taWM2NF9zZXQoKGF0b21pYzY0X3Qg
KilyaW5nLT53cHRyX2NwdV9hZGRyLAotCQkJICAgICByaW5nLT53cHRyKTsKLQkJV0RPT1JCRUxM
NjQocmluZy0+ZG9vcmJlbGxfaW5kZXgsIHJpbmctPndwdHIpOwotCX0gZWxzZSB7Ci0JCUJVRygp
OyAvKiBvbmx5IERPT1JCRUxMIG1ldGhvZCBzdXBwb3J0ZWQgb24gZ2Z4MTEgbm93ICovCi0JfQot
fQotCiBzdGF0aWMgdm9pZCBnZnhfdjExXzBfcmluZ19lbWl0X2hkcF9mbHVzaChzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcpCiB7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5h
ZGV2OwpAQCAtNzMzMSw4ICs3MzA1LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmlu
Z19mdW5jcyBnZnhfdjExXzBfcmluZ19mdW5jc19jb21wdXRlID0gewogCS5ub3AgPSBQQUNLRVQz
KFBBQ0tFVDNfTk9QLCAweDNGRkYpLAogCS5zdXBwb3J0XzY0Yml0X3B0cnMgPSB0cnVlLAogCS5n
ZXRfcnB0ciA9IGdmeF92MTFfMF9yaW5nX2dldF9ycHRyX2NvbXB1dGUsCi0JLmdldF93cHRyID0g
Z2Z4X3YxMV8wX3JpbmdfZ2V0X3dwdHJfY29tcHV0ZSwKLQkuc2V0X3dwdHIgPSBnZnhfdjExXzBf
cmluZ19zZXRfd3B0cl9jb21wdXRlLAorCS5nZXRfd3B0ciA9IGFtZGdwdV9nZnhfZ2V0X3dwdHJf
Y29tcHV0ZSwKKwkuc2V0X3dwdHIgPSBhbWRncHVfZ2Z4X3NldF93cHRyX2NvbXB1dGUsCiAJLmVt
aXRfZnJhbWVfc2l6ZSA9CiAJCTUgKyAvKiB1cGRhdGVfc3BtX3ZtaWQgKi8KIAkJMjAgKyAvKiBn
ZnhfdjExXzBfcmluZ19lbWl0X2dkc19zd2l0Y2ggKi8KQEAgLTczNzIsOCArNzM0Niw4IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3MgZ2Z4X3YxMV8wX3JpbmdfZnVuY3Nf
a2lxID0gewogCS5ub3AgPSBQQUNLRVQzKFBBQ0tFVDNfTk9QLCAweDNGRkYpLAogCS5zdXBwb3J0
XzY0Yml0X3B0cnMgPSB0cnVlLAogCS5nZXRfcnB0ciA9IGdmeF92MTFfMF9yaW5nX2dldF9ycHRy
X2NvbXB1dGUsCi0JLmdldF93cHRyID0gZ2Z4X3YxMV8wX3JpbmdfZ2V0X3dwdHJfY29tcHV0ZSwK
LQkuc2V0X3dwdHIgPSBnZnhfdjExXzBfcmluZ19zZXRfd3B0cl9jb21wdXRlLAorCS5nZXRfd3B0
ciA9IGFtZGdwdV9nZnhfZ2V0X3dwdHJfY29tcHV0ZSwKKwkuc2V0X3dwdHIgPSBhbWRncHVfZ2Z4
X3NldF93cHRyX2NvbXB1dGUsCiAJLmVtaXRfZnJhbWVfc2l6ZSA9CiAJCTIwICsgLyogZ2Z4X3Yx
MV8wX3JpbmdfZW1pdF9nZHNfc3dpdGNoICovCiAJCTcgKyAvKiBnZnhfdjExXzBfcmluZ19lbWl0
X2hkcF9mbHVzaCAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3YxMl8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzAuYwppbmRleCA2
YmFhYzUzM2EuLjE3NThhNjA1MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMl8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMl8w
LmMKQEAgLTQ0MDEsMzIgKzQ0MDEsNiBAQCBzdGF0aWMgdTY0IGdmeF92MTJfMF9yaW5nX2dldF9y
cHRyX2NvbXB1dGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQogCXJldHVybiAqKHVpbnQzMl90
ICopcmluZy0+cnB0cl9jcHVfYWRkcjsKIH0KIAotc3RhdGljIHU2NCBnZnhfdjEyXzBfcmluZ19n
ZXRfd3B0cl9jb21wdXRlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKLXsKLQl1NjQgd3B0cjsK
LQotCS8qIFhYWCBjaGVjayBpZiBzd2FwcGluZyBpcyBuZWNlc3Nhcnkgb24gQkUgKi8KLQlpZiAo
cmluZy0+dXNlX2Rvb3JiZWxsKQotCQl3cHRyID0gYXRvbWljNjRfcmVhZCgoYXRvbWljNjRfdCAq
KXJpbmctPndwdHJfY3B1X2FkZHIpOwotCWVsc2UKLQkJQlVHKCk7Ci0JcmV0dXJuIHdwdHI7Ci19
Ci0KLXN0YXRpYyB2b2lkIGdmeF92MTJfMF9yaW5nX3NldF93cHRyX2NvbXB1dGUoc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nKQotewotCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+
YWRldjsKLQotCS8qIFhYWCBjaGVjayBpZiBzd2FwcGluZyBpcyBuZWNlc3Nhcnkgb24gQkUgKi8K
LQlpZiAocmluZy0+dXNlX2Rvb3JiZWxsKSB7Ci0JCWF0b21pYzY0X3NldCgoYXRvbWljNjRfdCAq
KXJpbmctPndwdHJfY3B1X2FkZHIsCi0JCQkgICAgIHJpbmctPndwdHIpOwotCQlXRE9PUkJFTEw2
NChyaW5nLT5kb29yYmVsbF9pbmRleCwgcmluZy0+d3B0cik7Ci0JfSBlbHNlIHsKLQkJQlVHKCk7
IC8qIG9ubHkgRE9PUkJFTEwgbWV0aG9kIHN1cHBvcnRlZCBvbiBnZngxMiBub3cgKi8KLQl9Ci19
Ci0KIHN0YXRpYyB2b2lkIGdmeF92MTJfMF9yaW5nX2VtaXRfaGRwX2ZsdXNoKHN0cnVjdCBhbWRn
cHVfcmluZyAqcmluZykKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJpbmctPmFk
ZXY7CkBAIC01NTUzLDggKzU1MjcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5n
X2Z1bmNzIGdmeF92MTJfMF9yaW5nX2Z1bmNzX2NvbXB1dGUgPSB7CiAJLm5vcCA9IFBBQ0tFVDMo
UEFDS0VUM19OT1AsIDB4M0ZGRiksCiAJLnN1cHBvcnRfNjRiaXRfcHRycyA9IHRydWUsCiAJLmdl
dF9ycHRyID0gZ2Z4X3YxMl8wX3JpbmdfZ2V0X3JwdHJfY29tcHV0ZSwKLQkuZ2V0X3dwdHIgPSBn
ZnhfdjEyXzBfcmluZ19nZXRfd3B0cl9jb21wdXRlLAotCS5zZXRfd3B0ciA9IGdmeF92MTJfMF9y
aW5nX3NldF93cHRyX2NvbXB1dGUsCisJLmdldF93cHRyID0gYW1kZ3B1X2dmeF9nZXRfd3B0cl9j
b21wdXRlLAorCS5zZXRfd3B0ciA9IGFtZGdwdV9nZnhfc2V0X3dwdHJfY29tcHV0ZSwKIAkuZW1p
dF9mcmFtZV9zaXplID0KIAkJNyArIC8qIGdmeF92MTJfMF9yaW5nX2VtaXRfaGRwX2ZsdXNoICov
CiAJCTUgKyAvKiBoZHAgaW52YWxpZGF0ZSAqLwpAQCAtNTU5MSw4ICs1NTY1LDggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjEyXzBfcmluZ19mdW5jc19raXEg
PSB7CiAJLm5vcCA9IFBBQ0tFVDMoUEFDS0VUM19OT1AsIDB4M0ZGRiksCiAJLnN1cHBvcnRfNjRi
aXRfcHRycyA9IHRydWUsCiAJLmdldF9ycHRyID0gZ2Z4X3YxMl8wX3JpbmdfZ2V0X3JwdHJfY29t
cHV0ZSwKLQkuZ2V0X3dwdHIgPSBnZnhfdjEyXzBfcmluZ19nZXRfd3B0cl9jb21wdXRlLAotCS5z
ZXRfd3B0ciA9IGdmeF92MTJfMF9yaW5nX3NldF93cHRyX2NvbXB1dGUsCisJLmdldF93cHRyID0g
YW1kZ3B1X2dmeF9nZXRfd3B0cl9jb21wdXRlLAorCS5zZXRfd3B0ciA9IGFtZGdwdV9nZnhfc2V0
X3dwdHJfY29tcHV0ZSwKIAkuZW1pdF9mcmFtZV9zaXplID0KIAkJNyArIC8qIGdmeF92MTJfMF9y
aW5nX2VtaXRfaGRwX2ZsdXNoICovCiAJCTUgKyAvKmhkcCBpbnZhbGlkYXRlICovCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRleCAyZWIzMmY5MmEuLmNkOGM2MmI2ZCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCkBAIC01NjM0LDMxICs1NjM0LDYgQEAg
c3RhdGljIHU2NCBnZnhfdjlfMF9yaW5nX2dldF9ycHRyX2NvbXB1dGUoc3RydWN0IGFtZGdwdV9y
aW5nICpyaW5nKQogCXJldHVybiAqcmluZy0+cnB0cl9jcHVfYWRkcjsgLyogZ2Z4OSBoYXJkd2Fy
ZSBpcyAzMmJpdCBycHRyICovCiB9CiAKLXN0YXRpYyB1NjQgZ2Z4X3Y5XzBfcmluZ19nZXRfd3B0
cl9jb21wdXRlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKLXsKLQl1NjQgd3B0cjsKLQotCS8q
IFhYWCBjaGVjayBpZiBzd2FwcGluZyBpcyBuZWNlc3Nhcnkgb24gQkUgKi8KLQlpZiAocmluZy0+
dXNlX2Rvb3JiZWxsKQotCQl3cHRyID0gYXRvbWljNjRfcmVhZCgoYXRvbWljNjRfdCAqKXJpbmct
PndwdHJfY3B1X2FkZHIpOwotCWVsc2UKLQkJQlVHKCk7Ci0JcmV0dXJuIHdwdHI7Ci19Ci0KLXN0
YXRpYyB2b2lkIGdmeF92OV8wX3Jpbmdfc2V0X3dwdHJfY29tcHV0ZShzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmcpCi17Ci0Jc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owot
Ci0JLyogWFhYIGNoZWNrIGlmIHN3YXBwaW5nIGlzIG5lY2Vzc2FyeSBvbiBCRSAqLwotCWlmIChy
aW5nLT51c2VfZG9vcmJlbGwpIHsKLQkJYXRvbWljNjRfc2V0KChhdG9taWM2NF90ICopcmluZy0+
d3B0cl9jcHVfYWRkciwgcmluZy0+d3B0cik7Ci0JCVdET09SQkVMTDY0KHJpbmctPmRvb3JiZWxs
X2luZGV4LCByaW5nLT53cHRyKTsKLQl9IGVsc2V7Ci0JCUJVRygpOyAvKiBvbmx5IERPT1JCRUxM
IG1ldGhvZCBzdXBwb3J0ZWQgb24gZ2Z4OSBub3cgKi8KLQl9Ci19Ci0KIHN0YXRpYyB2b2lkIGdm
eF92OV8wX3JpbmdfZW1pdF9mZW5jZV9raXEoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1NjQg
YWRkciwKIAkJCQkJIHU2NCBzZXEsIHVuc2lnbmVkIGludCBmbGFncykKIHsKQEAgLTc2MTQsOCAr
NzU4OSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3MgZ2Z4X3Y5XzBf
cmluZ19mdW5jc19jb21wdXRlID0gewogCS5ub3AgPSBQQUNLRVQzKFBBQ0tFVDNfTk9QLCAweDNG
RkYpLAogCS5zdXBwb3J0XzY0Yml0X3B0cnMgPSB0cnVlLAogCS5nZXRfcnB0ciA9IGdmeF92OV8w
X3JpbmdfZ2V0X3JwdHJfY29tcHV0ZSwKLQkuZ2V0X3dwdHIgPSBnZnhfdjlfMF9yaW5nX2dldF93
cHRyX2NvbXB1dGUsCi0JLnNldF93cHRyID0gZ2Z4X3Y5XzBfcmluZ19zZXRfd3B0cl9jb21wdXRl
LAorCS5nZXRfd3B0ciA9IGFtZGdwdV9nZnhfZ2V0X3dwdHJfY29tcHV0ZSwKKwkuc2V0X3dwdHIg
PSBhbWRncHVfZ2Z4X3NldF93cHRyX2NvbXB1dGUsCiAJLmVtaXRfZnJhbWVfc2l6ZSA9CiAJCTIw
ICsgLyogZ2Z4X3Y5XzBfcmluZ19lbWl0X2dkc19zd2l0Y2ggKi8KIAkJNyArIC8qIGdmeF92OV8w
X3JpbmdfZW1pdF9oZHBfZmx1c2ggKi8KQEAgLTc2NTYsOCArNzYzMSw4IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3MgZ2Z4X3Y5XzBfcmluZ19mdW5jc19raXEgPSB7CiAJ
Lm5vcCA9IFBBQ0tFVDMoUEFDS0VUM19OT1AsIDB4M0ZGRiksCiAJLnN1cHBvcnRfNjRiaXRfcHRy
cyA9IHRydWUsCiAJLmdldF9ycHRyID0gZ2Z4X3Y5XzBfcmluZ19nZXRfcnB0cl9jb21wdXRlLAot
CS5nZXRfd3B0ciA9IGdmeF92OV8wX3JpbmdfZ2V0X3dwdHJfY29tcHV0ZSwKLQkuc2V0X3dwdHIg
PSBnZnhfdjlfMF9yaW5nX3NldF93cHRyX2NvbXB1dGUsCisJLmdldF93cHRyID0gYW1kZ3B1X2dm
eF9nZXRfd3B0cl9jb21wdXRlLAorCS5zZXRfd3B0ciA9IGFtZGdwdV9nZnhfc2V0X3dwdHJfY29t
cHV0ZSwKIAkuZW1pdF9mcmFtZV9zaXplID0KIAkJMjAgKyAvKiBnZnhfdjlfMF9yaW5nX2VtaXRf
Z2RzX3N3aXRjaCAqLwogCQk3ICsgLyogZ2Z4X3Y5XzBfcmluZ19lbWl0X2hkcF9mbHVzaCAqLwot
LSAKMi40My4wCgo=
--000000000000f89fc70650add7e2--
