Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CC3CD13CF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 13:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04E810E3E2;
	Wed, 29 Apr 2026 13:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E9hOJUHY";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBA410F01F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 13:40:07 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12dc9b6beceso251173c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 06:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777470007; cv=none;
 d=google.com; s=arc-20240605;
 b=ORliq9UvLcR+eZV8YSJq2IPBKPLff5dCgPc2Hz+pr25DN6Ja73LnhCu+tLu7jMxAJO
 a8LZPTsTvlbjUHSWRxGUcfpIqkb2+yVDLBdyzXF9AnLAHOT7nEEwdPfQVDMitp9YC9lb
 ScNd6mgz3vspXvAuaKeNQBg5bbvTJu1NPKTF5xDQnSUgvU4dtT96AkAiDpiIXGIR7xzv
 mvPPHJQwZMV5lo/U0zKmFjEb7A3WyTmHHd35lkSsksXKFqtxs1Xqt33fufZ5hSQP7Z79
 fLi+tEK1T55B1qhfK/GJsqALaHCYC2phT2o8O7euYIA+0JUJ67oBwxRiRJhRcANcgcK/
 a5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2vv7ry/nAFGK1PnsE3TXJyny+TwNEApBTxnGyUb/yH4=;
 fh=rNLdqtoPl+IfdUwE5Oj4OS3uqFvZ8G4SNWb9LCwE6dA=;
 b=dgZxDu0a7+VWcI+4ImvXO8h0vp6c31/u2BpqYWd1u43Vu15r/vyyByGkEqn8ytau/w
 78XqcGzIuMG5Y97CMfejuXkS0H5sLWjPrIOkjSYcvSf+YVriNWA8+oc6sHHqVuTWT0zB
 a+e3/m+hLs3eMlx+gQPaEwGtv65ERDaLltLUUX51Y39SqhKw70FG1taJUMsRyrG/khb9
 XAAgtJrSHcsnwHRGzGifmVIMv3GoKuVdVpzGkl/Oj2VTOB6khL27k4wxuBfb/wC7SBrx
 6gfECSDxaXmvOpjCrzMBnhBgicAPLU0+wdm0xBJx/cxupTGvJLmNWMyCudoJYSpbPvOI
 PQQA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777470007; x=1778074807; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vv7ry/nAFGK1PnsE3TXJyny+TwNEApBTxnGyUb/yH4=;
 b=E9hOJUHYB2HP+RPX5nHJxmZDM96cdJab6FgsKdF7840ncpkWwrW6QpfMwugFPuPnZi
 FDGBYpXMugZ9MOcE2HkdItfuqZcr+A1O7fauseQEQMql6r6q4bDqC6mevP98geXXPcNy
 xpd1buPMvo34Oqc4zlpF9QGEU+V5yhb26JaTnY799osf4wczn1a/ymXadHwVgXtenfIM
 FOCSYjqbRYAyCxJhzTLHKYeMXhSRzdL2/sH4ZrJZSDOj4616cSbPdEIJUXb02DAwB+Je
 xZFGIqgYZ7WAVlO7UdgHeooap04Bd3QvxjoDZzQS/FUaZnKjhQuRq/+Awp2ndb1KdXoC
 X73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777470007; x=1778074807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2vv7ry/nAFGK1PnsE3TXJyny+TwNEApBTxnGyUb/yH4=;
 b=Ilp+to76a4SQI56OthH5WNYVHfM4c4VfsJbyQfd9BBx73yWCEKAlE9lHLM9CgAn0Co
 KPPaDbHyIxcgei61Ecu1b18nQH00yGCSUlLuYmJJFclFV+RJ/Rgv2lWih94CN48K7IGr
 MY6vacBqYDBuxQhjTYD+8kQHsXt35h85zyZMvy8kldeOBomH/Si0nHvl6x/gp4ek7Yeh
 mR4HYbubnUw1IETRH6kEiV6Cd2oFmSqNd4XofX/QkkU5np9mQxq3aQK2VF36XCVsoJCd
 Od4V0r2uDL1ocm7BEJ8R8pv1YubJGpYsFAkaKoyeYNNn+cHCOzypSCCbpkAi4CYLg5h+
 mYSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/d7xDzY9sj19e21+6Hl2QqZZenK5ZWS8GPuz+OOJ+zLXRFOUbaGPnBXBdfcpccvbYrsUwnOY+x@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKQKmGFb1vQqRAp6eX3/odj/anCu9ulVlYxmLzj7sVv1xRCl5d
 hUEMZtA7TbGzlk8z16p+B6ud+p25wkRLaqa+6q9dTK3GgVF+b0w6YZgS35nnh2EfDe6BhwvSdGA
 PI535IaLExD9YquHHVVmrO3lCxtd7q7sh0cLO
