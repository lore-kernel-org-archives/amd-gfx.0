Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3A3CD13DE
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 07:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E92D10F25B;
	Thu, 30 Apr 2026 07:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eu1WAGvI";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0497710E041
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 20:23:17 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2b7adb38d65so1721225ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 13:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777494197; cv=none;
 d=google.com; s=arc-20240605;
 b=d2kWBmjRJeheYc3utge2dyMtsUBvvp45++bMA7z3PpjFJbqPxxp3yVwyyh/VkP0hrz
 h53Joko5mnwc3mw6aAH6cdlEbUUYTYFoROt2YohDUPRNGsEA1wTtFBi2cmSZADM8sHc6
 x5lnoJp0o45+mMMF0YW9KiieAqPBAa1QJKc9SjEj4rYkjZVScsB+ZTlrcg2JspEZJMyT
 Fp5vqMDopjGrxrxH1UfKbyLNUhXb4OVG/hDijZEwtmOWWWEvofo5gdk0F7WDLcDDXqfu
 dC60NEYrXg8DgwQGlFhEawcVtIPvtFmaBCi+fgSklLYEoVZYKQ9Vx8K0TJ9JS0wwS8hV
 5xXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KXLJv8yOTZ3ly9UmeJ2xRCNDmjYnXRFjVI3DluyCCnM=;
 fh=CbheFzpiwFQ2Ml4YT3doy4D/jO6EVeeMy1A7ZEqRUiA=;
 b=Rb+cI43B72SmAsGqRqnwCkQdJNVeZTxjkJhTwNrPVVW71YvhSVvQR34eeekAFmG+0y
 l58mjs2FbDGWD5EWwJ2QFG155fs5n8HivcQwkKwZJr6pdzcYairOOy2eiaE/k14Ts0Xg
 Qg36uTNYp3cBSMscg3b+1El7t5Yz88BO+TsG+bm4KIRzKwf5K4FJnykHWuY/uyECMXhS
 QKhbc7vmxkFvkejm+qmIiGF2Tx7A6PSUHg17+BRZdwKldw4tmVBpUgjY70BCoKqXe5+E
 GUoZIvgUD3YmvPcOMSf1/aVj45XzQ1XHhgNXlYic3zMZQ1n77E1Ybr/uK0YliDGFPg5W
 hRvA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777494197; x=1778098997; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KXLJv8yOTZ3ly9UmeJ2xRCNDmjYnXRFjVI3DluyCCnM=;
 b=eu1WAGvI1xzGM6sHCMTQq7v+VpDq/sZN5m10qc5cqw2H9I0ohtkcFkKY4O7Pc8YVJk
 Yp7pF2TgB4ROqDhmaXucKBWEqOtbBa1mYWn3mJMVeEE5Ppo6BZx4pae4GFDS1UpCR/cm
 U1mO0pS/yqpJWKkS+KTyZ5bb9Q7JfTn1UlxqptXqqG7vMlbWEUxorT51SMucUQ5m6yfq
 jCyVJoWm8kw/csZTLhmG11kojVReW79EXSUuCInDv/0BQuq50XGblIzwKygPxE8ucvGe
 kcgbCZ8kEtrnRXpsaalwjnX6qpVPYqN9MGY2g86Wo1OYDI++gzq7/hX0XZIQV7xzx7MO
 d/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777494197; x=1778098997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXLJv8yOTZ3ly9UmeJ2xRCNDmjYnXRFjVI3DluyCCnM=;
 b=tXBs7H/EuTeVRYqSpKhlqOe/rE5WNEIwfmfzE60fJ1gQyVyRyd3KR8HHKFUpt/pDlV
 YzXnu2wqsuLRb465BMJmzaP1hMTwNi5U9kp3tOfHkB4UgdrJQhgvgajPrQIp3YMO4kef
 GumSlXt3Ee4bnJvaOErD5LvGPussM+GvydrnhZGzYmKzGx5anV/nbUQSDpTGSbd8N3+O
 XiemclFRozN9jtBrcCh6yKZeZjPt4MbatVkxpFAae4nD+FGM88TPACdqUhHqmtGgBC47
 7oSgUEXx+oNFYy0hbYpBFt7G96eLrlm8ze/mEwjl+RHQkyJjB0QyJ0wP5vR5TwI8qiYX
 WWGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dBD+5fkIwDEh/lMmTVoDeU4EqtMVxFaCTOjC9Qc9c38iLmqUN0UZE8UjLJ9+/5KmGnyix9uEe@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKSfd/hBs2opWmvmzHL9Kygjge/aw8gNbggFcb7JNPYekbD7ui
 coDy32rwtcvd6AtxpU8bb/B3U+BWdD4cYWCpQsSc0H7Rwpic6lNJ19pqVAaAUXhEG0GQYQqVIyn
 5MTXIbR9RXypPdlCs89freU8HFk7h9A==
