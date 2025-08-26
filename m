Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD5CCA0FF0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 20:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7959310E3B0;
	Tue, 26 Aug 2025 20:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mwiA/7J1";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD8010E3B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 20:59:05 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2489359cc48so490255ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756241945; x=1756846745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/X3A1GNdwEF0g/5O+1nV4lb57RaXGmu0x6FRey+tbv4=;
 b=mwiA/7J11dCt09F6Om3KR5/pmoLN/tNRcy0z4ygshlfFjq0OY3II6tYVSdRemFs3Ci
 N9r1fbqP3SvIa5fat7wmUwtSRvOWPMRyf/BEQzsWsm6lAyLcQjVuLF/UqGHunuOHHQRJ
 BYgG3BCN1UeLarreGFg6BD94M4Bx5+cEWHAnyRdmMLClj52moD+FdturVqN/iYRBXQfm
 oWaC6g8abZ6H+GcjywSmSSH3wTLrfgT7hZZ47gIEs1thpSmSJXdijIsh6jjGl3GV7Kmx
 hMDKZIv4yPmCC2VmFFkTnplXHPuDJo7RIB8x0zrQeLIo/e9ZHzuxXOMWErdFUbQ7cq6X
 XECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756241945; x=1756846745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/X3A1GNdwEF0g/5O+1nV4lb57RaXGmu0x6FRey+tbv4=;
 b=UREvkMGmEg5Mkhy8/O8gNu2cSXH53nbxVxjwa0dzQrmKY/yXbjN7otxiE21S0u/sTA
 OYoxDUVKDyJ9gGHn4Bx5iU05k94wM0X06w6zgo5GF8MvrgJ3aPXf7Gga7Juxo8uUfzTF
 EC36W6YYNddvlzSmCZAuox/UMhluMBQljM0/I4RaDN8jmRGI0jxFRKX2IIL0vYnUy7gj
 Odp8wfOsFFn5gqzVFnaRIWrYRExmrmLh/4LkeNrJFl9cHoyTsop8T6+6C2bpPqdNxt7Z
 ONDGQF8unBn8EUXMScu6ZDGqJ9MSNHdkAFMDh5IgVsvbwHk6NbUrLZ68hQCJG+z579U2
 Rkcg==
X-Gm-Message-State: AOJu0YwvQlXRXHNiBpdhXkMfXPGfuIrcxs6OjIVi9wFRQrkZ1kEHOwIS
 8ub/WS6ppJZaEJGlwbapRv8l6WDh535/RCRcC2O1jdl9i51WAQ6s8FpnVxTXXrs8O23CNX/sNcr
 rl9JnyD9P30j4/rlZuvfSwG0gzoyEQw+ZpeVw
X-Gm-Gg: ASbGncuGtZ7DNNMfEWz+65kUrj81/97Ufqkn5zE8HO2JI3UZXEMZQCjXiVxRiMGKbjx
 JxlMvPhkOswjHwH/z3a2+QiBVf4dpAudcCeYktCj7pT6kkaZECyVQAgXNBLR1P8GR58ap0/NO0i
 PNOUTJp6uU6/Sat77eyBIxyeOfFVI7waWU4d0phDXz2ESX5DbG+ugiJqia4uebux2BWY/+s60Ve
 EViSfFVNs3cGMfmiw==
X-Google-Smtp-Source: AGHT+IEqQVduOC9wx9lXoqBZE9c2UUjtPz8nRhix0V4UDR+AKbVvb0bgPbgHmLZG3BdrNjVBCBt9t1nWXq5Ja1II3jU=
X-Received: by 2002:a17:902:d508:b0:246:cc19:17de with SMTP id
 d9443c01a7336-246cc19233cmr64110645ad.4.1756241944619; Tue, 26 Aug 2025
 13:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250826193821.869445-1-David.Wu3@amd.com>
 <20250826193821.869445-3-David.Wu3@amd.com>