X-Gm-Gg: AeBDievNZ7vg5HtCPrQ1AitiDl+1Bqwe6VxUn1b/4OOAy4AMaCBwAKlanqJFxZvhqtG
 IFQAykvKSkQzF5E/C31ybyC/Lxm7UbdSpZHVBFLaOSmANtFidLtrCwWh1duM42a/uADjyHTdIY9
 PqpT+WWkQZOy6BQtP09Ae/p1/5UK4+gfkgJn7GKQpK1T4bdbp60n/GZb6FD7OqwHAE6wXqBeei+
 tk7xlH6vgRWwCymi+lIl+Ad14nUUS9yH41zuf3crtuVd2xlPumafF15vD3YzvjsiOmzuKB4tFfK
 hC+20iQSRb+mPZemdmCI8EIS+3PznIUJ+U249bUUbUq9xtt4c9yjy3QMLfp/uYn03i1QSnMmQDX
 ZltY8
X-Received: by 2002:a05:7022:486:b0:127:def:dd72 with SMTP id
 a92af1059eb24-12ddd4e3edemr1702718c88.2.1777470006846; Wed, 29 Apr 2026
 06:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260429032621.10888-1-jbmoore61@gmail.com>
 <20260429032621.10888-2-jbmoore61@gmail.com>
In-Reply-To: <20260429032621.10888-2-jbmoore61@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Apr 2026 09:39:55 -0400
X-Gm-Features: AVHnY4IkQCnHkczNscHdzRu0YUL9YeBn90Y0lemfBJi60JvAYqSuO9_LQqUfr4I
Message-ID: <CADnq5_Pjfc4z4-z0qu9whjJtW6pw9wh4exoM2K2_Q2-SOxY7uQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/amdgpu/ring: extract kiq_read_clock to common
 HW-agnostic code
To: "John B. Moore" <jbmoore61@gmail.com>
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, 
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

On Wed, Apr 29, 2026 at 7:04=E2=80=AFAM John B. Moore <jbmoore61@gmail.com>=
 wrote:
>
> Move gfx_v9_0_kiq_read_clock() from gfx_v9_0.c to amdgpu_ring.c
> as amdgpu_kiq_read_clock(). The function uses PACKET3_COPY_DATA to
> read the GPU clock counter via the KIQ ring and is not in any way
> HW generation dependent -- it can be reused by any GFX IP version
> that needs KIQ-based clock reads in SRIOV environments.

