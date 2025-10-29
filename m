Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04086CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 18:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF4910E81D;
	Wed, 29 Oct 2025 18:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZK8+Mghm";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 744A310E81D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 18:09:53 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b63e5da0fdeso7579a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761761393; x=1762366193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EcI1WwV4z0/WYruKyKObPkqB87emHNALY9I4+tf6AWo=;
 b=ZK8+MghmRTdxFKdt4zSmK6LX/qg4ZuWm7qQjorcpTVsxMS1pEqfmqv1x8pn3b0OS9T
 0IjBas1tJdM0n1XLqkIA/2Tag/f7H/ng9Lats36eEwRPhziLIXLapQWte+un98P5OaQB
 xS01nkHd+Qtll+t73ZjC9KyZrKzKzdj4x/1zer7qloM+PbI5SZ7w8nr8qknfvntD0QaF
 jYEUorrz/O4riEPdis2jCdG2ueskcvuFiwGvlehJ4ANeETR4PNFiwO/4MdOPFr1H0z5A
 EVzwNyrtOjOtke0XOdGNy7xVoiD7L19/1z7m7X4M6ZNH3+TnEUIkGMC3d841e+3H4Gyl
 wcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761761393; x=1762366193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EcI1WwV4z0/WYruKyKObPkqB87emHNALY9I4+tf6AWo=;
 b=jH89sKG9yoPg/yWJh+SkjYxdtouFq6dKqIrvfvaBu7jG3zyGcJniRINwXzoMzxPlXW
 94Bq4KIsTEd/yLXYB4xt0deitGHdXLSNw8W52HSfmFCMeydQVVCYVn7USalIhI48lJIs
 ruPZcD+ydgYt731LBnVJBMYf790TLhwYw8nN0nBQGta4Equ4dK+8Ql+CfWCWp7qBMRAw
 lMpXhoUMJg/LwBuAiVtk4PrM27+az82lFR3XCsJWJR6+fMZ5fX3DkJk871XsKWx5DJ7U
 ML2hmYz9UTHwF3WNR98hUNmWbLYkJFVCgg9j6EvZRjIuwMXbuOrFF8Db6Dfwj61Hkt16
 +bMQ==
X-Gm-Message-State: AOJu0Yxh03u8ayzKFA5o30m8ro7qEegG3sDsJuO9ZwhPpWsnzva84RDt
 Kf60GuYQvNJxLN9sNalKXZZ/72YnDdd/5yn1YBE+fklrgihVEF4HQlEfZZ0Z0P2AcHyrVK4VK9p
 IeNO4hKE0T2OXptA9Rbwjff4eDy9RS0M=
X-Gm-Gg: ASbGncvohzE103r1G7Ty5ikV8wybuMQJGYWuMJ7o4YxspLAy/rlxnKqaJ3HScX0humW
 +dFM6xgC2xaW7A8uNpGt240XgiDrmbVxB2U1QqcvogNQf+gVjljj4OLSvqrjiyb6hQvyIz5wZcQ
 R2ZMev65Nx3PPJ4pCRW0uZZyEFstLChZbmyJd7tj5AuIHi4RfzDlwqqe4HNDjFNQhbX3XwlhVZ2
 hXGSadIC6kJHtnwCwnh6BwLyyw12PVRxjXInMvJ5yzEfR04ZA5vwHS9qEks
X-Google-Smtp-Source: AGHT+IEJkm2WU3p4uFLH8Hm5Ckf1I4WAQVnHXaXg2tp239N+JOJuhzyco0yc7N9GKVZG2k/MudbEUKzyIfr8O0AI898=
X-Received: by 2002:a17:903:2445:b0:257:3283:b859 with SMTP id
 d9443c01a7336-294deee3548mr20373805ad.9.1761761392841; Wed, 29 Oct 2025
 11:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20251024094445.3090110-1-Jesse.Zhang@amd.com>
 <20251024094445.3090110-3-Jesse.Zhang@amd.com>
In-Reply-To: <20251024094445.3090110-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Oct 2025 14:09:41 -0400
X-Gm-Features: AWmQ_bmWw8FYNI-reEy969dgLYk77yRBOu6rNM5okwSzzxPDE-gXCXfzn_ZvBsk
Message-ID: <CADnq5_PNbFfH+rTBsf3RxdN0wWTDvLRh0ur8t8bYur6fWoNoHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: use irq-safe lock in
 amdgpu_userq_fence_driver_process
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Fri, Oct 24, 2025 at 5:45=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> The amdgpu_userq_fence_driver_process() function can be called from
> both interrupt context (IRQ handlers like gfx_v11_0_eop_irq) and
> process context (workqueues like eviction suspend worker). Using
> regular spin_lock() in interrupt context triggers lockdep warnings
> and could lead to potential deadlocks.
>
> Replace the regular spin_lock()/spin_unlock() with their interrupt-
> safe variants spin_lock_irqsave()/spin_unlock_irqrestore() to
> ensure proper locking semantics in all execution contexts.
>
> This ensures:
> - Interrupts are properly disabled when locking in interrupt context
> - No lockdep warnings due to mixed context usage
> - Safe execution across all code paths that process user queue fences
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 2aeeaa954882..69908b90d255 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -151,15 +151,16 @@ void amdgpu_userq_fence_driver_process(struct amdgp=
u_userq_fence_driver *fence_d
>  {
>         struct amdgpu_userq_fence *userq_fence, *tmp;
>         struct dma_fence *fence;
> +       unsigned long flags;
>         u64 rptr;
>         int i;
>
>         if (!fence_drv)
>                 return;
>
> +       spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>         rptr =3D amdgpu_userq_fence_read(fence_drv);
>
> -       spin_lock(&fence_drv->fence_list_lock);
>         list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, li=
nk) {
>                 fence =3D &userq_fence->base;
>
> @@ -174,7 +175,7 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_=
userq_fence_driver *fence_d
>                 list_del(&userq_fence->link);
>                 dma_fence_put(fence);
>         }
> -       spin_unlock(&fence_drv->fence_list_lock);
> +       spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  }
>
>  void amdgpu_userq_fence_driver_destroy(struct kref *ref)
> --
> 2.49.0
>