In-Reply-To: <20250826193821.869445-3-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 16:58:52 -0400
X-Gm-Features: Ac12FXzzEQzOloc8zZo1jxvdDpxjKWMuyWNlPVtUyk9Y6ctP9qHbwo7--C4UdUw
Message-ID: <CADnq5_MCiwaLJEXG1y9-D0v8naz0ZnNVurs-cQXBDvAyL+oXDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: protect potential NULL pointer
 dereferencing
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
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

On Tue, Aug 26, 2025 at 3:48=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> to_amdgpu_fence() could return NULL pointer which needs
> to be protected for dereferencing.

I don't think any of these cases could ever be NULL.  The amdgpu_fence
is a container for the dma_fence so it will alway be present.  See
struct amdgpu_fence.

Alex

>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index 2d58aefbd68a7..1432b64d379ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -160,7 +160,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struc=
t dma_fence **f,
>                 }
>         }
>
> -       to_amdgpu_fence(fence)->start_timestamp =3D ktime_get();
> +       am_fence =3D to_amdgpu_fence(fence);
> +       if (am_fence)
> +               am_fence->start_timestamp =3D ktime_get();
>
>         /* This function can't be called concurrently anyway, otherwise
>          * emitting the fence would mess up the hardware ring buffer.
> @@ -387,6 +389,7 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgp=
u_ring *ring)
>         struct amdgpu_fence_driver *drv =3D &ring->fence_drv;
>         struct dma_fence *fence;
>         uint32_t last_seq, sync_seq;
> +       struct amdgpu_fence *f;
>
>         last_seq =3D atomic_read(&ring->fence_drv.last_seq);
>         sync_seq =3D READ_ONCE(ring->fence_drv.sync_seq);
> @@ -399,8 +402,8 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgp=
u_ring *ring)
>         if (!fence)
>                 return 0;
>
> -       return ktime_us_delta(ktime_get(),
> -               to_amdgpu_fence(fence)->start_timestamp);
> +       f =3D to_amdgpu_fence(fence);
> +       return f ? ktime_us_delta(ktime_get(), f->start_timestamp) : 0;
>  }
>
>  /**
> @@ -417,13 +420,16 @@ void amdgpu_fence_update_start_timestamp(struct amd=
gpu_ring *ring, uint32_t seq,
>  {
>         struct amdgpu_fence_driver *drv =3D &ring->fence_drv;
>         struct dma_fence *fence;
> +       struct amdgpu_fence *f;
>
>         seq &=3D drv->num_fences_mask;
>         fence =3D drv->fences[seq];
>         if (!fence)
>                 return;
>
> -       to_amdgpu_fence(fence)->start_timestamp =3D timestamp;
> +       f =3D to_amdgpu_fence(fence);
> +       if (f)
> +               f->start_timestamp =3D timestamp;
>  }
>
>  /**
> @@ -827,7 +833,8 @@ static const char *amdgpu_fence_get_driver_name(struc=
t dma_fence *fence)
>
>  static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>  {
> -       return (const char *)to_amdgpu_fence(f)->ring->name;
> +       struct amdgpu_fence *am_f =3D to_amdgpu_fence(f);
> +       return (const char *) (am_f ? am_f->ring->name : "");
>  }
>
>  static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *=
f)
> @@ -847,8 +854,9 @@ static const char *amdgpu_job_fence_get_timeline_name=
(struct dma_fence *f)
>   */
>  static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>  {
> -       if (!timer_pending(&to_amdgpu_fence(f)->ring->fence_drv.fallback_=
timer))
> -               amdgpu_fence_schedule_fallback(to_amdgpu_fence(f)->ring);
> +       struct amdgpu_fence *am_f =3D to_amdgpu_fence(f);
> +       if (am_f && !timer_pending(&am_f->ring->fence_drv.fallback_timer)=
)
> +               amdgpu_fence_schedule_fallback(am_f->ring);
>
>         return true;
>  }
> --
> 2.43.0
>
