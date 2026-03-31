Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD6E109B46F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 14:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA87010E196;
	Tue, 31 Mar 2026 14:39:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f+KGRUk6";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD4110E196
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 14:39:00 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2c4ae0b1992so204012eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 07:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774967939; cv=none;
 d=google.com; s=arc-20240605;
 b=Yit+O50Zgs6YdD8YQKmTtXcNLdD+yvjnpl5D6kWv2woMi7bKj4IIZA5KTg18KXpPPK
 ogZPDKzz/v0xP8vAy3VmzFMOkAQtGV7zrtri03A2j+E7PPJ6df/rB4G5SO7JR2FS8NoI
 UmyrWDxOa8aMkDc1AkdOJ+a2QjDy37xWMhXs5hlPKRwRLT/bJHSmz+jOrGo9IHs24s26
 vnrMjmcx6uHkm7gj9uWN7tmMrjVkja+9He91ZhdE2l7m5Sn//X7KExCWvbDATNTgCdzU
 xlb55tmXa2FUxFOsFmdPL8d4paDOhqFwOte0DGk3xQ/D9d22rHEnC05UbvMYVBdYZnm1
 vEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=o65bcTJODSw4Zi0qmE/uFJ8m6kOI2qoRoMdNBPsW6xg=;
 fh=gVQrHxK/wjeWc+MQb7ZWakrYEL4hLlJo7ZStDi1BM7I=;
 b=TR9CSbEJgFqk6brNNywXNdDcRenItVcUl1OdHisP6P4lTzNqwr9VotbsbfxRgAicjW
 33R7UTz5cHFqp79YbqhRHqzBqcJ0biKehXIZTSq+5hiAamqg5m1rMJGHcBTbLGth2gcy
 41HJ9CwBASPD4imgIf4M4UikDrFvdPSzE9JF16MvUDO8TKGaOOKN/deXuvenW1L4N9PQ
 gQnYuQ8hzsmbls/D71nX8Rmk9t+9/oSbrhWmhw12T4mF3DKSGGKZ+2bBKkbYGYFJIklz
 s/QBOJxyqR/QHaOb7v1hBJrfTrX6RDWYXU9RXk0uTCEvYZZIYt3gD2r/XSqKJuqGTn3j
 /khA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774967939; x=1775572739; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o65bcTJODSw4Zi0qmE/uFJ8m6kOI2qoRoMdNBPsW6xg=;
 b=f+KGRUk6/+XMJClNPtK0cdELKzrekGZHw7N1YDGrLCQiL7C2F7v4jZmH8mtEXZhq6/
 rF3kKP3219HeK9xrPvF0QB/xrl9qH4qGC5HVQI8go3TPqOqb3Vb2LFnY911Gx/Fvm7fo
 ztl7nOoDC0/T42L4KMtcE1iEvQjDWpMHa2Cvdn3cw1LenEuo+tMguC2UeKMx/9iodcpB
 IT4XlwQwLOmHFYOnHgzLBt1JppRm+TN71JaMtpjzDCRLNeD10sJH6M/AHZ1Ucb51OTY0
 xCXfAgivgNLesxE3zQT7RWqyejfrZ06cPC8n+v9bD3y8a2aTmX01Q8Pr6W97g2/6ejHl
 Q2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774967939; x=1775572739;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o65bcTJODSw4Zi0qmE/uFJ8m6kOI2qoRoMdNBPsW6xg=;
 b=iCKZ+KhB2Z5HUkn37pWXnfRy3OyH6GGHTUCh9FTC4LqULFtrlrpm7i/AO2ceNtjX5K
 Ck+3vHY9NqOGt6c9ichRJACwKblctQ+/Wk+Fv/LKIwfahz4UCNSOEdwoiM8FsYdU38Bv
 1biHp0urQ58wi6tJmyYSEwuUujCMnfwY/OFMolM1ndApLkElPJgDdqMrCs/9Zg7uuBqG
 fd0gWzzhD+RPxpfG+G7jx9JWcvEDZuCeVr1FCqwv8cKn974LTCOrTbzfAiLxmR7V0hxr
 43jcW4d66TFVquSWSfRK5CuPRH//SqarxhSJNU2THWj5MpO0jARR4AOaqZ3YlIS0rl6g
 M2qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS1+b0T/LEmhiZokLSqdKPfcdSg1NkAWjUUfoVnnG3fnfY6cEj42gLQmAtp8fzJwFUXq0nAe3s@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMaHV8CGFvQXiP7qrnBFUJODNLX/IYo++nwLuPJsfX1csWnW/+
 JcHhh5cQDoI/V4SdmWFepsLZXN2erIcsLmIaLp77xRPF9aV3d8tGcm7J2hT8mQ1RcG0dEsPc+qj
 P3Pxsm07hjDEnqaqAqt6xrMPeUaV7bTE=