X-Gm-Gg: AeBDiessEh0Jgwpfhj2VRXIoo4IjAubTtHSbu2mcNoAa++5efZuBp9J8iruUPHTx6OZ
 F4yl25Or+og2XW5cLqhHvTUJAEVLA5CQ3nRCo+FPnTltz/2PqZ+7ee5IpWTx4OKPhgTr4CWebdf
 /+4oKgoWzyrKCsxrebPPiMnTqAcFqA6ahOJBlHmo2Mmm+njJEstmXmUOB0UxRhPH2LH1hLJx3q9
 AybCy6/I1t1Tq+OuX0XyZegxyPELf+p23w8r+7UnCfshOs1ED3iPk8xzxLAW5W9+lJ66TPipnLJ
 4DAaq29z/vNTJT/GuhT8UgS2acH0W1sLktdU8/El8YgJMTkmm5nOlhYEp2QViX1n6+nr+gmWtvO
 JGeRsobeURM21yw==
X-Received: by 2002:a17:902:7b88:b0:2b4:5cd0:b6c3 with SMTP id
 d9443c01a7336-2b97c47c791mr68506245ad.29.1777494197322; Wed, 29 Apr 2026
 13:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260429032621.10888-1-jbmoore61@gmail.com>
 <20260429032621.10888-2-jbmoore61@gmail.com>
 <CADnq5_Pjfc4z4-z0qu9whjJtW6pw9wh4exoM2K2_Q2-SOxY7uQ@mail.gmail.com>
In-Reply-To: <CADnq5_Pjfc4z4-z0qu9whjJtW6pw9wh4exoM2K2_Q2-SOxY7uQ@mail.gmail.com>
From: John Moore <jbmoore61@gmail.com>
Date: Wed, 29 Apr 2026 15:23:06 -0500
X-Gm-Features: AVHnY4Ki2UNsnW4oOEfPCV1PORlnC1Tvjh86j7Fjn92bksnuk_tmq9NJVHIkwh0
Message-ID: <CAPUYzBf-EwYU0Qf55DhVnP9Hwad7X8bA+nc4uDd___g9icYMzQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/amdgpu/ring: extract kiq_read_clock to common
 HW-agnostic code
To: Alex Deucher <alexdeucher@gmail.com>
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000038c9c606509f1ebc"
X-Mailman-Approved-At: Thu, 30 Apr 2026 07:38:12 +0000
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

--00000000000038c9c606509f1ebc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alex,

Thanks for the correction -- you're right, the PACKET3_COPY_DATA encoding
is IP-version-specific. I've dropped that patch entirely.

I have a revised patch that does what you suggested: extracts
the doorbell-based get_wptr/set_wptr for compute rings into common helpers
in amdgpu_gfx.c (amdgpu_gfx_get_wptr_compute / amdgpu_gfx_set_wptr_compute)=
.

The doorbell path is identical across gfx9, gfx10, gfx11, and gfx12 --
this deduplicates ~120 lines and replaces the BUG() in the non-doorbell
fallback with WARN_ON_ONCE.

Not touched: gfx_v7_0, gfx_v8_0, gfx_v9_4_3 (different wptr access
patterns).
I sent the revised patch via git-sendmail.

  John
"I will not be pushed, filed, stamped, indexed, briefed, debriefed, or
numbered."
~ The Prisoner




On Wed, Apr 29, 2026 at 8:40=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:

