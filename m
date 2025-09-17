Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD13CAC599
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 14:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CEC10E842;
	Wed, 17 Sep 2025 14:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NgyD3TER";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C155510E842
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 14:05:14 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b4fb8d5dad0so415138a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758117914; x=1758722714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/601wy+oQnzWNwSo83Xz6DJ4kd7xAfSf3ZjbtUudj8=;
 b=NgyD3TERoZL1fT6QmLkEebaqZ/6/9rQUi5FQb8Iw/+CALp1hlzuiYIgIRH2ALE9p/0
 aAQBI8x5PTL2X+ZdCl08kgn3ewN647e3ktOtz1Qjl9696rq7V/tEoN4doXDhKiospw/D
 lGv9WEE9hI8iDiq2gsfGBtyhiPsmktrWn3jVyqdZebLFM6ZjJubiZ9V3WX84Ku9+XDCk
 WniYef4SYxYhszlZ2u29iwCXOdwmFU4KbUsEr9V7oj02FMG6hYso7KMUxcQvJefzkn9K
 gIPHmnfmoj9RnIvrrnWg0EE/jJeAxU4VzRU60DKR9bbyEwBmO7UhpYaAihoj4vnq2wgJ
 Qw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758117914; x=1758722714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/601wy+oQnzWNwSo83Xz6DJ4kd7xAfSf3ZjbtUudj8=;
 b=wV8u+27BkMhmLqAkP6OQH1Ao71vac921Jkkfh3+p2Jvl9jYGKjTL0JdbhmeHbwiA5J
 LrzOvzww6Olusi0weyXg2/EEvks7/GG//0OV0NtcLLdjrxwzUF3z11pPFO1JqrRuz2ru
 byfpgbXHKw6Kra9E78ARdUYbaV+e1uvB7xu9zh4fYqLWVZIw6XOs4ARk+SI90MmN//H0
 n93rZeGKxTCxtrFPKN19lckA5vHhNvuAWFm9mFW87UZYhJ6VLGtLuWTMwTin0ATxdpCE
 IfJskPFVz7nEkwtkFCo3xSghYMG4DcxbMTz3IifcomI/jweglJgklKH19R3Fo0tP+taR
 cH6A==
X-Gm-Message-State: AOJu0Yy4X2/2WGQG1xcHALq0ctGKKHXj6NfOd0asey/JXBcntjlOYMMX
 TDIye0WiFEBCk5iTsdqEsaIe4xd3VNzc0Z6J9j6c4LPYBCWXRoqwjImXRYDWJBFEAFVi3UNaHXN
 oKKDY9+wM1zC7DY//6yUNKVYE8GCG124=
X-Gm-Gg: ASbGncsd6P6Ut+NpFHc3miJ4FBjmWf5Vhyw1+zUNocqCuWEKrlXhlDymuIvnto1sup+
 PrTdLve2LAhgaWObgPUtir/D5toW98Av0jVOPjHn5fM8QSgP7kmeaCT/CIm1/AiKS2IT7bhkQfr
 CywSUbBvpR7HJGm7dV4lr61Ss1dS291cIaAs2dOl7YY3etnTyhEOiQev+9iAdgj/owi9HzLIo0s
 uK7Pyq7
X-Google-Smtp-Source: AGHT+IFLt38PSUCobxSvWv4ST13oeAi1sFf+vUyU46R3w/A2gw6BcDeINzSv44Zzn470UlTXdUs1anLVhCGdIHOziEE=
X-Received: by 2002:a17:903:41ce:b0:269:7840:de09 with SMTP id
 d9443c01a7336-2697840dfa1mr1671995ad.10.1758117913958; Wed, 17 Sep 2025
 07:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
 <20250912055518.2719533-7-Prike.Liang@amd.com>
In-Reply-To: <20250912055518.2719533-7-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Sep 2025 10:05:02 -0400
X-Gm-Features: AS18NWD-eO3z0EKHL2faMxf_4RBVg_isvhT0M_h6UAA429ac_k__KZe42DF_faM
Message-ID: <CADnq5_Nm1BqRTe4eeZp7EinN01nunnX-4B1+qPWsZ2YYUn+y1w@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] drm/amdgpu: keeping waiting userq fence infinitely
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Fri, Sep 12, 2025 at 1:55=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Keeping waiting the userq fence infinitely untill
> hang detection, and then suspend the hang queue and
> set the fence error.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index cdcab71248d6..957b26ca2eb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -193,7 +193,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_m=
gr,
>         return r;
>  }
>
> -static void
> +static int
>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>                                  struct amdgpu_usermode_queue *queue)
>  {
> @@ -201,11 +201,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_user=
q_mgr *uq_mgr,
>         int ret;
>
>         if (f && !dma_fence_is_signaled(f)) {
> -               ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(=
100));
> -               if (ret <=3D 0)
> +               ret =3D dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIME=
OUT);
> +               if (ret <=3D 0) {
>                         drm_file_err(uq_mgr->file, "Timed out waiting for=
 fence=3D%llu:%llu\n",
>                                      f->context, f->seqno);
> +                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +                       return -ETIME;
> +               }
>         }
> +
> +       return ret;
>  }
>
>  static void
> --
> 2.34.1
>