This function is dependent.  The packet format format is specific to
an IP type and version.  I think the idea was to move
gfx_v*_ring_get_wptr_compute() to a general helper in amdgpu_gfx.c.
E.g., amdgpu_gfx_get_wptr_doorbell() That said, the BUG() (i.e., the
non-doorbell path could be implemented, it's just more costly because
you have to use the GRBM_INDEX register to access the registers
indirectly.

Alex

>
> Preserve the original block comment explaining the gpu_recover()
> deadlock avoidance logic for the reset-path bail-out.
>
> Requested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: John B. Moore <jbmoore61@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 85 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 74 +--------------------
>  3 files changed, 88 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 447e734c3..75e200211 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -524,6 +524,7 @@ struct amdgpu_wb {
>
>  int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
>  void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
> +uint64_t amdgpu_kiq_read_clock(struct amdgpu_device *adev);
>
>  /*
>   * Benchmarking
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 4638a686a..6049215ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -35,6 +35,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_ras_mgr.h"
>  #include "atom.h"
> +#include "sid.h"
>
>  /*
>   * Rings
> @@ -926,3 +927,87 @@ bool amdgpu_ring_is_reset_type_supported(struct amdg=
pu_ring *ring,
>         }
>         return false;
>  }
> +
> +/**
> + * amdgpu_kiq_read_clock - read GPU clock via KIQ ring
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Use the KIQ (Kernel Interface Queue) to issue a COPY_DATA packet
> + * that reads the GPU clock counter into a writeback buffer.
> + * This is HW-generation agnostic and can be used by any IP that
> + * needs to read the GPU clock via KIQ in SRIOV environments.
> + *
> + * Returns the 64-bit GPU clock value, or ~0 on failure.
> + */
> +uint64_t amdgpu_kiq_read_clock(struct amdgpu_device *adev)
> +{
> +       signed long r, cnt =3D 0;
> +       unsigned long flags;
> +       uint32_t seq, reg_val_offs =3D 0;
> +       uint64_t value =3D 0;
> +       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> +       struct amdgpu_ring *ring =3D &kiq->ring;
> +
> +       spin_lock_irqsave(&kiq->ring_lock, flags);
> +       if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
> +               pr_err("critical bug! too many kiq readers\n");
> +               goto failed_unlock;
> +       }
> +       amdgpu_ring_alloc(ring, 32);
> +       amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
> +       amdgpu_ring_write(ring, 9 |             /* src: GPU clock */
> +                               (5 << 8) |      /* dst: memory */
> +                               (1 << 16) |     /* count sel */
> +                               (1 << 20));     /* write confirm */
> +       amdgpu_ring_write(ring, 0);
> +       amdgpu_ring_write(ring, 0);
> +       amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> +                               reg_val_offs * 4));
> +       amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> +                               reg_val_offs * 4));
> +       r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> +       if (r)
> +               goto failed_undo;
> +
> +       amdgpu_ring_commit(ring);
> +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +       r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +
> +       /* don't wait anymore for gpu reset case because this way may
> +        * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
> +        * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
> +        * never return if we keep waiting in virt_kiq_rreg, which cause
> +        * gpu_recover() hang there.
> +        *
> +        * also don't wait anymore for IRQ context
> +        * */
> +       if (r < 1 && (amdgpu_in_reset(adev)))
> +               goto failed_kiq_read;
> +
> +       might_sleep();
> +       while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> +               msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> +               r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WA=
IT);
> +       }
> +
> +       if (cnt > MAX_KIQ_REG_TRY)
> +               goto failed_kiq_read;
> +
> +       mb();
> +       value =3D (uint64_t)adev->wb.wb[reg_val_offs] |
> +               (uint64_t)adev->wb.wb[reg_val_offs + 1] << 32ULL;
> +       amdgpu_device_wb_free(adev, reg_val_offs);
> +       return value;
> +
> +failed_undo:
> +       amdgpu_ring_undo(ring);
> +failed_unlock:
> +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +failed_kiq_read:
> +       if (reg_val_offs)
> +               amdgpu_device_wb_free(adev, reg_val_offs);
> +       pr_err("failed to read gpu clock\n");
> +       return ~0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 1153121e0..9ae55b060 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4205,77 +4205,7 @@ static int gfx_v9_0_soft_reset(struct amdgpu_ip_bl=
ock *ip_block)
>         return 0;
>  }
>
> -static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
> -{
> -       signed long r, cnt =3D 0;
> -       unsigned long flags;
> -       uint32_t seq, reg_val_offs =3D 0;
> -       uint64_t value =3D 0;
> -       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> -       struct amdgpu_ring *ring =3D &kiq->ring;
> -
> -       spin_lock_irqsave(&kiq->ring_lock, flags);
> -       if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
> -               pr_err("critical bug! too many kiq readers\n");
> -               goto failed_unlock;
> -       }
> -       amdgpu_ring_alloc(ring, 32);
> -       amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
> -       amdgpu_ring_write(ring, 9 |     /* src: register*/
> -                               (5 << 8) |      /* dst: memory */
> -                               (1 << 16) |     /* count sel */
> -                               (1 << 20));     /* write confirm */
> -       amdgpu_ring_write(ring, 0);
> -       amdgpu_ring_write(ring, 0);
> -       amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> -                               reg_val_offs * 4));
> -       amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> -                               reg_val_offs * 4));
> -       r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> -       if (r)
> -               goto failed_undo;
> -
> -       amdgpu_ring_commit(ring);
> -       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -       r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> -
> -       /* don't wait anymore for gpu reset case because this way may
> -        * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
> -        * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
> -        * never return if we keep waiting in virt_kiq_rreg, which cause
> -        * gpu_recover() hang there.
> -        *
> -        * also don't wait anymore for IRQ context
> -        * */
> -       if (r < 1 && (amdgpu_in_reset(adev)))
> -               goto failed_kiq_read;
> -
> -       might_sleep();
> -       while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> -               msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> -               r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WA=
IT);
> -       }
> -
> -       if (cnt > MAX_KIQ_REG_TRY)
> -               goto failed_kiq_read;
> -
> -       mb();
> -       value =3D (uint64_t)adev->wb.wb[reg_val_offs] |
> -               (uint64_t)adev->wb.wb[reg_val_offs + 1 ] << 32ULL;
> -       amdgpu_device_wb_free(adev, reg_val_offs);
> -       return value;
> -
> -failed_undo:
> -       amdgpu_ring_undo(ring);
> -failed_unlock:
> -       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -failed_kiq_read:
> -       if (reg_val_offs)
> -               amdgpu_device_wb_free(adev, reg_val_offs);
> -       pr_err("failed to read gpu clock\n");
> -       return ~0;
> -}
> +/* kiq_read_clock moved to amdgpu_ring.c as amdgpu_kiq_read_clock() */
>
>  static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *ade=
v)
>  {
> @@ -4303,7 +4233,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(stru=
ct amdgpu_device *adev)
>                 if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
>                             IP_VERSION(9, 0, 1) &&
>                     amdgpu_sriov_runtime(adev)) {
> -                       clock =3D gfx_v9_0_kiq_read_clock(adev);
> +                       clock =3D amdgpu_kiq_read_clock(adev);
>                 } else {
>                         WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT=
, 1);
>                         clock =3D (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU=
_CLOCK_COUNT_LSB) |
> --
> 2.43.0
>