X-Gm-Gg: ATEYQzzOeJfFnfCWRvfa7NkawopLAeDs1ckRvjmHBiBxUQKb74gVUlUQMJww5dff/i3
 8fMFFnzc1ivTXI5B871vGhhbnvlEYZGxilaJ2UmNF95jc5NB5Ve4dzFivaLR1ph2G+EmjlGdvu2
 jjVZKWkWhsX5z7gcVp3DJMe1y1t8jd5yyqsvBlcDWc8RZ/yPZQVNffVDpy/rpjU2YR7x4uN8YIV
 xNF378tDULw/YYlLsaI11gIJ2Jc38cN97JmNt53EDzIXa5loTkwjO196XsVMmwZNHjIoo17GuKq
 i8ROEW5u51qoLB0d8uGNXOO4aHXllKzqzAZYHQt5xllEDM70ff+Crp5VngC2c2jOioiLSA==
X-Received: by 2002:a05:7022:48f:b0:128:d590:2947 with SMTP id
 a92af1059eb24-12ab28da1bamr4261874c88.4.1774967939156; Tue, 31 Mar 2026
 07:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
 <845af7e1-3ca7-483b-a3b1-0840d9c98596@amd.com>
In-Reply-To: <845af7e1-3ca7-483b-a3b1-0840d9c98596@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 10:38:47 -0400
X-Gm-Features: AQROBzCP4hgUobb8FSouN55pHu2w5WfheoFQp7RyRUobCzfUlEJJglP9scfcXHw
Message-ID: <CADnq5_M-iwCHKJ+cnU1TQSc-aGJC465dwzWGQkhaZoSPz7Wu5g@mail.gmail.com>
Subject: Re: [PATCH v7] drm/amdgpu: replace PASID IDR with XArray
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

Applied.  Thanks!

Alex

