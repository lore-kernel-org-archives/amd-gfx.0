Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BE9C369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 16:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F99810E7F5;
	Tue, 15 Apr 2025 16:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZjsCLf0c";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9375F10E7F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 16:38:22 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2ff6ce72844so1036351a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744735102; x=1745339902; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JlwSDIzXMNCl4WWahR3VPxcpz/vJszW14QIYy9MuNAQ=;
 b=ZjsCLf0cxODp00XhtQ/DmjZ0KQc/5UyJQSLoMelBCSHnI6PveXHqQa0g9OpyQGM/Ft
 HWTL+v2rIkMZbcFM5kdoRQnhXpcgpMYDYQ8E9rWSEsmAN/9Vm4XQ9nNWgsumzK5qWoa0
 AX1wjHO7S3mzWQblHisbpLJ/7QFEARKYHD34Mhal8U2EB2UkFXe103PL9C/zLaI192lq
 EhhwTDRdvReJvSpglVbfMWmt5IVXZlKR/SAi1wV29j7E2bUz7nqJD5nY6jmIao4hOG+z
 9p56aTyDWQ6orNYeOu/Z8yEUUx491Bbd/lTt0VIDBT9YBKaiAXH/07fJu23NhIDPk66e
 6utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744735102; x=1745339902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JlwSDIzXMNCl4WWahR3VPxcpz/vJszW14QIYy9MuNAQ=;
 b=C/cf9KLpqBx/DFXgAPUBoRp+UMAhIwyNLx3E+nnEp5Ewb7fJ2eku1hzobXGc+ochwK
 iALnrhhIbg3PXax6rMASTgAQNbOcORNMCrwljO0rcE42cdMIISPKS3TLnhu09MEeHQNJ
 V9iVZtBZYqcWKyBGLIcJIB/g6KkMMZN55ubgwKaorgF9uD8Hb3xPW7zA++oxhgA3kfdp
 TlU70e7dYx4/PRyMFk4ZFuRWS1gfAjyBYJ2vP1tqetetK4sQHg22iMia8fG1KtURbXAG
 ID0JfJrlnvpzlvAbyGYkqPTSDFNruR+bNhWXn1H5skkmwCXR0fQaI+ltd2cFvV5pahGv
 ywAA==
X-Gm-Message-State: AOJu0Yyjm9HbdndC4NCQui7mgUMesNb/zEQ7qc/crsj1O/zjGC2SQTT4
 iT87LbRtp9thgQXuvxEAbJGoUuGaJqJMSqsMzVNWWymIqvxb9b67EMNkepRN09pKu9h9iIdgYdj
 0gkkRxSIm3mMzLWm0A8V0pz2OkZlwCA==
X-Gm-Gg: ASbGncsansc9CFkvI/3yATT6C6x+BTukBADH4hRC3NCAUwqGiCvjYF7Hquemjg4SOIQ
 Och1JRWLh/A1Sg8E3pK/lyjGWk4srL7EZrCiucw6r1mpW+Gss6rIpq3KwpTs36477DLw5bRfR9d
 5aigaPkbNsWhQL2LrfT8bsUzkm3dsqfOEE
X-Google-Smtp-Source: AGHT+IHFWyUUgrDTEmyO3QNQDEC7KB8CuQ1+cRAnN6KvVYDjegvEGxXhnAGWQThCtumfJTtHX7Rmxid2F8hI9ZQcmkM=
X-Received: by 2002:a17:90b:4d06:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-3084e675421mr2587589a91.0.1744735102017; Tue, 15 Apr 2025
 09:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250415013232.1105469-1-Emily.Deng@amd.com>
In-Reply-To: <20250415013232.1105469-1-Emily.Deng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Apr 2025 12:38:10 -0400
X-Gm-Features: ATxdqUFcZUlo8q6p0hAUEVcFfT2fjHOk0jo4knT6tQtz8a0Vk0utni69YHm4oCY
Message-ID: <CADnq5_ML5iqEaSXNse7Hs7_Xv0F+iDCvvkvE2h9LQRy-1tmYuQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Clear overflow for SRIOV
To: Emily Deng <Emily.Deng@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Apr 14, 2025 at 9:32=E2=80=AFPM Emily Deng <Emily.Deng@amd.com> wro=
te:
>
> For VF, it doesn't have the permission to clear overflow, clear the bit
> by reset.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 15 +++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c |  6 +++++-
>  4 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ih.c
> index 901f8b12c672..30f16968b578 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -25,6 +25,7 @@
>
>  #include "amdgpu.h"
>  #include "amdgpu_ih.h"
> +#include "amdgpu_reset.h"
>
>  /**
>   * amdgpu_ih_ring_init - initialize the IH state
> @@ -227,13 +228,23 @@ int amdgpu_ih_process(struct amdgpu_device *adev, s=
truct amdgpu_ih_ring *ih)
>                 ih->rptr &=3D ih->ptr_mask;
>         }
>
> -       amdgpu_ih_set_rptr(adev, ih);
> +       if (!ih->overflow)
> +               amdgpu_ih_set_rptr(adev, ih);
> +
>         wake_up_all(&ih->wait_process);
>
>         /* make sure wptr hasn't changed while processing */
>         wptr =3D amdgpu_ih_get_wptr(adev, ih);
>         if (wptr !=3D ih->rptr)
> -               goto restart_ih;
> +               if (!ih->overflow)
> +                       goto restart_ih;
> +
> +       if (ih->overflow)
> +               if (amdgpu_sriov_runtime(adev))
> +                       WARN_ONCE(!amdgpu_reset_domain_schedule(adev->res=
et_domain,
> +                                  &adev->virt.flr_work),
> +                                 "Failed to queue work! at %s",
> +                                 __func__);
>
>         return IRQ_HANDLED;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ih.h
> index b0a88f92cd82..7f7ea046e209 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -72,6 +72,7 @@ struct amdgpu_ih_ring {
>         /* For waiting on IH processing at checkpoint. */
>         wait_queue_head_t wait_process;
>         uint64_t                processed_timestamp;
> +       bool overflow;
>  };
>
>  /* return true if time stamp t2 is after t1 with 48bit wrap around */
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/ih_v6_0.c
> index f8a485164437..8d3ae88b96a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -349,6 +349,7 @@ static int ih_v6_0_irq_init(struct amdgpu_device *ade=
v)
>                         if (ret)
>                                 return ret;
>                 }
> +               ih[i]->overflow =3D false;
>         }
>
>         /* update doorbell range for ih ring 0 */
> @@ -446,7 +447,10 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *ad=
ev,
>         wptr =3D RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
>         if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>                 goto out;
> -       wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> +       if (!amdgpu_sriov_vf(adev))
> +               wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> +       else
> +               ih->overflow =3D true;
>
>         /* When a ring buffer overflow happen start parsing interrupt
>          * from the last not overwritten vector (wptr + 32). Hopefully
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd=
/amdgpu/vega20_ih.c
> index e9e3b2ed4b7b..2ad209406d17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -350,6 +350,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *a=
dev)
>                         if (ret)
>                                 return ret;
>                 }
> +               ih[i]->overflow =3D false;
>         }
>
>         if (!amdgpu_sriov_vf(adev))
> @@ -437,7 +438,10 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *=
adev,
>         if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>                 goto out;
>
> -       wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> +       if (!amdgpu_sriov_vf(adev))
> +               wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> +       else
> +               ih->overflow =3D true;
>
>         /* When a ring buffer overflow happen start parsing interrupt
>          * from the last not overwritten vector (wptr + 32). Hopefully
> --
> 2.34.1
>
