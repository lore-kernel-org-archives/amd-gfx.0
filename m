Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B362BCAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 20:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2517F10EA91;
	Fri, 19 Sep 2025 20:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LRNVsrtb";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E50010EA91
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 20:28:49 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-32ebcef552eso409985a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758313728; x=1758918528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxaQmrP9/aPHA+HEgqDefTrM2O5pB2ARy+ieKiBC7/c=;
 b=LRNVsrtbU/aqBvcX8GpR1nUUfzo5qu8f8h8b9r14bMl2luXOGj7cJzG938XmE+e419
 krvAaG2Y8NG/Xs347KI6cMjloLgLQ7Tipi1iLaXr5X06X9bpzilfKl4RHRp5LS07VHyH
 PSXXErcc/XO4ZjOWq3ktZ/6kHZYhtvqJBXbmG00EegrgfU+p6NLgVnVlBbnP8+0eKVsN
 WpN934yKQnm4DuG9NCphLVI49ATko7sIianFci4VtJMcff/hWHWG3pJiGuIgbmojfFWp
 Jvu8wW/KVEB2mNs0DZ/IF0lmx/KVD+nYW1y9OuD7QIuRm2xxSSNaOcNZAvZ2mZn/OGSM
 QZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758313728; x=1758918528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxaQmrP9/aPHA+HEgqDefTrM2O5pB2ARy+ieKiBC7/c=;
 b=qL2VkkZhBl0wuwjSTcKyISYzyHEu0XPND8rsiJ0LFHJnAf58iwn5ZDsbqU/gEguh8Z
 7Z0Rv0+f5TXCOaIkwp3lOqW8iZnxZwlxUJ0hVYJnrFg0PE36OpO3oj/V4b/cNA+0fgAp
 ZhJ969TIjwEFDsahO7totAJKojjq8bVeuX+KZD07vo0TyVFzWcF96/iOfM3aGcBMhbvy
 sGBJcS5PcefUCnwZo8rOhJKJNJfuA+DGRrvj9I4VfWFYJrZSstte6ggDCLBk/EG1h9Lp
 T5+ExqgZ4EEdOLdcYR6K7E//9YlU0p/gjzqsxvdqtKrBeri37qmh3S6vn9JWrVvaatU4
 cHWQ==
X-Gm-Message-State: AOJu0YywYRXPw3E86e+FMN2cU+nlMZ9eyYunpjHFBqyBPpCCCWtAmWVX
 w8mSxLpye0eMzh3RSTpo66+dtqi3m6+OgrLlR6cpVbgouBGXbrieKAL1ofHUqyVXzEi7/YeV0vH
 49eaUtdoBGvL5PAEAr/3LXXYJadnFec4=
X-Gm-Gg: ASbGncsV/LIw919IvPyNUrw5mgqdqa+KSYLixaPx/PogyV8e0T2aPuvtJWMn6qAP1Ny
 q8mdNj/20qOdciwYxxSqWGAd8DL87SvVff/lNVT/rm99raZGqhpiUP8wVYfusHz9KqFi4XRr9s/
 HQiN5bJUew6biEMrHSQPEKzuv2RwoZK301PuUkFkGgkF054P5c1Y+wp9j0+FXp5I5oxmqHjQuyi
 tSplaA=
X-Google-Smtp-Source: AGHT+IHFov8ZCBqLrFDABvyKaH34idRHmwvWHowpNWMygpWJxeN/Dcjy/P8XK6vWqRaT5RFfyPGAirWhtB6Wbueh6hk=
X-Received: by 2002:a17:90b:4a46:b0:330:944e:4814 with SMTP id
 98e67ed59e1d1-330983587e1mr3422062a91.5.1758313728564; Fri, 19 Sep 2025
 13:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250919081113.2797985-1-Prike.Liang@amd.com>
 <20250919081113.2797985-4-Prike.Liang@amd.com>
In-Reply-To: <20250919081113.2797985-4-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Sep 2025 16:28:36 -0400
X-Gm-Features: AS18NWCz639vp9FE9akYc6QCoBevvjiWZ0wSKrf0hNf0p6y_nXezHxdpILioOPw
Message-ID: <CADnq5_MbEzBy0e3h+U4PFdY3Eo-fvPcps3NkGXvmfKEsahGhxw@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] drm/amdgpu: keeping waiting userq fence
 infinitely
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

On Fri, Sep 19, 2025 at 4:11=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Keeping waiting the userq fence infinitely until
> hang detection, and then suspend the hang queue and
> set the fence error.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Patches 1-4 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 790f51d2b8f2..9cdb82c13a34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -232,7 +232,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_m=
gr,
>         return r;
>  }
>
> -static void
> +static int
>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>                                  struct amdgpu_usermode_queue *queue)
>  {
> @@ -240,11 +240,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_user=
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