> On Wed, Apr 29, 2026 at 7:04=E2=80=AFAM John B. Moore <jbmoore61@gmail.co=
m> wrote:
> >
> > Move gfx_v9_0_kiq_read_clock() from gfx_v9_0.c to amdgpu_ring.c
> > as amdgpu_kiq_read_clock(). The function uses PACKET3_COPY_DATA to
> > read the GPU clock counter via the KIQ ring and is not in any way
> > HW generation dependent -- it can be reused by any GFX IP version
> > that needs KIQ-based clock reads in SRIOV environments.
>
> This function is dependent.  The packet format format is specific to
> an IP type and version.  I think the idea was to move
> gfx_v*_ring_get_wptr_compute() to a general helper in amdgpu_gfx.c.
> E.g., amdgpu_gfx_get_wptr_doorbell() That said, the BUG() (i.e., the
> non-doorbell path could be implemented, it's just more costly because
> you have to use the GRBM_INDEX register to access the registers
> indirectly.
>
> Alex
>
> >
> > Preserve the original block comment explaining the gpu_recover()
> > deadlock avoidance logic for the reset-path bail-out.
> >
> > Requested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: John B. Moore <jbmoore61@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 85 ++++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 74 +--------------------
> >  3 files changed, 88 insertions(+), 72 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 447e734c3..75e200211 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -524,6 +524,7 @@ struct amdgpu_wb {
> >
> >  int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
> >  void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
> > +uint64_t amdgpu_kiq_read_clock(struct amdgpu_device *adev);
> >
> >  /*
> >   * Benchmarking
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > index 4638a686a..6049215ce 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -35,6 +35,7 @@
> >  #include "amdgpu.h"
> >  #include "amdgpu_ras_mgr.h"
> >  #include "atom.h"
> > +#include "sid.h"
> >
> >  /*
> >   * Rings
> > @@ -926,3 +927,87 @@ bool amdgpu_ring_is_reset_type_supported(struct
> amdgpu_ring *ring,
> >         }
> >         return false;
> >  }
> > +
> > +/**
> > + * amdgpu_kiq_read_clock - read GPU clock via KIQ ring
> > + *
> > + * @adev: amdgpu_device pointer
> > + *
> > + * Use the KIQ (Kernel Interface Queue) to issue a COPY_DATA packet
> > + * that reads the GPU clock counter into a writeback buffer.
> > + * This is HW-generation agnostic and can be used by any IP that
> > + * needs to read the GPU clock via KIQ in SRIOV environments.
> > + *
> > + * Returns the 64-bit GPU clock value, or ~0 on failure.
> > + */
> > +uint64_t amdgpu_kiq_read_clock(struct amdgpu_device *adev)
> > +{
> > +       signed long r, cnt =3D 0;
> > +       unsigned long flags;
> > +       uint32_t seq, reg_val_offs =3D 0;
> > +       uint64_t value =3D 0;
> > +       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > +       struct amdgpu_ring *ring =3D &kiq->ring;
> > +
> > +       spin_lock_irqsave(&kiq->ring_lock, flags);
> > +       if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
> > +               pr_err("critical bug! too many kiq readers\n");
> > +               goto failed_unlock;
> > +       }
> > +       amdgpu_ring_alloc(ring, 32);
> > +       amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
> > +       amdgpu_ring_write(ring, 9 |             /* src: GPU clock */
> > +                               (5 << 8) |      /* dst: memory */
> > +                               (1 << 16) |     /* count sel */
> > +                               (1 << 20));     /* write confirm */
> > +       amdgpu_ring_write(ring, 0);
> > +       amdgpu_ring_write(ring, 0);
> > +       amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> > +                               reg_val_offs * 4));
> > +       amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> > +                               reg_val_offs * 4));
> > +       r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> > +       if (r)
> > +               goto failed_undo;
> > +
> > +       amdgpu_ring_commit(ring);
> > +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > +
> > +       r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> > +
> > +       /* don't wait anymore for gpu reset case because this way may
> > +        * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
> > +        * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
> > +        * never return if we keep waiting in virt_kiq_rreg, which caus=
e
> > +        * gpu_recover() hang there.
> > +        *
> > +        * also don't wait anymore for IRQ context
> > +        * */
> > +       if (r < 1 && (amdgpu_in_reset(adev)))
> > +               goto failed_kiq_read;
> > +
> > +       might_sleep();
> > +       while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> > +               msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> > +               r =3D amdgpu_fence_wait_polling(ring, seq,
> MAX_KIQ_REG_WAIT);
> > +       }
> > +
> > +       if (cnt > MAX_KIQ_REG_TRY)
> > +               goto failed_kiq_read;
> > +
> > +       mb();
> > +       value =3D (uint64_t)adev->wb.wb[reg_val_offs] |
> > +               (uint64_t)adev->wb.wb[reg_val_offs + 1] << 32ULL;
> > +       amdgpu_device_wb_free(adev, reg_val_offs);
> > +       return value;
> > +
> > +failed_undo:
> > +       amdgpu_ring_undo(ring);
> > +failed_unlock:
> > +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > +failed_kiq_read:
> > +       if (reg_val_offs)
> > +               amdgpu_device_wb_free(adev, reg_val_offs);
> > +       pr_err("failed to read gpu clock\n");
> > +       return ~0;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 1153121e0..9ae55b060 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -4205,77 +4205,7 @@ static int gfx_v9_0_soft_reset(struct
> amdgpu_ip_block *ip_block)
> >         return 0;
> >  }
> >
> > -static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
> > -{
> > -       signed long r, cnt =3D 0;
> > -       unsigned long flags;
> > -       uint32_t seq, reg_val_offs =3D 0;
> > -       uint64_t value =3D 0;
> > -       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > -       struct amdgpu_ring *ring =3D &kiq->ring;
> > -
> > -       spin_lock_irqsave(&kiq->ring_lock, flags);
> > -       if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
> > -               pr_err("critical bug! too many kiq readers\n");
> > -               goto failed_unlock;
> > -       }
> > -       amdgpu_ring_alloc(ring, 32);
> > -       amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
> > -       amdgpu_ring_write(ring, 9 |     /* src: register*/
> > -                               (5 << 8) |      /* dst: memory */
> > -                               (1 << 16) |     /* count sel */
> > -                               (1 << 20));     /* write confirm */
> > -       amdgpu_ring_write(ring, 0);
> > -       amdgpu_ring_write(ring, 0);
> > -       amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> > -                               reg_val_offs * 4));
> > -       amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> > -                               reg_val_offs * 4));
> > -       r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> > -       if (r)
> > -               goto failed_undo;
> > -
> > -       amdgpu_ring_commit(ring);
> > -       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -
> > -       r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> > -
> > -       /* don't wait anymore for gpu reset case because this way may
> > -        * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
> > -        * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
> > -        * never return if we keep waiting in virt_kiq_rreg, which caus=
e
> > -        * gpu_recover() hang there.
> > -        *
> > -        * also don't wait anymore for IRQ context
> > -        * */
> > -       if (r < 1 && (amdgpu_in_reset(adev)))
> > -               goto failed_kiq_read;
> > -
> > -       might_sleep();
> > -       while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> > -               msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> > -               r =3D amdgpu_fence_wait_polling(ring, seq,
> MAX_KIQ_REG_WAIT);
> > -       }
> > -
> > -       if (cnt > MAX_KIQ_REG_TRY)
> > -               goto failed_kiq_read;
> > -
> > -       mb();
> > -       value =3D (uint64_t)adev->wb.wb[reg_val_offs] |
> > -               (uint64_t)adev->wb.wb[reg_val_offs + 1 ] << 32ULL;
> > -       amdgpu_device_wb_free(adev, reg_val_offs);
> > -       return value;
> > -
> > -failed_undo:
> > -       amdgpu_ring_undo(ring);
> > -failed_unlock:
> > -       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -failed_kiq_read:
> > -       if (reg_val_offs)
> > -               amdgpu_device_wb_free(adev, reg_val_offs);
> > -       pr_err("failed to read gpu clock\n");
> > -       return ~0;
> > -}
> > +/* kiq_read_clock moved to amdgpu_ring.c as amdgpu_kiq_read_clock() */
> >
> >  static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device
> *adev)
> >  {
> > @@ -4303,7 +4233,7 @@ static uint64_t
> gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
> >                 if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
> >                             IP_VERSION(9, 0, 1) &&
> >                     amdgpu_sriov_runtime(adev)) {
> > -                       clock =3D gfx_v9_0_kiq_read_clock(adev);
> > +                       clock =3D amdgpu_kiq_read_clock(adev);
> >                 } else {
> >                         WREG32_SOC15(GC, 0,
> mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
> >                         clock =3D (uint64_t)RREG32_SOC15(GC, 0,
> mmRLC_GPU_CLOCK_COUNT_LSB) |
> > --
> > 2.43.0
> >
>

--00000000000038c9c606509f1ebc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Alex,</div><div><br>Thanks for the correction -- you&=
#39;re right, the PACKET3_COPY_DATA encoding<br>is IP-version-specific. I&#=
39;ve dropped that patch entirely.<br><br>I have a revised patch that does =
what you suggested: extracts<br>the doorbell-based get_wptr/set_wptr for co=
mpute rings into common helpers<br>in amdgpu_gfx.c (amdgpu_gfx_get_wptr_com=
pute / amdgpu_gfx_set_wptr_compute).<br><br>The doorbell path is identical =
across gfx9, gfx10, gfx11, and gfx12 --<br>this deduplicates ~120 lines and=
 replaces the BUG() in the non-doorbell<br>fallback with WARN_ON_ONCE.<br><=
br>Not touched: gfx_v7_0, gfx_v8_0, gfx_v9_4_3 (different wptr access patte=
rns).</div><div>I sent the revised patch via git-sendmail.<br><br>=C2=A0 Jo=
hn</div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"g=
mail_signature">&quot;I will not be pushed, filed, stamped, indexed, briefe=
d, debriefed, or numbered.&quot;<br>~ The Prisoner<br><br><br></div></div><=
br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Apr 29, 2026 at 8:40=E2=80=AFAM Alex Deuch=
er &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed=
, Apr 29, 2026 at 7:04=E2=80=AFAM John B. Moore &lt;<a href=3D"mailto:jbmoo=
re61@gmail.com" target=3D"_blank">jbmoore61@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Move gfx_v9_0_kiq_read_clock() from gfx_v9_0.c to amdgpu_ring.c<br>
&gt; as amdgpu_kiq_read_clock(). The function uses PACKET3_COPY_DATA to<br>
&gt; read the GPU clock counter via the KIQ ring and is not in any way<br>
&gt; HW generation dependent -- it can be reused by any GFX IP version<br>
&gt; that needs KIQ-based clock reads in SRIOV environments.<br>
<br>
This function is dependent.=C2=A0 The packet format format is specific to<b=
r>
an IP type and version.=C2=A0 I think the idea was to move<br>
gfx_v*_ring_get_wptr_compute() to a general helper in amdgpu_gfx.c.<br>
E.g., amdgpu_gfx_get_wptr_doorbell() That said, the BUG() (i.e., the<br>
non-doorbell path could be implemented, it&#39;s just more costly because<b=
r>
you have to use the GRBM_INDEX register to access the registers<br>
indirectly.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Preserve the original block comment explaining the gpu_recover()<br>
&gt; deadlock avoidance logic for the reset-path bail-out.<br>
&gt;<br>
&gt; Requested-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koe=
nig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
&gt; Signed-off-by: John B. Moore &lt;<a href=3D"mailto:jbmoore61@gmail.com=
" target=3D"_blank">jbmoore61@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
1 +<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 85 ++++++++++++++++++=
++++++<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c=C2=A0 =C2=A0 | 74 +-------=
-------------<br>
&gt;=C2=A0 3 files changed, 88 insertions(+), 72 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 447e734c3..75e200211 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -524,6 +524,7 @@ struct amdgpu_wb {<br>
&gt;<br>
&gt;=C2=A0 int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);<b=
r>
&gt;=C2=A0 void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);<=
br>
&gt; +uint64_t amdgpu_kiq_read_clock(struct amdgpu_device *adev);<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Benchmarking<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ring.c<br>
&gt; index 4638a686a..6049215ce 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&gt; @@ -35,6 +35,7 @@<br>
&gt;=C2=A0 #include &quot;amdgpu.h&quot;<br>
&gt;=C2=A0 #include &quot;amdgpu_ras_mgr.h&quot;<br>
&gt;=C2=A0 #include &quot;atom.h&quot;<br>
&gt; +#include &quot;sid.h&quot;<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Rings<br>
&gt; @@ -926,3 +927,87 @@ bool amdgpu_ring_is_reset_type_supported(struct a=
mdgpu_ring *ring,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt;=C2=A0 }<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * amdgpu_kiq_read_clock - read GPU clock via KIQ ring<br>
&gt; + *<br>
&gt; + * @adev: amdgpu_device pointer<br>
&gt; + *<br>
&gt; + * Use the KIQ (Kernel Interface Queue) to issue a COPY_DATA packet<b=
r>
&gt; + * that reads the GPU clock counter into a writeback buffer.<br>
&gt; + * This is HW-generation agnostic and can be used by any IP that<br>
&gt; + * needs to read the GPU clock via KIQ in SRIOV environments.<br>
&gt; + *<br>
&gt; + * Returns the 64-bit GPU clock value, or ~0 on failure.<br>
&gt; + */<br>
&gt; +uint64_t amdgpu_kiq_read_clock(struct amdgpu_device *adev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0signed long r, cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t seq, reg_val_offs =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t value =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_kiq *kiq =3D &amp;adev-&gt;g=
fx.kiq[0];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_ring *ring =3D &amp;kiq-&gt;=
ring;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;kiq-&gt;ring_lock, =
flags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_device_wb_get(adev, &amp;reg_va=
l_offs)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;c=
ritical bug! too many kiq readers\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed_un=
lock;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_alloc(ring, 32);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(ring, PACKET3(PACKET3_CO=
PY_DATA, 4));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(ring, 9 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* src: GPU clock */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(5 &lt;&lt; 8) |=C2=A0 =C2=A0 =C2=
=A0 /* dst: memory */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 16) |=C2=A0 =C2=A0 =
=C2=A0/* count sel */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 20));=C2=A0 =C2=A0 =
=C2=A0/* write confirm */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(ring, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(ring, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(ring, lower_32_bits(adev=
-&gt;wb.gpu_addr +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg_val_offs * 4));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(ring, upper_32_bits(adev=
-&gt;wb.gpu_addr +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg_val_offs * 4));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_fence_emit_polling(ring, &amp=
;seq, MAX_KIQ_REG_WAIT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed_un=
do;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_commit(ring);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;kiq-&gt;ring_l=
ock, flags);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_fence_wait_polling(ring, seq,=
 MAX_KIQ_REG_WAIT);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* don&#39;t wait anymore for gpu reset ca=
se because this way may<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * block gpu_recover() routine forever, e.=
g. this virt_kiq_rreg<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * is triggered in TTM and ttm_bo_lock_del=
ayed_workqueue() will<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * never return if we keep waiting in virt=
_kiq_rreg, which cause<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * gpu_recover() hang there.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * also don&#39;t wait anymore for IRQ con=
text<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r &lt; 1 &amp;&amp; (amdgpu_in_reset(a=
dev)))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed_ki=
q_read;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0might_sleep();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0while (r &lt; 1 &amp;&amp; cnt++ &lt; MAX_=
KIQ_REG_TRY) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(MAX_KIQ=
_REG_BAILOUT_INTERVAL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_f=
ence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cnt &gt; MAX_KIQ_REG_TRY)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed_ki=
q_read;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0mb();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D (uint64_t)adev-&gt;wb.wb[reg_val=
_offs] |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t)adev=
-&gt;wb.wb[reg_val_offs + 1] &lt;&lt; 32ULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_device_wb_free(adev, reg_val_offs);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return value;<br>
&gt; +<br>
&gt; +failed_undo:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_undo(ring);<br>
&gt; +failed_unlock:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;kiq-&gt;ring_l=
ock, flags);<br>
&gt; +failed_kiq_read:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (reg_val_offs)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_device_=
wb_free(adev, reg_val_offs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;failed to read gpu clock\n&qu=
ot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return ~0;<br>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v9_0.c<br>
&gt; index 1153121e0..9ae55b060 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; @@ -4205,77 +4205,7 @@ static int gfx_v9_0_soft_reset(struct amdgpu_ip=
_block *ip_block)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)<b=
r>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0signed long r, cnt =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t seq, reg_val_offs =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t value =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_kiq *kiq =3D &amp;adev-&gt;g=
fx.kiq[0];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_ring *ring =3D &amp;kiq-&gt;=
ring;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;kiq-&gt;ring_lock, =
flags);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_device_wb_get(adev, &amp;reg_va=
l_offs)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;c=
ritical bug! too many kiq readers\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed_un=
lock;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_alloc(ring, 32);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(ring, PACKET3(PACKET3_CO=
PY_DATA, 4));<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(ring, 9 |=C2=A0 =C2=A0 =
=C2=A0/* src: register*/<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(5 &lt;&lt; 8) |=C2=A0 =C2=A0 =C2=
=A0 /* dst: memory */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 16) |=C2=A0 =C2=A0 =
=C2=A0/* count sel */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 20));=C2=A0 =C2=A0 =
=C2=A0/* write confirm */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(ring, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(ring, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(ring, lower_32_bits(adev=
-&gt;wb.gpu_addr +<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg_val_offs * 4));<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(ring, upper_32_bits(adev=
-&gt;wb.gpu_addr +<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg_val_offs * 4));<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_fence_emit_polling(ring, &amp=
;seq, MAX_KIQ_REG_WAIT);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed_un=
do;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_commit(ring);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;kiq-&gt;ring_l=
ock, flags);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_fence_wait_polling(ring, seq,=
 MAX_KIQ_REG_WAIT);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* don&#39;t wait anymore for gpu reset ca=
se because this way may<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * block gpu_recover() routine forever, e.=
g. this virt_kiq_rreg<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * is triggered in TTM and ttm_bo_lock_del=
ayed_workqueue() will<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * never return if we keep waiting in virt=
_kiq_rreg, which cause<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * gpu_recover() hang there.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * also don&#39;t wait anymore for IRQ con=
text<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r &lt; 1 &amp;&amp; (amdgpu_in_reset(a=
dev)))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed_ki=
q_read;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0might_sleep();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0while (r &lt; 1 &amp;&amp; cnt++ &lt; MAX_=
KIQ_REG_TRY) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(MAX_KIQ=
_REG_BAILOUT_INTERVAL);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_f=
ence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cnt &gt; MAX_KIQ_REG_TRY)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed_ki=
q_read;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0mb();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D (uint64_t)adev-&gt;wb.wb[reg_val=
_offs] |<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t)adev=
-&gt;wb.wb[reg_val_offs + 1 ] &lt;&lt; 32ULL;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_device_wb_free(adev, reg_val_offs);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return value;<br>
&gt; -<br>
&gt; -failed_undo:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_undo(ring);<br>
&gt; -failed_unlock:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;kiq-&gt;ring_l=
ock, flags);<br>
&gt; -failed_kiq_read:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (reg_val_offs)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_device_=
wb_free(adev, reg_val_offs);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;failed to read gpu clock\n&qu=
ot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return ~0;<br>
&gt; -}<br>
&gt; +/* kiq_read_clock moved to amdgpu_ring.c as amdgpu_kiq_read_clock() *=
/<br>
&gt;<br>
&gt;=C2=A0 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_dev=
ice *adev)<br>
&gt;=C2=A0 {<br>
&gt; @@ -4303,7 +4233,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(s=
truct amdgpu_device *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgp=
u_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IP_VERSION(9, 0, 1) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0amdgpu_sriov_runtime(adev)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0clock =3D gfx_v9_0_kiq_read_clock(adev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0clock =3D amdgpu_kiq_read_clock(adev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0clock =3D (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK=
_COUNT_LSB) |<br>
&gt; --<br>
&gt; 2.43.0<br>
&gt;<br>
</blockquote></div>

--00000000000038c9c606509f1ebc--
