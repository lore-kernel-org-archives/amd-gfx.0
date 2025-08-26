Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806A8CA0FF0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 21:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D2410E2EB;
	Tue, 26 Aug 2025 21:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dPJF1IMf";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A66F10E2EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 21:20:18 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-248887257e0so1173595ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756243217; x=1756848017; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4yupDq+gxCsW6UW7odWaxqU+qQSi1wUS5hjQaJnalM=;
 b=dPJF1IMf6s4b0pCgJq34xaqvOickUBuX0xGG+u/jElxlxmCHxJgpeOBz07DLII7qC7
 woJxYh416MqnLCBzwnVPmHNReMPi6ePGXgSMCaCAC+Tl9LCKv/OOHJcLN3b2BgZO4Dcc
 aZy2edfRhvyYfs0a1CAqNcEdT7EmaRHUhYdboxMd50mpazP94L1vH/U5oykLVRNfKRZ2
 xQj6kpnWdHAZDN8uApd47J9cPH+Z2vYDiq0WonCCWjT6UnCiFWYzgPELu40qz7Tzgo4M
 zhJ06VEeBwZLHtXGd525WHavLBw8/L1shslRTTlU39hmczR03ekNY200/febkadSGiFI
 vyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756243217; x=1756848017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4yupDq+gxCsW6UW7odWaxqU+qQSi1wUS5hjQaJnalM=;
 b=RSsKHKikclpIBZ5qhJ8vCt3/RYqSJE5Gn4cfDU9Jhthk+xo7hdoRzF78SQ6n5eyVZ2
 WpjWUMa1eDoJufnAtL+KIjgz+P0zYRWOzkqMLD0PSYDeIE1V0oOIi512lZ5AnjX0fsqU
 LD3bJPTI1rJt36vuoQw14FeO5pRjHl/B5M5wOvzDLJsTw+ZD30cEAXY/XxE2HngPrpmG
 sXGqvUW044+Hd/TtmCU/KZLjixZck4l1VQ8A/S49IyROHUtelFs+4hcbSCwW8mSFjsQh
 DZNar57WpyfFB9V2eQEuqrEDVbu48Jo19h3EkgRZ2kzjd17rpoOsBKlVUreIX4PXP+cF
 HVmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVifY5A9YXME10wJgkVcbX6fq0FAAE7rb3QlOUY2WDsRKSapDbspUHr4AZg/v4yNenZ+ignHdoN@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzvs2pKfqJb1gg2PdOLvlKA/fdmsIkLjZXdWSBKGRqpUVwt8aW8
 EWzsYKonRLTBVXqaOtJyhO61jPv4oFfO+ZFPlNunU670qZaLi9h6sKSQ6vjLBWLRoOIKsRcRuif
 OVGNjLS1oL4l3F2GEuQK4ayPB4lK3rhQ=
X-Gm-Gg: ASbGncteYhDzzAlLWjRX3B+MLL3huw0wOlpjaORy0mORaqjBVBLW1m0ItjAVtwbCYHt
 WOwUmRfHxZQ+FQY+cCpUchG0hdVgfaIfeCJNXyU6a2GxaXOHM7M4FJtj0zCAhtQpK+1snwJ+yLF
 6Rw+uZ+uSL33RkAqS0c5CqWYzgTYcY3zLayY+kQDYNCXx6Sc1W+SGt8cQTS7XjwPwUY4aWUtT/X
 xjeN6Qc5flS1wUzoqL45L6GTx+a
X-Google-Smtp-Source: AGHT+IGOTxDv5RU6pEODax5UAnRrXtqB2c3BdAgZTanpurZihDFyTl0QTgTB3YjV6dvPisGXAP4wK46DU/PR6JH/xW8=
X-Received: by 2002:a17:902:e5d1:b0:246:9df4:d10 with SMTP id
 d9443c01a7336-2469df4127fmr86254885ad.8.1756243217474; Tue, 26 Aug 2025
 14:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250826193821.869445-1-David.Wu3@amd.com>
 <20250826193821.869445-3-David.Wu3@amd.com>
 <CADnq5_MCiwaLJEXG1y9-D0v8naz0ZnNVurs-cQXBDvAyL+oXDg@mail.gmail.com>
 <1b21a8e5-7aba-48b0-8201-2db619c1e3fd@amd.com>
In-Reply-To: <1b21a8e5-7aba-48b0-8201-2db619c1e3fd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 17:20:05 -0400
X-Gm-Features: Ac12FXxW25BxYNNUWqooSIe_zd6IB2WaLhP0T2oLSCuaRk_opz-rPRBYSk9waac
Message-ID: <CADnq5_MjdGMc_a4N1YJMbgSMAReqe6nQD68=8cOAXWMYRA_DXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: protect potential NULL pointer
 dereferencing
To: David Wu <davidwu2@amd.com>
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Aug 26, 2025 at 5:11=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
> On 2025-08-26 16:58, Alex Deucher wrote:
>
> On Tue, Aug 26, 2025 at 3:48=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@=
amd.com> wrote:
>
> to_amdgpu_fence() could return NULL pointer which needs
> to be protected for dereferencing.
>
> I don't think any of these cases could ever be NULL.  The amdgpu_fence
> is a container for the dma_fence so it will alway be present.  See
> struct amdgpu_fence.
>
> hmmm... but - the function could return NULL based on base.ops - see belo=
w
> if it should never happen then we should remove the checking. I doubt we
> will ever return NULL, however someone knowledgeable PLEASE fix it proper=
ly.
> The patch is only to protect it just in case.

if you look at amdgpu_fence_emit() the fences will only be created
with either amdgpu_job_fence_ops or amdgpu_fence_ops so there is no
way it will be NULL.  It's a false positive.

Alex

>
> static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>
> {
>     struct amdgpu_fence *__f =3D container_of(f, struct amdgpu_fence, bas=
e);
>
>     if (__f->base.ops =3D=3D &amdgpu_fence_ops ||
>         __f->base.ops =3D=3D &amdgpu_job_fence_ops)
>         return __f;
>
>     return NULL;
> }
>
> Alex
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