On Tue, Mar 31, 2026 at 10:29=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 3/31/26 16:21, Mikhail Gavrilov wrote:
> > Replace the PASID IDR + spinlock with XArray as noted in the TODO
> > left by commit dccd79bb1c7f ("drm/amdgpu: fix the idr allocation
> > flags").
> >
> > The IDR conversion still has an IRQ safety issue:
> > amdgpu_pasid_free() can be called from hardirq context via the fence
> > signal path, but amdgpu_pasid_idr_lock is taken with plain spin_lock()
> > in process context, creating a potential deadlock:
> >
> >      CPU0
> >      ----
> >      spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
> >      <Interrupt>
> >        spin_lock(&amdgpu_pasid_idr_lock) // deadlock
> >
> >    The hardirq call chain is:
> >
> >      sdma_v6_0_process_trap_irq
> >       -> amdgpu_fence_process
> >        -> dma_fence_signal
> >         -> drm_sched_job_done
> >          -> dma_fence_signal
> >           -> amdgpu_pasid_free_cb
> >            -> amdgpu_pasid_free
> >
> > Use XArray with XA_FLAGS_LOCK_IRQ (all xa operations use IRQ-safe
> > locking internally) and XA_FLAGS_ALLOC1 (zero is not a valid PASID).
> > Both xa_alloc_cyclic() and xa_erase() then handle locking
> > consistently, fixing the IRQ safety issue and removing the need for
> > an explicit spinlock.
> >
> > Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> > Fixes: e6d765de3d6b ("drm/amdgpu: prevent immediate PASID reuse case")
> > Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >
> > v7: Rebased on amd-staging-drm-next which already includes
> >     dccd79bb1c7f ("drm/amdgpu: fix the idr allocation flags").
> >     Updated commit message to reflect that sleeping-under-spinlock
> >     is already fixed and the xarray conversion now addresses the
> >     remaining IRQ safety issue.  Inverted error check to
> >     if (r < 0) return r; per Christian K=C3=B6nig.
> > v6: Use DEFINE_XARRAY_FLAGS with XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1
> >     so all xa operations use IRQ-safe locking internally.  Drop
> >     Cc: stable since the regression was never released to any stable
> >     kernel. (Christian K=C3=B6nig)
> >     https://lore.kernel.org/all/20260331111733.118553-1-mikhail.v.gavri=
lov@gmail.com/
> > v5: Use explicit xa_lock_irqsave/__xa_erase for amdgpu_pasid_free()
> >     since xa_erase() only uses plain xa_lock() which is not safe from
> >     hardirq context.
> >     https://lore.kernel.org/all/20260330191120.105065-1-mikhail.v.gavri=
lov@gmail.com/
> > v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
> >     xa_lock_irqsave, as suggested by Lijo Lazar.
> >     https://lore.kernel.org/all/20260330162038.25073-1-mikhail.v.gavril=
ov@gmail.com/
> > v3: Replace IDR with XArray instead of fixing the spinlock, as
> >     suggested by Lijo Lazar.
> >     https://lore.kernel.org/all/20260330110346.16548-1-mikhail.v.gavril=
ov@gmail.com/
> > v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
> >     lock inconsistency (spin_lock -> spin_lock_irqsave).
> >     https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavril=
ov@gmail.com/
> > v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
> >     using idr_preload/GFP_NOWAIT.
> >     https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavril=
ov@gmail.com/
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 34 ++++++++++---------------
> >  1 file changed, 13 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ids.c
> > index e495a8fa13fd..a6ac3b4ce0df 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> > @@ -22,7 +22,7 @@
> >   */
> >  #include "amdgpu_ids.h"
> >
> > -#include <linux/idr.h>
> > +#include <linux/xarray.h>
> >  #include <linux/dma-fence-array.h>
> >
> >
> > @@ -40,8 +40,8 @@
> >   * VMs are looked up from the PASID per amdgpu_device.
> >   */
> >
> > -static DEFINE_IDR(amdgpu_pasid_idr);
> > -static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
> > +static DEFINE_XARRAY_FLAGS(amdgpu_pasid_xa, XA_FLAGS_LOCK_IRQ | XA_FLA=
GS_ALLOC1);
> > +static u32 amdgpu_pasid_xa_next;
> >
> >  /* Helper to free pasid from a fence callback */
> >  struct amdgpu_pasid_cb {
> > @@ -62,22 +62,19 @@ struct amdgpu_pasid_cb {
> >   */
> >  int amdgpu_pasid_alloc(unsigned int bits)
> >  {
> > -     int pasid;
> > +     u32 pasid;
> > +     int r;
> >
> >       if (bits =3D=3D 0)
> >               return -EINVAL;
> >
> > -     spin_lock(&amdgpu_pasid_idr_lock);
> > -     /* TODO: Need to replace the idr with an xarry, and then
> > -      * handle the internal locking with ATOMIC safe paths.
> > -      */
> > -     pasid =3D idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> > -                              1U << bits, GFP_ATOMIC);
> > -     spin_unlock(&amdgpu_pasid_idr_lock);
> > -
> > -     if (pasid >=3D 0)
> > -             trace_amdgpu_pasid_allocated(pasid);
> > +     r =3D xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> > +                         XA_LIMIT(1, (1U << bits) - 1),
> > +                         &amdgpu_pasid_xa_next, GFP_KERNEL);
> > +     if (r < 0)
> > +             return r;
> >
> > +     trace_amdgpu_pasid_allocated(pasid);
> >       return pasid;
> >  }
> >
> > @@ -88,10 +85,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
> >  void amdgpu_pasid_free(u32 pasid)
> >  {
> >       trace_amdgpu_pasid_freed(pasid);
> > -
> > -     spin_lock(&amdgpu_pasid_idr_lock);
> > -     idr_remove(&amdgpu_pasid_idr, pasid);
> > -     spin_unlock(&amdgpu_pasid_idr_lock);
> > +     xa_erase(&amdgpu_pasid_xa, pasid);
> >  }
> >
> >  static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> > @@ -634,7 +628,5 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *ade=
v)
> >   */
> >  void amdgpu_pasid_mgr_cleanup(void)
> >  {
> > -     spin_lock(&amdgpu_pasid_idr_lock);
> > -     idr_destroy(&amdgpu_pasid_idr);
> > -     spin_unlock(&amdgpu_pasid_idr_lock);
> > +     xa_destroy(&amdgpu_pasid_xa);
> >  }
>
